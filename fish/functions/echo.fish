function echo --wraps echo --description "Print a message of the given type"
  argparse --ignore-unknown t/type= -- $argv

  if not set -q _flag_type
    command echo $argv
    return
  end

  switch "$_flag_type"
  case s success
    set color green
    set tag success
  case i info
    set color cyan
    set tag info
  case d debug
    set color grey
    set tag debug
  case e error
    set color red
    set tag error
  case w warning
    set color yellow
    set tag warning
  case '*'
    command echo $argv
    return
  end

  set msg $argv[-1]
  set -e argv[-1]
  command echo $argv "$(set_color -ro $color)"'['"$tag"']'" $msg$(set_color normal)"
end
