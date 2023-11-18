# Environment
#
# Read user sensitive variables
source ${HOME}/.environment

# Unique entries in PATH
typeset -aU path
path=("$HOME/bin" $path "/opt/tools/android/android-sdk/platform-tools")

# Ruby Gem Environment
if which ruby >/dev/null && which gem >/dev/null; then
	RUBY_PATH="$(ruby -e 'puts Gem.user_dir')"
	path=("${RUBY_PATH}/bin" $path)
	export GEM_HOME=${RUBY_PATH}
	export GEM_PATH=${RUBY_PATH}
	export GEM_SPEC_CACHE=$HOME/.gem/specs
fi

# Golang (deprecated)
#export GO111MODULE=off
export GOPATH=${HOME}/.go
path=("${GOPATH}/bin" $path)

# Node.js sane prefix
export NPM_CONFIG_PREFIX=${HOME}/.nodejs
path=("${NPM_CONFIG_PREFIX}/bin" $path)

# Rust
path=("${HOME}/.cargo/bin" $path)

# pyenv
export PYENV_ROOT=${HOME}/virt/pythons/pyenv
path=("${PYENV_ROOT}/bin" $path)

# virsh
export LIBVIRT_DEFAULT_URI=qemu:///system

# vagrant
export VAGRANT_DEFAULT_PROVIDER=libvirt

# Grep color
export GREP_COLORS='mt=32'

# less highlight
export LESS=' -R -x4 '
#export LESSCOLORIZER='pygmentize -O style=solarized-dark'
export LESSCOLORIZER=bat

# Colorful manuals
export LESS_TERMCAP_mb=$'\E[01;31m'       # begin blinking
export LESS_TERMCAP_md=$'\E[01;38;5;74m'  # begin bold
export LESS_TERMCAP_me=$'\E[0m'           # end mode
export LESS_TERMCAP_se=$'\E[0m'           # end standout-mode
#export LESS_TERMCAP_so=$'\E[33;01;44m'    # begin standout-mode - info box
export LESS_TERMCAP_so=$'\E[01;30;44m'    # for solarized
export LESS_TERMCAP_ue=$'\E[0m'           # end underline
export LESS_TERMCAP_us=$'\E[04;38;5;146m' # begin underline

#export LESS_TERMCAP_md=$'\E[01;31m'
#export LESS_TERMCAP_so=$'\E[01;44;33m'
#export LESS_TERMCAP_us=$'\E[01;32m'

# bat
export BAT_THEME="Solarized (dark)"
export BAT_STYLE="numbers,changes,rule"

# Compose key - universal X11 method
export GTK_IM_MODULE=ibus
export QT_IM_MODULE=ibus
export XMODIFIERS=@im=ibus

# HiDPI Qt
export QT_AUTO_SCREEN_SCALE_FACTOR=1

# wireshark ssl/tls decryption
export SSLKEYLOGFILE=/tmp/ssl.pms

# sdl2 midi
export SDL_SOUNDFONTS=/usr/share/soundfonts/FluidR3_GM.sf2

# zsh autosuggestions 
# color solarized dark
export ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=10'
# color solarized light
#export ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=12'

# ripgrep config
export RIPGREP_CONFIG_PATH=${XDG_CONFIG_HOME}/ripgrep/rg.conf

# eza dashes
export EXA_COLORS="xx=0"

# visual studio code embedded terminal
source ${HOME}/.zsh/config/vscode.zsh
