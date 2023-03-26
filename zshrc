# ZSH Config

# Zinit
### Added by Zinit's installer
if [[ ! -f $HOME/.local/share/zinit/zinit.git/zinit.zsh ]]; then
    print -P "%F{33} %F{220}Installing %F{33}ZDHARMA-CONTINUUM%F{220} Initiative Plugin Manager (%F{33}zdharma-continuum/zinit%F{220})…%f"
    command mkdir -p "$HOME/.local/share/zinit" && command chmod g-rwX "$HOME/.local/share/zinit"
    command git clone https://github.com/zdharma-continuum/zinit "$HOME/.local/share/zinit/zinit.git" && \
        print -P "%F{33} %F{34}Installation successful.%f%b" || \
        print -P "%F{160} The clone has failed.%f%b"
fi

source "$HOME/.local/share/zinit/zinit.git/zinit.zsh"
autoload -Uz _zinit
(( ${+_comps} )) && _comps[zinit]=_zinit

# Load a few important annexes, without Turbo
# (this is currently required for annexes)
zinit light-mode for \
    zdharma-continuum/zinit-annex-as-monitor \
    zdharma-continuum/zinit-annex-bin-gem-node \
    zdharma-continuum/zinit-annex-patch-dl \
    zdharma-continuum/zinit-annex-rust

### End of Zinit's installer chunk

# Disable flow control
stty -ixon <$TTY >$TTY
stty -ixoff <$TTY >$TTY

# Plugins
zinit light jocelynmallon/zshmarks
zinit light kmikolaj/careful_rm
zinit light zsh-users/zsh-autosuggestions
zinit light zsh-users/zsh-completions
zinit light zsh-users/zsh-syntax-highlighting
#zinit light zsh-users/zsh-history-substring-search
zinit light wizard-28/git-flow-completion
zinit light kmikolaj/lesspipe
zinit ice depth=1
zinit light romkatv/powerlevel10k

# Colors
if [ -z $DISPLAY ] && [ -z $WAYLAND_DISPLAY ]; then
	eval "`dircolors`"
else
	eval "`dircolors ~/.dircolors`"
fi

# MIME
#autoload -U zsh-mime-setup
#zsh-mime-setup

# completion override
fpath=($HOME/.zsh/config/completions $fpath)

# Quotes when handling urls
autoload -U url-quote-magic bracketed-paste-magic
zle -N self-insert url-quote-magic
zle -N bracketed-paste bracketed-paste-magic

export HISTFILE=$HOME/.zsh/history
export HISTSIZE=50000
export SAVEHIST=10000
export EDITOR=vim
#export BROWSER=firefox
export MAKEFLAGS="-j$(nproc)"

# Options
setopt appendhistory
#setopt incappendhistory
setopt extendedhistory
setopt nosharehistory
setopt autocd
setopt extendedglob
setopt nonomatch
setopt notify
setopt alwaystoend
setopt nocorrect
setopt check_jobs
setopt autopushd
setopt pushdignoredups
setopt pushdsilent
setopt multios
setopt histignorealldups
setopt histignorespace
setopt histverify
#setopt printexitvalue
setopt nobeep
setopt nointeractivecomments

# disable use of # in extended globing
disable -p '#'

# unlimited coredump
limit coredumpsize 0

# more secure umask
umask 027

# universal tab size
tabs -0
tabs -4

# Environment
source ${HOME}/.zsh/config/environment.zsh

# Aliases
source ${HOME}/.zsh/config/aliases.zsh

# Completions
source ${HOME}/.zsh/config/completions.zsh

# Keys
source ${HOME}/.zsh/config/keyboard.zsh

# Functions
source ${HOME}/.zsh/config/functions.zsh

# Plugins
source ${HOME}/.zsh/config/plugins.zsh

# Directories
source ${HOME}/.zsh/config/directories.zsh

# Hostname specific
if [ -e "${HOME}/.zsh/config/$(hostname).zsh" ]; then
	source "${HOME}/.zsh/config/$(hostname).zsh"
fi

# Call ls after cd
function chpwd() {
	test -d "$PWD" && exa --group-directories-first
}

# Visual bell after execute
precmd () {
	echo -n -e "\a"
}

# To customize prompt, run `p10k configure` or edit ~/.zsh/config/p10k.zsh.
[[ ! -f ~/.zsh/config/p10k.zsh ]] || source ~/.zsh/config/p10k.zsh

# vim: set ai noet ts=4 sts=4 sw=4 ft=zsh:
