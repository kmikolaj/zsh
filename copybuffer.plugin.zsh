# Copy command to clipoard
copybuffer () {
  if which xcopy &>/dev/null; then
    printf "%s" "$BUFFER" | xcopy
  fi
}

zle -N copybuffer

bindkey -M emacs "^O" copybuffer
bindkey -M viins "^O" copybuffer
