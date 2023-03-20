# Make sure that the terminal is in application mode when zle is active, since
# only then values from $terminfo are valid
if (( ${+terminfo[smkx]} )) && (( ${+terminfo[rmkx]} )); then
  function zle-line-init() {
    echoti smkx
  }
  function zle-line-finish() {
    echoti rmkx
  }
  zle -N zle-line-init
  zle -N zle-line-finish
fi

# Use emacs key bindings
bindkey -e

# [Backspace] - delete backward
bindkey -M emacs '^?' backward-delete-char
bindkey -M viins '^?' backward-delete-char

# [PageUp] - Up a line of history
if [[ -n "${terminfo[kpp]}" ]]; then
  bindkey -M emacs "${terminfo[kpp]}" up-line-or-history
  bindkey -M viins "${terminfo[kpp]}" up-line-or-history
fi

# [PageDown] - Down a line of history
if [[ -n "${terminfo[knp]}" ]]; then
  bindkey -M emacs "${terminfo[knp]}" down-line-or-history
  bindkey -M viins "${terminfo[knp]}" down-line-or-history
fi

# [Home] - Go to beginning of line
if [[ -n "${terminfo[khome]}" ]]; then
  bindkey -M emacs "${terminfo[khome]}" beginning-of-line
  bindkey -M viins "${terminfo[khome]}" beginning-of-line
fi

# [End] - Go to end of line
if [[ -n "${terminfo[kend]}" ]]; then
  bindkey -M emacs "${terminfo[kend]}" end-of-line
  bindkey -M viins "${terminfo[kend]}" end-of-line
fi

# [Shift-Tab] - move through the completion menu backwards
if [[ -n "${terminfo[kcbt]}" ]]; then
  bindkey -M emacs "${terminfo[kcbt]}" reverse-menu-complete
  bindkey -M viins "${terminfo[kcbt]}" reverse-menu-complete
fi

# [Delete] - delete forward
if [[ -n "${terminfo[kdch1]}" ]]; then
  bindkey -M emacs "${terminfo[kdch1]}" delete-char
  bindkey -M viins "${terminfo[kdch1]}" delete-char
else
  bindkey -M emacs "^[[3~" delete-char
  bindkey -M viins "^[[3~" delete-char
fi

# history-search - cursor not moved (superior)
if [[ -n "${terminfo[kcuu1]}" ]]; then
  bindkey -M emacs "${terminfo[kcuu1]}" history-beginning-search-backward
  bindkey -M viins "${terminfo[kcuu1]}" history-beginning-search-backward
fi

if [[ -n "${terminfo[kcud1]}" ]]; then
  bindkey -M emacs "${terminfo[kcud1]}" history-beginning-search-forward
  bindkey -M viins "${terminfo[kcud1]}" history-beginning-search-forward
fi

# [Alt-RightArrow] - move forward one word
bindkey -M emacs '^[[1;3C' forward-word
bindkey -M viins '^[[1;3C' forward-word

# [Alt-LeftArrow] - move backward one word
bindkey -M emacs '^[[1;3D' backward-word
bindkey -M viins '^[[1;3D' backward-word

# [Space] - don't do history expansion
bindkey ' ' magic-space

# Edit the current command line in $EDITOR
autoload -U edit-command-line
zle -N edit-command-line
bindkey '\C-x\C-e' edit-command-line

# Keybindings for gnome-terminal
bindkey -s 'Oo' '/'
bindkey -s 'Oj' '*'
bindkey -s 'Om' '-'
bindkey -s 'Ok' '+'
bindkey -s 'OM' '\n'

# Undo Tab completion
bindkey -M menuselect '^[' undo

# '/' is not part of the word
WORDCHARS=${WORDCHARS/\/}
