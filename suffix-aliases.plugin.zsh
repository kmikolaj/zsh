# zsh is able to auto-do some kungfoo
# depends on the SUFFIX :)
autoload -Uz is-at-least
if is-at-least 4.2.0; then
  # open browser on urls
  if [[ -n "$BROWSER" ]]; then
    _browser_fts=(htm html pl en org net com)
    for ft in $_browser_fts; do alias -s $ft='$BROWSER'; done
  fi

  _editor_fts=(cpp cxx cc c hh h inl asc txt TXT tex)
  for ft in $_editor_fts; do alias -s $ft='$EDITOR'; done

  _image_fts=(jpg jpeg png gif mng tiff tif xpm)
  for ft in $_image_fts; do alias -s $ft=feh; done

  _media_fts=(ape avi flv m4a mkv mov mp3 mpeg mpg ogg ogm rm wav webm)
  for ft in $_media_fts; do alias -s $ft=mpv; done

  _doc_fts=(pdf cb cbr cbz djvu)
  for ft in $_doc_fts; do alias -s $ft=zathura; done

  # archives
  alias -s xz="tar tf"
  alias -s bz2="tar tf"
  alias -s zst="tar tf"
  alias -s gz="tar tf"
  alias -s tar="tar tf"
  alias -s zip="unzip -l"
  alias -s rar="unrar l"
  alias -s ace="unace l"
fi
