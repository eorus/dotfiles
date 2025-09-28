#!/usr/bin/env bash
set -euo pipefail
IFS=$'\n\t'

LOG="${HOME}/.local/share/email/notmuch-move.log"
mkdir -p "$(dirname "$LOG")"

echo "[$(date -Iseconds)] notmuch-move: start" >>"$LOG"

# Update notmuch DB (no hooks to avoid repeating work)
notmuch new --no-hooks >>"$LOG" 2>&1

echo "[$(date -Iseconds)] tagging deleted messages" >>"$LOG"
# Tag messages that are in the local gmail Trash folder as deleted
notmuch tag +deleted -- folder:"gmail/Trash/cur" >>"$LOG" 2>&1 || true

echo "[$(date -Iseconds)] tagging archived messages" >>"$LOG"
# Mark messages in your gmail archive folder as archive, but avoid marking INBOX messages
# Use correct quoting for the query
notmuch tag +archive -inbox -- 'folder:gmail/archive and not folder:gmail/INBOX and not tag:archive' >>"$LOG" 2>&1 || true

echo "[$(date -Iseconds)] notmuch-move: done" >>"$LOG"
