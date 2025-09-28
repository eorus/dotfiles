#!/bin/bash
echo "Tag and Remove emails deleted from inbox"
notmuch new --no-hooks
notmuch tag +deleted -- path:gmail/Trash/cur
notmuch tag +archive -inbox -- folder:"gmail/archive" and not folder:'gmail/INBOX' and not tag:archive
