function chruby_apply --description "applies a ruby version based on .ruby-version file, falling back to default"
  if test -f .ruby-version
    chruby (cat .ruby_version)
  else
    chruby default
  end
end
