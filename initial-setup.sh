#!/usr/bin/env bash
set -e

echo "🚀 Starting dotfiles setup..."

# --- 1. Install Oh My Zsh ---
if [ ! -d "$HOME/.oh-my-zsh" ]; then
  echo "👉 Installing Oh My Zsh..."
  sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
else
  echo "✅ Oh My Zsh already installed."
fi

# --- 2. Install Zsh Plugins ---
ZSH_CUSTOM=${ZSH_CUSTOM:-~/.oh-my-zsh/custom}

if [ ! -d "$ZSH_CUSTOM/plugins/zsh-syntax-highlighting" ]; then
  echo "👉 Installing zsh-syntax-highlighting..."
  git clone https://github.com/zsh-users/zsh-syntax-highlighting.git \
    $ZSH_CUSTOM/plugins/zsh-syntax-highlighting
fi

if [ ! -d "$ZSH_CUSTOM/plugins/zsh-autosuggestions" ]; then
  echo "👉 Installing zsh-autosuggestions..."
  git clone https://github.com/zsh-users/zsh-autosuggestions.git \
    $ZSH_CUSTOM/plugins/zsh-autosuggestions
fi

# --- 3. Install Tmux ---
if ! command -v tmux &> /dev/null; then
  echo "👉 Installing tmux..."
  if [[ "$OSTYPE" == "linux-gnu"* ]]; then
    sudo apt update && sudo apt install -y tmux
  elif [[ "$OSTYPE" == "darwin"* ]]; then
    brew install tmux
  fi
else
  echo "✅ tmux already installed."
fi

# --- 4. Install Node.js via NVM ---
if [ ! -d "$HOME/.nvm" ]; then
  echo "👉 Installing NVM (Node Version Manager)..."
  curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/master/install.sh | bash

  # Load NVM immediately (also added to .zshrc by installer)
  export NVM_DIR="$HOME/.nvm"
  [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
  [ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"
fi

echo "👉 Installing latest Node.js LTS..."
nvm install --lts
nvm alias default 'lts/*'

# --- 5. Install pnpm globally ---
echo "👉 Installing pnpm..."
npm install -g pnpm

# --- 6. Final message ---
echo "🎉 Setup complete! Restart your terminal or run: source ~/.zshrc"

