function ruby --wraps ruby --description 'chruby wrapper around ruby'
  chruby_apply
  command ruby $argv;
end
