function notkid-load-script {
  local _notkid_path=$1
  source "$_notkid_path/script/git.sh"
  source "$_notkid_path/script/auto_workflow.sh"
  source "$_notkid_path/script/runtime.sh"
  source "$_notkid_path/script/ssh.sh"
}

function notkid-load {
  local _notkid_path="$1/.notkid"

   [[ -s $_notkid_path ]] && source $_notkid_path
}
