set -gx CHRUBY_AUTO_DISABLE 1

if test -n "$HOMEBREW_ROOT"
    set -gx CHRUBY_ROOT "$HOMEBREW_ROOT"
end
