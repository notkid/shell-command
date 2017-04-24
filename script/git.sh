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
    echo 'Must input a new branch name'
    return
  fi

  if [ -z "${BASE_BRANCH}" ]; then
    BASE_BRANCH="master"
  fi

  notkid-run "git checkout ${BASE_BRANCH}"
  notkid-run "git fetch"
  notkid-run "git merge origin/${BASE_BRANCH}"
  notkid-run "git push origin HEAD:${NEW_BRANCH}"
  notkid-run "git checkout ${NEW_BRANCH}"
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
