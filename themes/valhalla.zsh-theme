# theme inspired by:
# https://github.com/robbyrussell/oh-my-zsh/blob/master/themes/robbyrussell.zsh-theme
# https://github.com/robbyrussell/oh-my-zsh/blob/master/themes/bureau.zsh-theme

### Symbols 

if [ $TERM = "linux" ] || [ $TERM = "screen" ]; then
    returnsymbol=\>
    dirtysymbol=X
    stashsymbol=^
else
    returnsymbol=➜
    dirtysymbol=✖
    stashsymbol=⚑
fi

### Colors

boldgreen="%{$fg_bold[green]%}"
green="%{$fg_no_bold[green]%}"
boldred="%{$fg_bold[red]%}"
red="%{$fg_no_bold[red]%}"
boldcyan="%{$fg_bold[cyan]%}"
cyan="%{$fg_no_bold[cyan]%}"
boldyellow="%{$fg_bold[yellow]%}"
yellow="%{$fg_no_bold[yellow]%}"
boldblue="%{$fg_bold[blue]%}"
blue="%{$fg_no_bold[blue]%}"
boldmagenta="%{$fg_bold[magenta]%}"
magenta="%{$fg_no_bold[magenta]%}"
boldwhite="%{$fg_bold[white]%}"
white="%{$fg_no_bold[white]%}"
bolddefault="%{$fg_bold[default]%}"
default="%{$fg_no_bold[default]%}"
reset="%{$reset_color%}"

### Virtualenv

ZSH_THEME_VIRTUALENV_PREFIX="$blue:$boldgreen"
ZSH_THEME_VIRTUALENV_SUFFIX="$reset "

### Git

ZSH_THEME_GIT_PROMPT_PREFIX="${blue}git:($boldred"
ZSH_THEME_GIT_PROMPT_SUFFIX="$reset "
ZSH_THEME_GIT_PROMPT_CLEAN="$blue)"
ZSH_THEME_GIT_PROMPT_DIRTY="$blue)$boldyellow$dirtysymbol"
ZSH_THEME_GIT_PROMPT_STASHED="$stashsymbol"

show_git_branch () {
  local ref
  ref=$(__git_prompt_git symbolic-ref HEAD 2> /dev/null) || \
  ref=$(__git_prompt_git rev-parse --short HEAD 2> /dev/null) || return
  echo "${ref#refs/heads/}"
}

show_git_status() {
  local result

  if $(__git_prompt_git rev-parse --verify refs/stash &> /dev/null); then
    result+="$ZSH_THEME_GIT_PROMPT_STASHED"
  fi

  echo $result
}

show_git_prompt() {
  local gitbranch=$(show_git_branch)
  local gitstatus=$(show_git_status)
  local gitdirty=$(parse_git_dirty)
  local info

  if [[ -z "$gitbranch" ]]; then
    return
  fi

  info="${gitbranch:gs/%/%%}"

  if [[ -n "$gitstatus" ]]; then
    info+="$gitstatus"
  fi

  if [[ -n "$gitdirty" ]]; then
    info+="$gitdirty"
  fi

  echo "${ZSH_THEME_GIT_PROMPT_PREFIX}${info}${ZSH_THEME_GIT_PROMPT_SUFFIX}"
}

_PATH="$boldcyan%c$reset"
_JOBS="${blue}fg:${bolddefault}%j$reset"
_EXIT="%(?.$boldgreen.$boldred)$returnsymbol"

if [[ $EUID -eq 0 ]]; then
  _USERNAME="$boldred%n"
  _LIBERTY="$red#"
else
  _USERNAME="$boldwhite%n"
  _LIBERTY="$reset$"
fi
_USERNAME="$_USERNAME$reset"
_LIBERTY="$_LIBERTY$reset"
_HOSTNAME="%m"

PROMPT='$_EXIT '
#PROMPT+='$_USERNAME '
PROMPT+='$_PATH '
PROMPT+='%1(j.$_JOBS .)'
PROMPT+='$(virtualenv_prompt_info)'
PROMPT+='$(show_git_prompt)'
PROMPT+='$_LIBERTY '
