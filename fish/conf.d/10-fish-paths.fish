set --prepend fish_function_path $DOTFILES_HOME/fish/functions
set --prepend fish_complete_path $DOTFILES_HOME/fish/completions
fish_add_path -g $DOTFILES_HOME/bin

set -gx GCLOUD_SDK_ROOT "/usr/lib/google-cloud-sdk"
fish_add_path -g $GCLOUD_SDK_ROOT/bin

set -gx GOROOT "/usr/local/go"
fish_add_path -g $GOROOT/bin

set -gx MINT_PATH "$XDG_DATA_HOME/mint"
set -gx MINT_LINK_PATH "$MINT_PATH/bin"
fish_add_path -g $MINT_LINK_PATH

if command -v brew > /dev/null
    set -gx HOMEBREW_ROOT (brew --prefix)
    fish_add_path -g $HOMEBREW_ROOT/bin
end
