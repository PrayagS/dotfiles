CHANGE_ID="$1"

BOOKMARK=$(jj log --no-graph -T "self.bookmarks()" -r "$CHANGE_ID")

gh pr create --fill-verbose --head ${BOOKMARK} | pbcopy
