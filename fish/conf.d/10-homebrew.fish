set -gx HOMEBREW_NO_ANALYTICS 1

set -l brewcmd "$(which brew)"
if test -n "$brewcmd"
    set -gx HOMEBREW_ROOT ($brewcmd --prefix)
    fish_add_path -g $HOMEBREW_ROOT/bin
end
