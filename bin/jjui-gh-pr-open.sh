CHANGE_ID="$1"

BOOKMARK=$(jj log --no-graph -T "self.bookmarks()" -r "$CHANGE_ID")
SANITIZED_BOOKMARK="${BOOKMARK%%\*}"

PR_LINK=$(gh pr create --fill-verbose --head "${SANITIZED_BOOKMARK}" 2>&1 | rg https)

open "${PR_LINK}"
