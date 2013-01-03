autoload colors && colors

directory_name(){
  echo "%{$fg_bold[cyan]%}%~%\/%{$reset_color%}"
}

git_branch() {
  echo $(/usr/bin/git symbolic-ref HEAD 2>/dev/null | awk -F/ {'print $NF'})
}

git_tracking() {
  st=$(/usr/bin/git status -sb 2>/dev/null | tail -n 1 | grep behind)
  if [[ $st == "" ]]
  then
    echo ""
  else
    echo "ˆ"
  fi
}

git_dirty() {
  st=$(/usr/bin/git status 2>/dev/null | tail -n 1)
  if [[ $st == "" ]]
  then
    echo ""
  else
    if [[ $st == "nothing to commit (working directory clean)" ]]
    then
      echo "on %{$fg[green]%}$(git_prompt_info)%{$reset_color%}"
    else
      echo "on %{$fg[yellow]%}$(git_prompt_info)*%{$reset_color%}"
    fi
  fi
}

git_prompt_info () {
 ref=$(/usr/bin/git symbolic-ref HEAD 2>/dev/null) || return
  echo "${ref#refs/heads/}"
}

unpushed () {
  /usr/bin/git cherry -v origin/$(git_branch) 2>/dev/null
}

need_push () {
  if [[ $(unpushed) == "" ]]
  then
    echo " "
  else
    echo " with %{$fg[magenta]%}unpushed%{$reset_color%} "
  fi
}

rb_prompt(){
  if $(which rbenv &> /dev/null)
  then
    echo "%{$fg_bold[magenta]%}$(rbenv version | awk '{print $1}')%{$reset_color%}"
  else
    echo ""
  fi
}

TOP_LINE=$(directory_name)' '$(git_dirty)
BOTTOM_LINE=$(rb_prompt)' › '

export PROMPT=$'\n'${TOP_LINE}$'\n'${BOTTOM_LINE}
