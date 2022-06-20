function ggp --wraps='git push origin' --description 'alias ggp=git push origin'
  git push origin $(git branch --show-current) $argv; 
end
