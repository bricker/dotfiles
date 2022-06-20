# These variables contain references to $HOME,
# which is expanded when setting a universal variable in fish,
# making them unsuitable for the universal fish_variables file.
set -gx XDG_CONFIG_HOME $HOME/.config
set -gx XDG_DATA_HOME $HOME/.local/share
set -gx DOTFILES_HOME $HOME/dotfiles
set -gx EDITOR $DOTFILES_HOME/tmux/tmux-vim-pane-editor
set -gx PAGER less
