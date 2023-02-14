function venv -a subcommand lang --description "manage the virtual environment(s) for the current directory"
  argparse h/help -- $argv; or return

  if set -q _flag_help; or test "$subcommand" = "help"; or test -z "$subcommand"
    echo "Usage: venv (activate|deactivate|status|help) [lang]"
    return
  end

  if test -z "$lang"
    echo --type error "missing required argument lang. try 'ruby' or 'python'."
    return 1
  end

  if type -q venv_$lang
    venv_$lang $subcommand $argv
  else
    echo --type error "$lang is not a supported virtual environment"
    return 1
  end
end

function venv_node -a subcommand --description "manage a node venv for the current project"
  argparse allow_missing q/quiet r/root_dir= -- $argv; or return
  set root $_flag_root_dir (git_root --allow_missing) '.'
  set root $root[1]

  set lang node
  set activated_flag __"$lang"_venv_activated

  if test -z "$subcommand"
    echo --type error "missing subcommand argument"
    return 1
  end

  switch "$subcommand"
  case a activate
    set -l files .node-version .nvmrc $root/.node-version $root/.nvmrc

    for file in $files
        echo --type debug "trying $file"
        if test -f $file
          nvm use (cat $file)
          set -g $activated_flag
          venv_node status $argv
          return
        end
    end

    if not set -q _flag_allow_missing
      echo --type error "no $lang virtual environment detected in $root. Virtual environment not loaded."
      return 1
    end

  case d deactivate
    set --erase $activated_flag
    nvm use system
    venv_node status $argv
    return

  case s status
    if not set -q _flag_quiet
      echo "$(command node --version) @ $(which node)"
    end
    return

  case '*'
    echo --type error "$subcommand is not a valid subcommand"
    return 1
  end
end

function venv_python -a subcommand --description "manage a python venv for the current project"
  argparse allow_missing q/quiet r/root_dir= -- $argv; or return
  set root $_flag_root_dir (git_root --allow_missing) '.'
  set root $root[1]

  set lang python
  set activated_flag __"$lang"_venv_activated

  if test -z "$subcommand"
    echo --type error "missing subcommand argument"
    return 1
  end

  switch "$subcommand"
  case a activate
    set -l files .venv/bin/activate.fish $root/.venv/bin/activate.fish

    for file in $files
      if test -f $file
        source $file
        set -g $activated_flag
        echo --type success "venv loaded"
        venv_python status $argv
        return
      end
    end

    if not set -q _flag_allow_missing
      echo --type error "no $lang virtual environment detected in $root. Virtual environment not loaded."
      return 1
    end

  case d deactivate
    set --erase $activated_flag

    # deactivate is defined by python venv
    if type -q deactivate
      deactivate
    end

    venv_python status $argv
    return

  case s status
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

  set lang ruby
  set activated_flag __"$lang"_venv_activated

  if test -z "$subcommand"
    echo --type error "missing subcommand argument"
    return 1
  end

  switch "$subcommand"
  case a activate
    set -l files .ruby-version $root/.ruby-version

    for file in $files
      if test -f $file
        chruby (cat $file)
        set -g $activated_flag
        venv_ruby status $argv
        return
      end
    end

    if not set -q _flag_allow_missing
      echo --type error "no $lang version detected in $root. Virtual environment not loaded."
      return 1
    end

  case d deactivate
    set --erase $activated_flag
    chruby system
    venv_ruby status $argv
    return

  case s status
    if not set -q _flag_quiet
      echo "$(command ruby --version) @ $(which ruby)"
    end
    return

  case '*'
    echo --type error "$subcommand is not a valid subcommand"
    return 1
  end
end
