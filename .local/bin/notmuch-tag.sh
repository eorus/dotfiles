#!/usr/bin/env bash
set -euo pipefail
IFS=$'\n\t'

LOG="${HOME}/.local/share/email/notmuch-tag.log"
mkdir -p "$(dirname "$LOG")"

ts() { date -Iseconds; }
echo "[$(ts)] notmuch-tag: start" >>"$LOG"

# Update DB quietly
notmuch new --quiet >>"$LOG" 2>&1 || true

echo "[$(ts)] tagging new inboxed mail" >>"$LOG"
# Tag new incoming messages that are in gmail/INBOX
notmuch tag +inbox -- 'folder:gmail/INBOX and tag:new' >>"$LOG" 2>&1 || true
notmuch tag -new -- 'tag:new' >>"$LOG" 2>&1 || true

echo "[$(ts)] tagging spam" >>"$LOG"
# Add spam tag to everything in gmail/spam (and remove other conflicting tags if needed)
notmuch tag +spam -- 'folder:gmail/spam' >>"$LOG" 2>&1 || true

echo "[$(ts)] marking sent messages" >>"$LOG"
# Mark sent messages (sent from your address) as sent and remove from inbox/new
notmuch tag -new -inbox +sent -- "from:alperor@gmail.com" >>"$LOG" 2>&1 || true

echo "[$(ts)] syncing flagged/important tags" >>"$LOG"
# Mirror mutt/notmuch flag -> important tag and vice versa
notmuch tag +important -- 'tag:flagged' >>"$LOG" 2>&1 || true
notmuch tag -important -- 'not tag:flagged' >>"$LOG" 2>&1 || true

echo "[$(ts)] ensuring archived messages are tagged" >>"$LOG"
notmuch tag +archive -inbox -- 'folder:gmail/archive and not folder:gmail/INBOX and not tag:archive' >>"$LOG" 2>&1 || true

echo "[$(ts)] moving trash messages out of inbox/unread" >>"$LOG"
notmuch tag -inbox -unread +deleted -- 'folder:gmail/Trash' >>"$LOG" 2>&1 || true

echo "[$(ts)] final retagging for new messages" >>"$LOG"
# Finally, ensure any still-tagged-new messages become inbox/unread (if desired)
notmuch tag +inbox +unread -new -- 'tag:new' >>"$LOG" 2>&1 || true

echo "[$(ts)] notmuch-tag: done" >>"$LOG"

# Notify user if there are unread/inbox messages (graphical only)
count=$(notmuch count "tag:unread and tag:inbox" || echo 0)
if command -v notify-send >/dev/null 2>&1 && [ -n "${DISPLAY:-}" ]; then
  if [ "${count:-0}" -gt 0 ]; then
    notify-send -i /usr/share/doc/neomutt/logo/neomutt.svg "$count new emails"
  fi
fi
