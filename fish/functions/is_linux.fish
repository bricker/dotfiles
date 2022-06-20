function is_linux --description "returns 0 if on a Linux distro, otherwise returns 1"
  if set -q IS_LINUX
    return 0
  end

  if test "$(uname -s)" = "Linux"
    set -u IS_LINUX 1
    return 0
  end

  return 1
end
