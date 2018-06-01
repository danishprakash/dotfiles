#! /bin/bash
# System setup script for macOS


# ====== VARIABLES ===== #
DOT_DIR = ~/dotfiles


# ====== INSTALL BREW ===== #
echo "--> Installing homebrew..."
/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"


# ====== INSTALL APPLICATIONS ===== #
echo "--> Installing applications..."
brew install zsh
brew install tmux
brew install tree
brew install neovim
brew install python
brew install python3
brew install zsh-completions
brew install zsh-autosuggestions
brew install zsh-syntax-highlighting

brew tap homebrew/cask

brew cask install slack
brew cask install iina
brew cask install iterm2
brew cask install spotify
brew cask install firefox
brew cask install lastpass
brew cask install tunnelbear
brew cask install transmission


# ====== SYMLINKS ====== #
echo "--> Symlinking config files..."
ln -fs {$PWD}/nvim/init.vim ~/.config/nvim/init.vim
ln -fs {$PWD}/.zshrc ~/.zshrc


