find_git_branch() {
  # Based on: http://stackoverflow.com/a/13003854/170413
  local branch
  branch=$(git rev-parse --abbrev-ref HEAD 2> /dev/null)
  if [ ! -z "$branch" ]; then
     if [[ "$branch" == "HEAD" ]]; then
       branch='detached*'
     fi
     git_branch="($branch)"
  else
    git_branch=""
  fi
}

find_git_dirty() {
  #local status=$(git status --porcelain 2> /dev/null)
  #if [[ "$status" != "" ]]; then
  if [ ! -z "$git_branch" ]; then
    if [[ $(git diff --stat) != '' ]]; then
      git_dirty='*'
    else
      git_dirty=''
    fi
  else
    git_dirty=''
  fi
}

get_context() {
  context=$(kubectl config current-context)
}

##PROMPT_COMMAND="find_git_branch; find_git_dirty; $PROMPT_COMMAND"
PROMPT_COMMAND="find_git_branch; find_git_dirty; get_context; $PROMPT_COMMAND"
#
## Default Git enabled prompt with dirty state
## export PS1="\u@\h \w \[$txtcyn\]\$git_branch\[$txtred\]\$git_dirty\[$txtrst\]\$ "
#
## Another variant:
## export PS1="\[$bldgrn\]\u@\h\[$txtrst\] \w \[$bldylw\]\$git_branch\[$txtcyn\]\$git_dirty\[$txtrst\]\$ "
#
## Default Git enabled root prompt (for use with "sudo -s")
## export SUDO_PS1="\[$bakred\]\u@\h\[$txtrst\] \w\$ "
