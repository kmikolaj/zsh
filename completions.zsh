# initialize autocompletion
autoload -Uz compinit && compinit

zmodload -i zsh/complist

# completion override
fpath=($HOME/.zsh/completions $fpath)

unsetopt menu_complete
unsetopt flowcontrol
setopt auto_menu
setopt complete_in_word
setopt always_to_end

# menu
zstyle ':completion:*:*:*:*:*' menu select

# colors in completion menu
#zstyle ':completion:*' list-colors ''

# complete . and .. special directories
zstyle -e ':completion:*' special-dirs '[[ $PREFIX = (../)#(|.|..) ]] && reply=(..)'

zstyle ':completion:*:*:kill:*:processes' list-colors '=(#b) #([0-9]#) ([0-9a-z-]#)*=01;34=0=01'
zstyle ':completion:*:*:*:*:processes' command "ps -u $USERNAME -o pid,user,comm -w -w"

# disable named-directories autocompletion
zstyle ':completion:*:cd:*' tag-order local-directories directory-stack path-directories

zstyle ':completion:*' completer _oldlist _expand _complete _files

# fix tab-completion: files with _ and ' ' in names
#zstyle ':completion:*' matcher-list '' 'm:{[:lower:]}={[:upper:]}' 'r:|[.,_-]=* r:|=*' 'l:|=* r:|=*'
#zstyle ':completion:*' matcher-list '' 'm:{a-z}={A-Z}' 'm:{a-z}={A-Z} r:|[._-]=* r:|=*' 'l:|=* r:|=*'

# case insensitive
#zstyle ':completion:*' matcher-list '' 'm:{a-z}={A-Z}' 'm:{a-z}={A-Z} r:|[._-]=* r:|=*' 'm:{a-z}={A-Z} l:|=* r:|=*'
zstyle ':completion:*' matcher-list '' 'm:{[:lower:]}={[:upper:]}' 'm:{[:lower:]}={[:upper:]} r:|[._-]=* r:|=*' 'm:{[:lower:]}={[:upper:]} l:|=* r:|=*'

# rehash
zstyle ':completion:*' rehash true

# complete manual by their section
zstyle ':completion:*:manuals' separate-sections true
zstyle ':completion:*:manuals.*' insert-sections   true
zstyle ':completion:*:man:*' menu yes select

# cache
#zstyle ':completion:*' use-cache yes
#zstyle ':completion:*' cache-path $ZSH_CACHE_DIR

# host completion /* add brackets as vim can't parse zsh's complex cmdlines 8-) {{{ */
[ -r ~/.ssh/known_hosts ] && _ssh_hosts=(${${${${(f)"$(<$HOME/.ssh/known_hosts)"}:#[\|]*}%%\ *}%%,*}) || _ssh_hosts=()
[ -r /etc/hosts ] && : ${(A)_etc_hosts:=${(s: :)${(ps:\t:)${${(f)~~"$(</etc/hosts)"}%%\#*}##[:blank:]#[^[:blank:]]#}}} || _etc_hosts=()

hosts=(`hostname` "$_ssh_hosts[@]" "$_etc_hosts[@]" localhost)
zstyle ':completion:*:hosts' hosts $hosts

# automatically load bash completion functions
autoload -U +X bashcompinit && bashcompinit
