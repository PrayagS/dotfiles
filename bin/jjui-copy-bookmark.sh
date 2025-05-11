CHANGE_ID="$1"

jj log --no-graph -T "self.bookmarks()" -r "$CHANGE_ID" | pbcopy
