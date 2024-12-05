#!/bin/sh
echo "Importing new mail"
notmuch new --quiet

echo "Tagging new inboxed mail"
notmuch tag +inbox -- folder:gmail/INBOX and tag:new
notmuch tag -new -- tag:new

echo "Tagging spam"
notmuch tag --remove-all +spam -- folder:gmail/spam

echo "Moving messages"
# Mark sent mails as not inbox, but sent
notmuch tag -new -inbox +sent -- from:alperor@gmail.com
notmuch tag +important -- tag:flagged
notmuch tag -important -- tag:flagged

# If its already been archived, mark it as such
notmuch tag +archive -inbox -- "folder:gmail/archive and not folder:gmail/INBOX and not tag:archive"

# If its already in trash, remove it from the inbox
notmuch tag -inbox -unread +deleted -- 'folder:gmail/Trash'

echo "Re-tag all messages"
# finally, retag all "new" messages "inbox" and "unread"
notmuch tag +inbox +unread -new -- tag:new

echo "Complete."

count=$(notmuch count tag:unread and tag:inbox)
if [[ $count -gt 0 ]]; then
    notify-send -i /usr/share/doc/neomutt/logo/neomutt.svg "$count new emails"
fi

exit
