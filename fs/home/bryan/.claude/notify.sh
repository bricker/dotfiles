#!/bin/bash
# Claude Code notification hook script
# Reads JSON from stdin, extracts the message, sends a macOS notification via alerter
# Auto-detects the hosting terminal app so clicking the notification focuses it

input=$(cat)
msg=$(echo "$input" | jq -r '.message // empty')
if [ -z "$msg" ]; then
  msg="needs your attention"
fi

cwd=$(echo "$input" | jq -r '.cwd // empty')
subtitle=""
if [ -n "$cwd" ]; then
  subtitle=$(basename "$cwd")
fi

# Detect the terminal host app name and whether we're truly in tmux.
# Walk from $$ upward: if we hit a GUI app before tmux, we're directly in that app
# (even if $TMUX is set — it may be inherited). Only if we hit tmux first do we
# use tmux client detection to find the real host app.
in_tmux=false
app_name=""

match_gui_app() {
  local comm="$1"
  case "$comm" in
    */iTerm2)          echo "iTerm2";;
    */Terminal)        echo "Terminal";;
    */Alacritty)       echo "Alacritty";;
    */kitty)           echo "kitty";;
    */WezTerm*)        echo "WezTerm";;
    */Ghostty)         echo "Ghostty";;
    */Cursor\ Helper*) echo "Cursor";;
    */Cursor)          echo "Cursor";;
    */Code\ Helper*)   echo "Visual Studio Code";;
    */Electron)        echo "Visual Studio Code";;
    */studio)          echo "Android Studio";;
    *)                 return 1;;
  esac
}

# Phase 1: walk from $$ to determine if we're truly in tmux or directly in a GUI app
pid=$$
while [ "$pid" != "1" ] && [ -n "$pid" ] && [ "$pid" != "0" ]; do
  comm=$(ps -p "$pid" -o comm= 2>/dev/null)

  # Check for GUI app first
  result=$(match_gui_app "$comm")
  if [ -n "$result" ]; then
    app_name="$result"
    break
  fi

  # Check if we hit tmux (meaning we're truly inside a tmux pane)
  case "$comm" in
    tmux|*/tmux) in_tmux=true; break;;
  esac

  pid=$(ps -p "$pid" -o ppid= 2>/dev/null | tr -d ' ')
done

# Phase 2: if we're truly in tmux, trace from the tmux client to find the host app
if $in_tmux && [ -n "$TMUX" ]; then
  client_pid=$(tmux display-message -p '#{client_pid}' 2>/dev/null)
  if [ -n "$client_pid" ]; then
    pid=$client_pid
    while [ "$pid" != "1" ] && [ -n "$pid" ] && [ "$pid" != "0" ]; do
      comm=$(ps -p "$pid" -o comm= 2>/dev/null)
      result=$(match_gui_app "$comm")
      if [ -n "$result" ]; then
        app_name="$result"
        break
      fi
      pid=$(ps -p "$pid" -o ppid= 2>/dev/null | tr -d ' ')
    done
  fi
fi

# Fallback
if [ -z "$app_name" ]; then
  app_name="Terminal"
fi

# Use session_id as group so each Claude session gets its own notification stack
session_id=$(echo "$input" | jq -r '.session_id // empty')
group="claude-${session_id:-$$}"

# Kill previous alerter for THIS session only (prevents process buildup within a session)
pkill -f "alerter.*--group $group" 2>/dev/null

# Capture tmux pane/window IDs only if we're truly in tmux
tmux_pane=""
tmux_window=""
if $in_tmux && [ -n "${TMUX_PANE:-}" ]; then
  tmux_pane="$TMUX_PANE"
  tmux_window=$(tmux display-message -t "$tmux_pane" -p '#{window_id}' 2>/dev/null)
fi

# Run alerter and handle click-to-focus / auto-dismiss in a background subshell
(
  result_file=$(mktemp)

  # Send notification (backgrounded so we can poll for app focus in parallel)
  alerter \
    --title "Claude Code" \
    --message "$msg" \
    ${subtitle:+--subtitle "$subtitle"} \
    --app-icon "/Applications/Claude.app/Contents/Resources/electron.icns" \
    --sound default \
    --group "$group" \
    --json > "$result_file" 2>/dev/null &
  alerter_pid=$!

  # Poll for app becoming frontmost — dismiss notification when user switches to it
  while kill -0 "$alerter_pid" 2>/dev/null; do
    sleep 2
    frontmost=$(osascript -e 'tell application "System Events" to get name of first process whose frontmost is true' 2>/dev/null)
    if [ "$frontmost" = "$app_name" ]; then
      alerter --remove "$group" 2>/dev/null
      break
    fi
  done

  # Wait for alerter to finish (click, timeout, or removed) and handle result
  wait "$alerter_pid" 2>/dev/null
  result=$(cat "$result_file" 2>/dev/null)
  rm -f "$result_file"

  action=$(echo "$result" | jq -r '.activationType // empty' 2>/dev/null)
  if [ "$action" = "contentsClicked" ] || [ "$action" = "actionClicked" ]; then
    osascript -e "tell application \"$app_name\" to activate" 2>/dev/null
    # Switch to the correct tmux window and pane
    if [ -n "$tmux_window" ] && [ -n "$tmux_pane" ]; then
      tmux select-window -t "$tmux_window" 2>/dev/null
      tmux select-pane -t "$tmux_pane" 2>/dev/null
    fi
  fi
) &
