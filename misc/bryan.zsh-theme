local ret_status="%(?:%{$fg_bold[green]%}+:%{$fg_bold[red]%}-)"
PROMPT='[%T] ${ret_status} %{$fg[cyan]%}%c%{$reset_color%} $(git_prompt_info) %{$fg[white]%}$%{$reset_color%} '

ZSH_THEME_GIT_PROMPT_PREFIX="%{$fg[red]%}"
ZSH_THEME_GIT_PROMPT_SUFFIX="%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_DIRTY=" %{$fg[yellow]%}*"
ZSH_THEME_GIT_PROMPT_CLEAN=""
