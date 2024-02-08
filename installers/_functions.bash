function ask() (set -u
    echo ""
    echo -n "$1 [y/n] "
    read -r input
    test "$input" = "y"
)

function install_deb() (set -eu
    local url="$1"
    outfile="$(mktemp).deb"
    wget --quiet -O "$outfile" "$url"
    sudo apt install "$outfile"
)

function _hardlink() (set -eu
    cp -alviu "$1" "$2"
)

function _cp_sudo() (set -eu
    sudo cp -aviu "$1" "$2"
)

function L_install_fish_plugin() (set -eu
    local plugin_name="$1"
    local plugin_ref="${2:-}"
    local plugin_path="$HOME/.config/fish/plugins/$plugin_name"
    local dest_path="/usr/share/fish"

    git -C $plugin_path fetch --quiet --all

    if test -z "$plugin_ref" || test "$plugin_ref" = "latest"; then
        local latest_tag="$(git -C $plugin_path tag --list --sort=-taggerdate | head -n1)"
        plugin_ref="$latest_tag"
    fi

    git -C $plugin_path checkout --quiet $plugin_ref
    
    if test -d "$plugin_path/completions"; then             sudo cp $plugin_path/completions/*          $dest_path/vendor_completions.d; fi
    if test -d "$plugin_path/functions"; then               sudo cp $plugin_path/functions/*            $dest_path/vendor_functions.d; fi
    if test -d "$plugin_path/conf.d"; then                  sudo cp $plugin_path/conf.d/*               $dest_path/vendor_conf.d; fi
    if test -d "$plugin_path/vendor_completions.d"; then    sudo cp $plugin_path/vendor_completions.d/* $dest_path/vendor_completions.d; fi
    if test -d "$plugin_path/vendor_functions.d"; then      sudo cp $plugin_path/vendor_functions.d/*   $dest_path/vendor_functions.d; fi
    if test -d "$plugin_path/vendor_conf.d"; then           sudo cp $plugin_path/vendor_conf.d/*        $dest_path/vendor_conf.d; fi
)

_TARGETPKG="${1:-}"
_TARGETFULFILLED=false

function _shouldinstall () {
    local pkg="$1"
    local question="$2"

    if $_TARGETFULFILLED; then
        return 1
    fi

    if test -n "$_TARGETPKG"; then
        if test "$_TARGETPKG" == "$pkg"; then
            _TARGETFULFILLED=true
        else
            return 1
        fi
    fi

    ask "$question"
}

_brewbin="/home/linuxbrew/.linuxbrew/bin"
if ! $(which brew > /dev/null) && test -x $_brewbin/brew; then
    export PATH="$PATH:$_brewbin"
fi
