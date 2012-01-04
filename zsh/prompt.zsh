autoload colors && colors
# cheers, @ehrenmurdick
# http://github.com/ehrenmurdick/config/blob/master/zsh/prompt.zsh

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

rvm_prompt(){
  if $(which rvm &> /dev/null)
  then
    echo "%{$fg_bold[yellow]%}$(rvm tools identifier)%{$reset_color%}"
  else
    echo ""
  fi
}

# Count the number of TODO items in the current project, placed on the right
# side of my prompt.
todo(){
  st=$(/usr/bin/git status 2>/dev/null | tail -n 1)
  if [[ $st == "" ]]
  then
    echo ""
  else
    ack --count --ignore-dir=.bundle TODO | awk '{split($0,a,":"); sum+=a[2]} END {print sum}'
  fi
}

directory_name(){
  echo "%{$fg[blue]%}%~%\/%{$reset_color%}"
}

time_for_prompt(){
  echo "%{$fg[yellow]%}%D{%I:%M %p}%{$reset_color%}"
}

prompt_type(){
  if [[ $(whoami) == "root" ]]
  then
    echo "%{$fg[red]%}#%{$reset_colors%}"
  else
    echo "%{$fg_bold[magenta]%}›%{$reset_colors%}"
  fi
}

export PROMPT=$'\n$(directory_name) $(git_dirty)$(need_push)\n[($(time_for_prompt)) %n@%m] $(prompt_type) '

set_prompt () {
  export RPROMPT="%{$fg_bold[cyan]%}%{$reset_color%}"
}

precmd() {
  title "zsh" "%m" "%55<...<%~"
  set_prompt
}
