set -p fish_function_path $DOTFILES_HOME/fish/functions
set -p fish_complete_path $DOTFILES_HOME/fish/completions

set -gx HOMEBREW_ROOT (/home/linuxbrew/.linuxbrew/bin/brew --prefix)
set -gx CHRUBY_ROOT $HOMEBREW_ROOT

fish_add_path -g \
  $HOME/.mint/bin \
  $HOMEBREW_ROOT/bin \
  /usr/local/go/bin
