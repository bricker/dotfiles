if command -v pyenv > /dev/null
  set -gx PYENV_ROOT "$XDG_DATA_HOME/pyenv"
  fish_add_path -g $PYENV_ROOT/bin
  pyenv init - | source
end
