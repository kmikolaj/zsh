# theme based on https://github.com/robbyrussell/oh-my-zsh/blob/master/themes/robbyrussell.zsh-theme

if [ $TERM = "linux" ] || [ $TERM = "screen" ]; then
    prompt_symbol=\>
    dirty_symbol=X
else
    prompt_symbol=➜
    dirty_symbol=✗
fi

PROMPT="%(?:%{$fg_bold[green]%}${prompt_symbol} :%{$fg_bold[red]%}${prompt_symbol} )"
PROMPT+=' %{$fg[cyan]%}%c%{$reset_color%} $(git_prompt_info)'

ZSH_THEME_GIT_PROMPT_PREFIX="%{$fg_bold[blue]%}git:(%{$fg[red]%}"
ZSH_THEME_GIT_PROMPT_SUFFIX="%{$reset_color%} "
ZSH_THEME_GIT_PROMPT_DIRTY="%{$fg[blue]%}) %{$fg[yellow]%}${dirty_symbol}"
ZSH_THEME_GIT_PROMPT_CLEAN="%{$fg[blue]%})"
