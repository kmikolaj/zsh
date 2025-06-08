# copy the active line from the command line buffer
# onto the system clipboard

copybuffer () {
  if which xcopy &>/dev/null; then
    printf "%s" "$BUFFER" | xcopy
  fi
}

zle -N copybuffer

bindkey -M emacs "^O" copybuffer
bindkey -M viins "^O" copybuffer
bindkey -M vicmd "^O" copybuffer
