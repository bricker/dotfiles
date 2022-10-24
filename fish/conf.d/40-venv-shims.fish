function ruby --wraps ruby --description 'venv wrapper around ruby'
  venv_ruby activate --quiet --allow_missing
  command ruby $argv;
end

function bundle --wraps bundle --description 'venv wrapper around bundler'
  venv_ruby activate --quiet --allow_missing
  command bundle $argv;
end

function gem --wraps gem --description 'venv wrapper around gem'
  venv_ruby activate --quiet --allow_missing
  command gem $argv;
end

function python --wraps python --description 'venv wrapper around python'
  venv_python activate --quiet
  command python $argv;
end

function pip --wraps pip --description 'venv wrapper around pip'
  venv_python activate --quiet
  command pip $argv;
end

function npm --wraps npm --description 'venv wrapper around npm'
    venv_node activate --quiet
    command npm $argv;
end

function node --wraps node --description 'venv wrapper around node'
    venv_node activate --quiet
    command node $argv;
end
