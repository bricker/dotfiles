function ggp --wraps='git push --set-upstream origin (current branch)' --description 'alias ggp=git push --set-upstream origin (current branch)'
  git push --set-upstream origin (gcb) $argv;
end
