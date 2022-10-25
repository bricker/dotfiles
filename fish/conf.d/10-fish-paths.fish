set -p fish_function_path $DOTFILES_HOME/fish/functions
set -p fish_complete_path $DOTFILES_HOME/fish/completions
fish_add_path -g $DOTFILES_HOME/bin

set -l mintdir "$HOME/.mint/bin"
if test -d "$mintdir"
    fish_add_path -g "$mintdir"
end

set -l brewcmd "/home/linuxbrew/.linuxbrew/bin/brew"
if test -x "$brewcmd"
    set -gx HOMEBREW_ROOT ($brewcmd --prefix)
    set -gx CHRUBY_ROOT $HOMEBREW_ROOT
    fish_add_path -g $HOMEBREW_ROOT/bin
end

set -l goroot "/usr/local/go/bin"
if test -d "$goroot"
    fish_add_path -g "$goroot"
end
