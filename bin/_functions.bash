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

function L_hardlink() (set -eu
    cp -alviu "$1" "$2"
)

function L_hardlink_sudo() (set -eu
    sudo cp -alviu "$1" "$2"
)