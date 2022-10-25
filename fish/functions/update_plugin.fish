#!/usr/bin/env fish

function _try_cp_files -a source dest
    if ! test -d "$dest"
        set_color red
        echo "ERROR: $dest is not a directory."
        return 1
        set_color normal
    end

    if test -d "$source"
        sudo cp $source/* "$dest"
        set_color green
        echo "✅ copied $source/* to $dest"
        set_color normal
    end
end

function update_plugin -d "updates a plugin in the plugins folder" -a plugin_name ref
    set plugin_path "$XDG_CONFIG_HOME/fish/plugins/$plugin_name"
    set dest_path /usr/share/fish

    if ! test -d "$plugin_path"
        set_color red
        echo "ERROR: plugin $plugin_name doesn't exist at $XDG_CONFIG_HOME/fish/plugins"
        set_color normal
        return 1
    end

    git -C $plugin_path fetch --quiet --all
    
    if test -z $ref; or test $ref = "latest"
        set -l latest_tag (git -C $plugin_path tag --list --sort=-taggerdate | head -n1)
        set ref $latest_tag
    end

    git -C $plugin_path checkout --quiet $ref
    echo "installing $plugin_name@$ref"

    _try_cp_files $plugin_path/completions          $dest_path/vendor_completions.d
    _try_cp_files $plugin_path/functions            $dest_path/vendor_functions.d
    _try_cp_files $plugin_path/conf.d               $dest_path/vendor_conf.d
    _try_cp_files $plugin_path/vendor_completions.d $dest_path/vendor_completions.d
    _try_cp_files $plugin_path/vendor_functions.d   $dest_path/vendor_functions.d
    _try_cp_files $plugin_path/vendor_conf.d        $dest_path/vendor_conf.d
end
