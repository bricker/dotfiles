set -g fish_key_bindings fish_default_key_bindings

if status is-interactive
    bind \ch backward-kill-word
end
