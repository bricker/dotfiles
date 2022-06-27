function venv -a subcommand lang --description "manage the virtual environment(s) for the current directory"
  argparse h/help -- $argv; or return

  if test -z "$lang"
    echo --type error "missing required argument lang. try 'ruby' or 'python'."
    return 1
  end

  if set -q _flag_help; or test "$subcommand" = "help"; or test -z "$subcommand"
    echo "Usage: venv (activate|deactivate|status|help) [lang]"
    return
  end

  if type -q venv_$lang
    venv_$lang $subcommand
  else
    echo --type error "$lang is not a supported virtual environment"
    return 1
  end
end

function venv_python -a subcommand --description "manage a python venv for the current project"
  argparse allow_missing q/quiet r/root_dir= -- $argv; or return
  set root $_flag_root_dir (git_root --allow_missing) '.'
  set root $root[1]

  set lang python

  if test -z "$subcommand"
    echo --type error "missing subcommand argument"
    return 1
  end

  switch "$subcommand"
  case activate
    set -l file $root/.venv/bin/activate.fish

    if test -f $file
      source $file
      set -g __python_venv_activated
      venv_python status
      return
    end
  
    if not set -q _flag_allow_missing
      echo --type error "no python virtual environment detected in $root. Virtual environment not loaded."
      return 1
    end

  case deactivate
    if set -q __python_venv_activated
      set --erase __python_venv_activated
    end
  
    # deactivate is defined by python venv
    if type -q deactivate
      deactivate
    end

    venv_python status
    return

  case status
    if not set -q _flag_quiet
      echo "$(command python --version) @ $(which python)"
    end
    return

  case '*'
    echo --type error "$subcommand is not a valid subcommand"
    return 1
  end
end

function venv_ruby -a subcommand --description "manage a ruby venv for the current project"
  argparse allow_missing q/quiet r/root_dir= -- $argv; or return
  set root $_flag_root_dir (git_root --allow_missing) '.'
  set root $root[1]

  if test -z "$subcommand"
    echo --type error "missing subcommand argument"
    return 1
  end

  switch "$subcommand"
  case activate
    set -l file $root/.ruby-version

    if test -f $file
      chruby (cat $file)
      set -g __ruby_venv_activated
      venv_ruby status
      return
    end
  
    if not set -q _flag_allow_missing
      echo --type error "no ruby version detected in $root. Virtual environment not loaded."
      return 1
    end

  case deactivate
    set --erase __ruby_venv_activated
    chruby system
    venv_ruby status
    return

  case status
    if not set -q _flag_quiet
      echo "$(command ruby --version) @ $(which ruby)"
    end
    return

  case '*'
    echo --type error "$subcommand is not a valid subcommand"
    return 1
  end
end
