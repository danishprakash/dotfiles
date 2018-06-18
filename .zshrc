# ========== FUNCTIONS ========== #

# figuring out current branch and supressing `not git repo` errors
git_branch() {
    branch=$(git symbolic-ref HEAD | cut -d'/' -f3) > /dev/null 2>&1
    if [[ $branch == "" ]];
    then
        :
    else
        echo ' ('$branch')'
    fi
}

# Lines configured by zsh-newuser-install
HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=e000
setopt prompt_subst
PROMPT='%F{yellow}%3~%F{green}$(git_branch) %F{red}» %F{reset}'
autoload -U colors && colors


# ========== KEYBINDINGS ========== #
# bindkey -v 					# Enable vi keybindings in zsh


# The following lines were added by compinstall
zstyle :compinstall filename '/Users/danishprakash/.zshrc'


# ========== SOURCES ========== #
source ~/z.sh
source /usr/local/share/zsh-autosuggestions/zsh-autosuggestions.zsh
source /usr/local/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
source ~/zsh-syntax-highlighting.zsh


# ========= ALIASES ========= #
alias gc='sudo git checkout'
alias ga='sudo git add'
alias gpu='sudo git push -u origin'
alias gm='sudo git commit -m'
alias ss='sudo git status'
alias gp='sudo git pull origin master'

alias src='source ~/.zshrc'
alias cl='clear'
alias rm='rm -i' 				# ask for confirmation before rm
alias ls='ls -F' 				# adds trailing '/' for dirs
alias v='sudo NVIM_TUI_ENABLE_TRUE_COLOR=1 nvim'

autoload -Uz compinit
compinit
# End of lines added by compinstalla


# ========== EXPORTS ========== #
export PATH=/usr/local/bin:/usr/local/Cellar:/bin:/usr/sbin:/sbin:/usr/bin
export EDITOR="/usr/local/bin/nvim"


# ========== VIRTUALENVWRAPPER CONFIG ========== #
export VIRTUALENVWRAPPER_PYTHON=/usr/local/bin/python2.7
export WORKON_HOME=$HOME/.virtualenvs
export PROJECT_HOME=$HOME/Devel
source /usr/local/bin/virtualenvwrapper.sh


# Add RVM to PATH for scripting. Make sure this is the last PATH variable change.
export PATH="$PATH:$HOME/.rvm/bin"

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
