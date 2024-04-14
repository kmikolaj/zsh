# initialize autocompletion
autoload -Uz compinit && compinit -d $ZSH_COMPDUMP

zmodload -i zsh/complist

setopt nomenucomplete # don't turn this on
setopt nocompletealiases # don't understand this reverse logic
setopt automenu # don't turn this off
setopt nolistambiguous
setopt nobashautolist
setopt noautolist
setopt autoparamslash
setopt completeinword
setopt alwaystoend
setopt nocaseglob

# menu
zstyle ':completion:*:*:*:*:*' menu select

# use verbose listings when we have more information
zstyle ':completion:*' verbose true

# colors in completion menu
#zstyle ':completion:*' list-colors ''

# partial completion suggestions
zstyle ':completion:*' list-suffixes true

# complete . and .. special directories
zstyle -e ':completion:*' special-dirs '[[ $PREFIX = (../)#(|.|..) ]] && reply=(..)'

zstyle ':completion:*:*:kill:*:processes' list-colors '=(#b) #([0-9]#) ([0-9a-z-]#)*=01;34=0=01'
zstyle ':completion:*:*:*:*:processes' command "ps -u $USERNAME -o pid,user,comm -w -w"

# disable named-directories autocompletion
zstyle ':completion:*:cd:*' tag-order local-directories directory-stack path-directories

# completers
zstyle ':completion:*' completer _oldlist _expand _extensions _complete
zstyle ':completion:*:approximate:*' max-errors 1 numeric
zstyle ':completion:*:expand:*' tag-order expansions

# case sensitive
#zstyle ':completion:*' matcher-list '' 'm:{[:lower:]}={[:upper:]}' 'r:|[._-]=* r:|=*' 'l:|=* r:|=*'

# case insensitive
#zstyle ':completion:*' matcher-list 'm:{[:lower:]}={[:upper:]}' 'm:{[:lower:]}={[:upper:]} r:|[._-]=* r:|=*' 'm:{[:lower:]}={[:upper:]} l:|=* r:|=*'

# case insensitive + hyphen insensitive
#zstyle ':completion:*' matcher-list 'm:{[:lower:]_-}={[:upper:]_-}' 'm:{[:lower:]}={[:upper:]} r:|[._-]=* r:|=*' 'm:{[:lower:]}={[:upper:]} l:|=* r:|=*'

# case insensitive + hyphen insensitive + match partial phrase
# https://www.reddit.com/r/zsh/comments/11dqx3e/i_want_to_tab_complete_partials_words_with_no/
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}' 'm:{a-z}={A-Z} r:|[._-]=* r:|=*' 'm:{a-z}={A-Z} l:|=* r:|=*'

# fuzzy
#zstyle ':completion:*' matcher-list 'r:|?=**'

# rehash
zstyle ':completion:*' rehash true

# complete manual by their section
zstyle ':completion:*:manuals' separate-sections true
zstyle ':completion:*:manuals.*' insert-sections true
zstyle ':completion:*:man:*' menu yes select

# vim ignore binary files
zstyle ':completion:*:*:vim:*:*files' ignored-patterns '*.(pyc|o)'
zstyle ':completion:*:*:nvim:*:*files' ignored-patterns '*.(pyc|o)'

# ignore completion functions for commands you don't have
zstyle ':completion:*:functions' ignored-patterns '_*'

# cache
zstyle ':completion:*' use-cache yes
zstyle ':completion:*' cache-path $ZSH_CACHE_DIR

# host completion /* add brackets as vim can't parse zsh's complex cmdlines 8-) {{{ */
[ -r ~/.ssh/known_hosts ] && _ssh_hosts=(${${${${(f)"$(<$HOME/.ssh/known_hosts)"}:#[\|]*}%%\ *}%%,*}) || _ssh_hosts=()
[ -r /etc/hosts ] && : ${(A)_etc_hosts:=${(s: :)${(ps:\t:)${${(f)~~"$(</etc/hosts)"}%%\#*}##[:blank:]#[^[:blank:]]#}}} || _etc_hosts=()

hosts=(`hostname` "$_ssh_hosts[@]" "$_etc_hosts[@]" localhost)
zstyle ':completion:*:hosts' hosts $hosts

# automatically load bash completion functions
autoload -U +X bashcompinit && bashcompinit
