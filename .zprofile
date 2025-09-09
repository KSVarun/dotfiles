
eval "$(/opt/homebrew/bin/brew shellenv)"

alias python="python3.11"

if [ -z "$TMUX" ]; then
  tmux
fi
