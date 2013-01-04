#!/bin/zsh

# Need this so the prompt will work.
setopt prompt_subst
setopt extended_glob

# Use colors.
autoload colors && colors

directory_name() {
  echo "%{$fg[blue]%}%~%\/%{$reset_color%}"
}

git_branch() {
 ref=$(/usr/bin/git symbolic-ref HEAD 2>/dev/null) || return
 echo "${ref#refs/heads/}"
}

unpushed () {
  /usr/bin/git cherry -v origin/$(git_branch) 2>/dev/null
}

need_push() {
  if [[ $(unpushed) == "" ]]
  then
    echo " "
  else
    echo "%{$reset_color%} with %{$fg_bold[magenta]%}unpushed%{$reset_color%} "
  fi
}

git_status() {
  st=$(/usr/bin/git status 2>/dev/null | tail -n 1)
  if [[ $st == "" ]]
  then
    echo ""
  else
    if [[ $st == "nothing to commit (working directory clean)" ]]
    then
      echo "on %{$fg_bold[green]%}$(git_branch)$(need_push)%{$reset_color%}"
    else
      echo "on %{$fg_bold[red]%}$(git_branch)$(need_push)%{$reset_color%}"
    fi
  fi
}

ruby_version() {
  if $(which rbenv &> /dev/null)
  then
    echo "%{$fg_bold[yellow]%}$(rbenv version | awk '{print $1}')%{$reset_color%}"
  else
    echo ""
  fi
}

precmd() {
  set_prompt
}

preexec() {
}

set_prompt() {
  PROMPT=$'\n'$(directory_name)' '$(git_status)$'\n'$(ruby_version)' › '
}

set_prompt
