function gem --wraps gem --description 'chruby wrapper around gem'
  chruby_apply
  command gem $argv;
end
