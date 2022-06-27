function git_root --description "finds the closest git root directory from the current directory."
  argparse allow_missing -- $argv; or return

  if set -q _flag_allow_missing
    git rev-parse --show-toplevel 2>/dev/null || true
  else
    git rev-parse --show-toplevel
  end
end
