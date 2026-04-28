# XDG
export XDG_CONFIG_HOME=${XDG_CONFIG_HOME:=${HOME}/.config}
export XDG_CACHE_HOME=${XDG_CACHE_HOME:=${HOME}/.cache}

# zsh
export ZSH_CACHE_DIR=${XDG_CACHE_HOME}/zsh
export ZSH_COMPDUMP=${ZSH_CACHE_DIR}/zcompdump

# vim: set ai noet ts=4 sts=4 sw=4 ft=zsh:
