CHANGE_ID="$1"

SUBJECT=$(jj log --no-graph -T "self.description().first_line()" -r "${CHANGE_ID}")
jj log --no-graph -T "self.description().remove_prefix(description.first_line()).trim_start()" -r "${CHANGE_ID}" > /tmp/jj-revision-desc-body

BOOKMARK=$(jj log --no-graph -T "self.bookmarks()" -r "$CHANGE_ID")
SANITIZED_BOOKMARK="${BOOKMARK%%\*}"

PR_LINK=$(gh pr create --fill-verbose --head "${SANITIZED_BOOKMARK}" 2>&1 | rg https)

gh pr merge \
  --body-file /tmp/jj-revision-desc-body \
  --subject "${SUBJECT}" \
  --admin \
  --squash \
  --delete-branch \
  "${PR_LINK}"

# [TODO]: fetch and rebase
