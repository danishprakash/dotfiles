# ==========[ FUNCTIONS ]========== #

# open fzf window with dirs and cd into it
# TODO: add ability to clear prompt before cd(ing)
function quick_find () {
    dir=$(find ~ ~/programming -not -path '*/\.*' -type d -maxdepth 1 | fzf)
    echo -ne "$dir"
    cd $dir
}

zle -N quick_find_widget quick_find           # define a widget for the func above
bindkey "^p" quick_find_widget     # remap ^i to the widget -> func

# function to start a timer in bg / pomodoro
alias pomo='doro &'
function doro () {
    echo $1
    if [[ $# == 0 ]]; then
        let duration=1500           # no arguments -> 25 minutes
    else
        let duration=$(($1*60))
    fi
    sleep $duration
    osascript -e 'tell application "System Events" to display dialog "Time for a water break!" buttons "OK" default button "OK"' &
}

# figuring out current branch while supressing `not git repo` errors
function git_branch () {
    branch=$(git symbolic-ref HEAD 2> /dev/null | awk 'BEGIN{FS="/"} {print $NF}')
    if [[ $branch == "" ]];
    then
        :
    else
        echo ' ('$branch')'
    fi
}

# open man with `less` pager directly at a given switch
# e.g. mans ls -G -> will open man page for ls at -G option
function mans () {
    man -P "less -p \"^ +$2\"" $1
}

# start tmux on startup
# if [ "$TMUX" = "" ]; then tmux; fi


# ==========[ OPTIONS ]========== #
setopt auto_cd                  # auto cd when writing dir in the shell
setopt correctall               # correct typo(ed) commands
setopt prompt_subst             # allow command, param and arithmetic expansion in the prompt


# Lines configured by zsh-newuser-install
HISTSIZE=1000
SAVEHIST=e000
HISTFILE=~/.histfile
PROMPT='%F{yellow}%3~%F{green}$(git_branch) %F{red}» %F{reset}'


# ==========[ KEYBINDINGS ]========== #
# bindkey -v 					# Enable vi keybindings in zsh


# The following lines were added by compinstall
zstyle :compinstall filename '/Users/danishprakash/.zshrc'


# ==========[ SOURCES ]========== #
source ~/z.sh
source ~/zsh-syntax-highlighting.zsh
source /usr/local/share/zsh-autosuggestions/zsh-autosuggestions.zsh
source /usr/local/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh


# =========[ ALIASES ]========= #
alias ga='sudo git add'
alias gm='sudo git commit'
alias ss='sudo git status'
alias gc='sudo git checkout'
alias gpu='git push origin'
alias gp='git pull origin'

alias cl='clear'
alias rm='rm -i' 				                    # ask for confirmation before rm
alias ls='ls -FG' 				                    # adds trailing '/' for dirs and -G for colors
alias ez='nvim ~/.zshrc'
alias sz='source ~/.zshrc'
alias blog='bundle exec jekyll serve'
alias grep='grep --colour=auto'
alias vi='sudo NVIM_TUI_ENABLE_TRUE_COLOR=1 nvim'
alias shades='yes "$(seq 232 255;seq 254 -1 233)" | while read i; do printf "\x1b[48;5;${i}m\n"; sleep .01; done'

autoload -Uz compinit
compinit


# ==========[ EXPORTS ]========== #
export PATH=/usr/local/bin:/usr/local/Cellar:/bin:/usr/sbin:/sbin:/usr/bin
export EDITOR="/usr/local/bin/nvim"


# ==========[ VIRTUALENVWRAPPER CONFIG ]========== #
# export VIRTUALENVWRAPPER_PYTHON=/usr/bin/python
# export WORKON_HOME=$HOME/.virtualenvs
# export PROJECT_HOME=$HOME/Devel
# source /usr/local/bin/virtualenvwrapper.sh

# Add RVM to PATH for scripting. Make sure this is the last PATH variable change.
export PATH="$PATH:$HOME/.rvm/bin"

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
