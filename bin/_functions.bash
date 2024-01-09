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
