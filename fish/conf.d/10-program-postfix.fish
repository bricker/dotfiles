# program-postfix
# usage:
#   = ~/.config/fish/config.fish vim
#   = ~/.config/fish/config.fish cp /tmp
#   = ~/.config/fish/config.fish rm -rf
function = -a input -d 'run a program $argv[1..] on a target $argv[0]'
    $argv[2..-1] $input;
end
