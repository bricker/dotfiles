function bundle --wraps bundle --description 'chruby wrapper around bundler'
  chruby_apply
  command bundle $argv;
end
