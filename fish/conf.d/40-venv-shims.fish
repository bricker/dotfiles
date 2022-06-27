function ruby --wraps ruby --description 'venv wrapper around ruby'
  venv_ruby activate --quiet; or chruby default
  command ruby $argv;
end

function bundle --wraps bundle --description 'venv wrapper around bundler'
  venv_ruby activate --quiet; or chruby default
  command bundle $argv;
end

function gem --wraps gem --description 'venv wrapper around gem'
  venv_ruby activate --quiet; or chruby default
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
