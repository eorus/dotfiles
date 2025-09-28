#!/usr/bin/env bash
# notmuch-sync.sh — sync, move, tag emails with notifications
set -euo pipefail
IFS=$'\n\t'
PATH="/usr/bin:/bin:/usr/local/bin:$HOME/.local/bin"

LOCK="/tmp/notmuch-sync.lock"
exec 9>"$LOCK"
flock -n 9 || { printf '%s\n' "notmuch-sync: another instance is running" >&2; exit 0; }

LOG_DIR="${XDG_STATE_HOME:-$HOME/.local/state}/notmuch"
LOG="$LOG_DIR/notmuch-sync.log"
mkdir -p "$LOG_DIR"
chmod 700 "$LOG_DIR"

# Log rotation: keep last 50K
if [ -f "$LOG" ] && [ "$(stat -c %s "$LOG")" -gt $((50*1024)) ]; then
  mv "$LOG" "$LOG.$(date -u +%Y%m%dT%H%M%SZ)"
  : >"$LOG"
fi

ts(){ date -u +"%Y-%m-%dT%H:%M:%SZ"; }
log(){ msg="[$(ts)] $*"; echo "$msg" >>"$LOG"; [[ -t 1 ]] && echo "$msg" >&2; }

# Preconditions
cmds=(notmuch mbsync)
for c in "${cmds[@]}"; do
  if ! command -v "$c" >/dev/null 2>&1; then
    log "ERROR: required command '$c' not found"
    exit 1
  fi
done

NOTMUCH_MOVE="${HOME}/.local/bin/notmuch-move.sh"
NOTMUCH_TAG="${HOME}/.local/bin/notmuch-tag.sh"

log "START notmuch-sync"

# 1) Update DB (no hooks)
if ! notmuch new --no-hooks >>"$LOG" 2>&1; then
  log "WARN: notmuch new --no-hooks failed (continuing)"
fi

# 2) Custom move
if [[ -x "$NOTMUCH_MOVE" ]]; then
  if ! "$NOTMUCH_MOVE" >>"$LOG" 2>&1; then
    log "WARN: notmuch-move.sh failed (continuing)"
  else
    log "notmuch-move.sh completed"
  fi
else
  log "notmuch-move.sh not present, skipping"
fi

# 3) Sync mail
if ! mbsync -a >>"$LOG" 2>&1; then
  log "ERROR: mbsync failed"
  exit 2
fi
log "mbsync completed"

# 4) Tagging
if [[ -x "$NOTMUCH_TAG" ]]; then
  if ! "$NOTMUCH_TAG" >>"$LOG" 2>&1; then
    log "WARN: notmuch-tag.sh failed"
  else
    log "notmuch-tag.sh completed"
  fi
else
  log "notmuch-tag.sh not present, running inline tagging"

  log "inline: notmuch new --quiet"
  notmuch new --quiet >>"$LOG" 2>&1 || log "WARN: notmuch new --quiet failed"

  log "inline: batch tagging rules"
  notmuch tag \
    +inbox             -- 'folder:gmail/INBOX and tag:new' \
    -new               -- 'tag:new' \
    +spam              -- 'folder:gmail/spam' \
    -new -inbox +sent  -- "from:alperor@gmail.com" \
    +important         -- 'tag:flagged' \
    -important         -- 'tag:important and not tag:flagged and folder:gmail/INBOX' \
    +archive -inbox    -- 'folder:gmail/archive and not folder:gmail/INBOX and not tag:archive' \
    -inbox -unread +deleted -- 'folder:gmail/Trash' \
    +inbox +unread -new    -- 'tag:new' \
    >>"$LOG" 2>&1 || log "WARN: inline tagging encountered errors"
fi

# 5) Notifications
count=$(notmuch count 'tag:unread and tag:inbox' 2>/dev/null || echo 0)

if [ "$count" -gt 0 ]; then
  ICON="/usr/share/doc/neomutt/logo/neomutt.svg"
  [ -f "$ICON" ] || ICON="mail-unread"

  if command -v notify-send >/dev/null 2>&1; then
    if [ -n "${DBUS_SESSION_BUS_ADDRESS:-}" ] || [ -n "${DISPLAY:-}" ]; then
      notify-send -u normal -i "$ICON" "$count new emails" && log "notified: $count new emails"
    else
      log "skipped notify-send: no DBUS session or DISPLAY"
    fi
  else
    log "skipped notify: notify-send not installed"
  fi
fi

log "END notmuch-sync"
exit 0
