function echo --wraps echo --description "Print a message of the given type"
  argparse --ignore-unknown t/type= -- $argv

  if not set -q _flag_type
    command echo $argv
    return
  end

  set output /dev/stdout

  switch "$_flag_type"
  case s success
    set color green
    set tag success
  case i info
    set color cyan
    set tag info
  case d debug
    if not set -q FISH_DEBUG
        return
    end
    set color grey
    set tag debug
    set output /dev/stderr
  case e error
    set color red
    set tag error
    set output /dev/stderr
  case w warn warning
    set color yellow
    set tag warning
    set output /dev/stderr
  case '*'
    command echo $argv
    return
  end

  set msg $argv[-1]
  set -e argv[-1]
  command echo $argv "$(set_color -ro $color)"'['"$tag"']'" $msg$(set_color normal)" > $output
end
