## flags
set -g __fish_git_prompt_show_informative_status 1
set -g __fish_git_prompt_hide_untrackedfiles 0
set -g __fish_git_prompt_showupstream 1
set -g __fish_git_prompt_showstashstate 1

# set -g __fish_git_prompt_status_order stagedstate invalidstate dirtystate untrackedfiles stashstate

## characters
set -g __fish_git_prompt_char_cleanstate ''
set -g __fish_git_prompt_char_stagedstate '^'
set -g __fish_git_prompt_char_dirtystate '*'
set -g __fish_git_prompt_char_untrackedfiles '?'
set -g __fish_git_prompt_char_stashstate '$'
set -g __fish_git_prompt_char_invalidstate '#'
set -g __fish_git_prompt_char_stateseparator ''
set -g __fish_git_prompt_char_upstream_ahead '+'
set -g __fish_git_prompt_char_upstream_behind '-'
set -g __fish_git_prompt_char_upstream_diverged '~'
set -g __fish_git_prompt_char_upstream_equal '='
set -g __fish_git_prompt_char_upstream_prefix ''

## colors
set -g __fish_git_prompt_color_branch magenta --bold
set -g __fish_git_prompt_color_dirtystate bryellow
set -g __fish_git_prompt_color_stagedstate green
set -g __fish_git_prompt_color_untrackedfiles 777
set -g __fish_git_prompt_color_invalidstate red
set -g __fish_git_prompt_color_stashstate cyan
# set -g __fish_git_prompt_color_upstream
# set -g __fish_git_prompt_color_prefix
# set -g __fish_git_prompt_color_suffix
# set -g __fish_git_prompt_color_bare
# set -g __fish_git_prompt_color_merging
# set -g __fish_git_prompt_color_cleanstate
