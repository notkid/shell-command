function notkid-git-commit {
  local MESSAGE=$1
  local AUTHOR=$2

  if [ -z "$MESSAGE" ]; then
  MESSAGE="No Message."
  fi

  git add .

  if [ -n "$AUTHOR" ]; then
    git commit -am $MESSAGE --author=$AUTHOR
  else
    git commit -am $MESSAGE
  fi
}

function notkid-git-branch-create {
  NEW_BRANCH=$1
  BASE_BRANCH=$2

  if [ -z "${NEW_BRANCH}" ]; then
    NEW_BRANCH=$(date +'%Y%m%d%H%M%S')
  fi

  if [ -z "${BASE_BRANCH}" ]; then
    BASE_BRANCH="develop"
  fi

  notkid-run "git fetch upstream"
  notkid-run "git checkout develop"
  notkid-run "git stash"
  notkid-run "git rebase upstream/develop"
  notkid-run "git push"
  notkid-run "git checkout ${BASE_BRANCH}"
  notkid-run "git fetch"
  notkid-run "git merge origin/${BASE_BRANCH}"
  notkid-run "git push origin HEAD:${NEW_BRANCH}"
  notkid-run "git checkout ${NEW_BRANCH}"
  notkid-run "git stash pop"
}

function notkid-git-branch-remove {
  BRANCH_NAME=$1

  if [ -z "${BRANCH_NAME}" ]; then
    echo 'Must input a branch name'
    return
  fi

  notkid-run "git branch -D ${BRANCH_NAME}"
  notkid-run "git push origin :${BRANCH_NAME}"
}

function notkid-delete-local-branch {
  notkid-run "git branch |grep -iv develop |xargs git branch -D"
}

function notkid-pull-request {
  BRANCH=$1
  COMMIT=$2

  if [ -z "${BRANCH}" ]; then
    echo 'please input your branch name'
    return
  fi

  if [ -z "${COMMIT}" ]; then
    echo 'please input your commit'
    return
  fi

  notkid-run "git fetch upstream"
  notkid-run "git stash"
  notkid-run "git rebase upstream/master"
  notkid-run "git push origin ${BRANCH}:${COMMIT}"
  notkid-run "git fetch upstream"

}
