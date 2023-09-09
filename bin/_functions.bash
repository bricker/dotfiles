function ask() (
    echo ""
    echo -n "$1 [Y/n] "
    read -r input
    test "$input" = "Y"
)