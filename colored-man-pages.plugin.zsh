# Requires colors autoload.
# See termcap(5).

# Set up once, and then reuse. This way it supports user overrides after the
# plugin is loaded.
typeset -AHg less_termcap

# bold & blinking mode
less_termcap[mb]=$'\E[01;35m'
less_termcap[md]=$'\E[01;38;5;74m'
less_termcap[me]=$'\E[0m'
# standout mode
less_termcap[so]=$'\E[01;30;44m'
less_termcap[se]=$'\E[0m'
# underlining
less_termcap[us]=$'\E[04;38;5;146m'
less_termcap[ue]=$'\E[0m'

# Handle $0 according to the standard:
# https://zdharma-continuum.github.io/Zsh-100-Commits-Club/Zsh-Plugin-Standard.html
0="${${ZERO:-${0:#$ZSH_ARGZERO}}:-${(%):-%N}}"
0="${${(M)0:#/*}:-$PWD/$0}"

# Absolute path to this file's directory.
typeset -g __colored_man_pages_dir="${0:A:h}"

function colored() {
  local -a environment

  # Convert associative array to plain array of NAME=VALUE items.
  local k v
  for k v in "${(@kv)less_termcap}"; do
    environment+=( "LESS_TERMCAP_${k}=${v}" )
  done

  # Prefer `less` whenever available, since we specifically configured
  # environment for it.
  environment+=( PAGER="${commands[less]:-$PAGER}" )
  environment+=( GROFF_NO_SGR=1 )

  command env $environment "$@"
}

# Colorize man and cppman
function man \
  cppman {
  colored $0 "$@"
}
