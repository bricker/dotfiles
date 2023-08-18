function ggl --wraps='git pull --set-upstream origin (current branch)' --description 'alias ggl=git pull --set-upstream origin (current branch)'
  git pull --set-upstream origin (gcb) $argv;
end
