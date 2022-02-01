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

local boldgreen="%{$fg_bold[green]%}"
local green="%{$fg_no_bold[green]%}"
local boldred="%{$fg_bold[red]%}"
local red="%{$fg_no_bold[red]%}"
local boldcyan="%{$fg_bold[cyan]%}"
local cyan="%{$fg_no_bold[cyan]%}"
local boldyellow="%{$fg_bold[yellow]%}"
local yellow="%{$fg_no_bold[yellow]%}"
local boldblue="%{$fg_bold[blue]%}"
local blue="%{$fg_no_bold[blue]%}"
local boldmagenta="%{$fg_bold[magenta]%}"
local magenta="%{$fg_no_bold[magenta]%}"
local boldwhite="%{$fg_bold[white]%}"
local white="%{$fg_no_bold[white]%}"
local bolddefault="%{$fg_bold[default]%}"
local default="%{$fg_no_bold[default]%}"
local reset="%{$reset_color%}"

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

local _PATH="$boldcyan%c$reset"
local _JOBS="${blue}fg:${bolddefault}%j$reset"
local _EXIT="%(?.$boldgreen.$boldred)$returnsymbol"

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
