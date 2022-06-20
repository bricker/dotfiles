# This is a special file which loads all configuration files from $DOTFILES_HOME/fish.conf.d
# This is necessary because fish doesn't support custom conf.d paths

function load-dotfiles-conf
    set -l dotfiles_conf_dir $HOME/dotfiles/fish/conf.d

    for file in $dotfiles_conf_dir/*.fish
        source $file
    end
end
load-dotfiles-conf
