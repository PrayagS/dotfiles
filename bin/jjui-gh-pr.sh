CHANGE_ID="$1"

BOOKMARK=$(jj log --no-graph -T "self.bookmarks()" -r "$CHANGE_ID" | choose 0)

gh pr create --fill-verbose --head ${BOOKMARK} | pbcopy
