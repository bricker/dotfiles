set -l brewcmd "/home/linuxbrew/.linuxbrew/bin/brew"
if test -x "$brewcmd"
    set -gx HOMEBREW_ROOT ($brewcmd --prefix)
    fish_add_path -g $HOMEBREW_ROOT/bin
end
