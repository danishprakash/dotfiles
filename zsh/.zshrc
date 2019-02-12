#           _
#   _______| |__  _ __ ___ 
#  |_  | __| '_ \| '__/ __|
#   / /\__ \ | | | | | (__ 
#  |___\___/_| |_|_|  \___|
# 




# functions
# ---------

# clean docker mess
function dckcl() {
    DANGLING_IMAGES=$(docker images -f "dangling=true")
    DANGLING_IMAGES_NUM=$(docker images -f dangling=true | wc -l | tr -d '\t')
    echo "Removing $DANGLING_IMAGES_NUM images, continue (y/n)"
}

# move to the top-level parent directory
function cdp() {
    TEMP_PWD=`pwd`
    while ! [ -d .git ]; do
    cd ..
    done
    OLDPWD=$TEMP_PWD
}

# serve current directory using python HTTP server
function servedir() {
    # TODO: add handling for python3 and python
    ip_addr=$(ifconfig | grep 'broadcast' | awk '{print $2}')
    echo "Serving at: https://$ip_addr:8000"
    python3 -m http.server 8000
}

# search for a pattern and open the file
function rf() {
    result=$(rg --no-heading -n $1 . | fzf --reverse)
    file_path=$(echo $result | awk -F ':' '{print $1}')
    line_number=$(echo $result | awk -F ':' '{print $2}')
    nvim $file_path +$line_number
}

# find and kill process by pid
function kp() {
    kill -9 $(ps -ef | fzf --reverse | awk '{print $2}') &> /dev/null
    if [[ $? != "0" ]]
    then
        echo "Unable to kill process"
    fi
}

# facilitate new git repo
function create_repo() {
    git init &> /dev/null && echo "Created repo"
    echo -n "Add remote (y/n): "
    read choice
    if [[ $choice =~ ^[Yy]$ ]]
    then
        echo -n "Enter remote: "
        read remote
        git remote add origin $remote
    fi
}

# open fzf window with dirs and cd into it
function quick_find () {
    dir=$(find ~ ~/programming -not -path '*/\.*' -type d -maxdepth 1 | fzf --layout=reverse --preview "ls -FG {}")
    if [[ "$?" != "0" ]]; then return; fi;
    cd $dir
    zle reset-prompt
}

zle -N quick_find_widget quick_find # define a widget for the func above
bindkey "^o" quick_find_widget     # remap ^i to the widget -> func

# list all files in current dir tree wit preview
# select one to open in vim
function edit_files () {
    file=$(find . -type f -not -path '*/\.git/*' | fzf --layout=reverse --preview "cat {}")

    if [[ "$?" != "0" ]]; then
        return
    fi

    nvim $file
}

zle -N edit_files_widget edit_files
bindkey "^w" edit_files_widget

# function to start a timer in bg / pomodoro
alias pomo='doro'
function doro () {
    if [[ $# == 0 ]]; then
        let duration=1500           # no arguments -> 25 minutes
    else
        let duration=$(($1*60))
    fi
    sleep $duration
    (osascript -e 'tell application "System Events" to display dialog "Time for a water break!" buttons "OK" default button "OK"' && say "time up. STOP") &
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





# options
# -------

setopt HIST_IGNORE_ALL_DUPS  # remove older duplicate entries from history
setopt SHARE_HISTORY         # share history between different instances of the shell
setopt HIST_REDUCE_BLANKS    # remove superfluous blanks from history items
setopt AUTO_LIST             # automatically list choices on ambiguous completion
setopt MENU_COMPLETE	     # insert first suggestion while autocompleting
setopt PROMPT_SUBST          # allow command, param and arithmetic expansion in the prompt
setopt AUTO_MENU             # automatically use menu completion
setopt ALWAYS_TO_END         # move cursor to end if word had one match
setopt HIST_REDUCE_BLANKS
setopt INC_APPEND_HISTORY

# lines configured by zsh-newuser-install
export TERM=xterm-256color
HISTSIZE=1000
SAVEHIST=e000
HISTFILE=~/.histfile
PROMPT='%F{yellow}%2~%F{green}$(git_branch) %F{red}$ %F{reset}'

zstyle ':completion:*' menu select

fpath=(~/.zsh/completion $fpath)





# keybindings
# -----------

bindkey '^h' backward-delete-word
bindkey '^j' beginning-of-line
bindkey '^e' end-of-line
bindkey '^k' vi-change-eol
bindkey '^p' up-line-or-search
bindkey '^n' down-line-or-search
bindkey '^i' complete-word
bindkey '^f' emacs-forward-word
bindkey '^b' emacs-backward-word
bindkey '^b' emacs-backward-word
bindkey '^a' vi-beginning-of-line
bindkey '^k' vi-kill-eol
bindkey '^H' backward-kill-word

# insert arg from previous command
bindkey "^]" insert-last-word

# The following lines were added by compinstall
zstyle :compinstall filename '/Users/danishprakash/.zshrc'





# source
# ------

# autocomplete pairs of delimiters
source ~/autopair.zsh

# syntax highlighting for zsh
source ~/zsh-syntax-highlighting.zsh

# suggestions from history
source /usr/local/share/zsh-autosuggestions/zsh-autosuggestions.zsh

# docker completion
# source ~/zsh-docker-completion

# tmuxinator completion
# source ~/.tmuxinator-completion.zsh



# alias
# -----

alias -s py=nvim

alias :q=exit

alias -g C='| wc -l'
alias -g L='| less'
alias -g P='| pbcopy'
alias -g J='| jq'


# git
alias bra='git checkout $(git branch | fzf --layout=reverse) 2> /dev/null'
alias gpu='git push origin'
alias gp='git pull origin'
alias gd='git diff'
alias gpuf='git push -f origin'
alias gn='git num | wc -l'
alias gh="open `git remote -v | grep fetch | awk '{print $2}' | sed 's/git@/http:\/\//' | sed 's/com:/com\//'`| head -n1"

# general
alias rm='rm -i'                               # ask for confirmation before rm
alias ls='ls -FG'                              # adds trailing '/' for dirs and -G for colors
alias ll='ls -alFG'	                           # list mode for ls with above flags
alias ez='nvim ~/.zshrc'	                   # open .zshrc for editing
alias sz='source ~/.zshrc'	                   # source .zshrc
alias lt='tree -I '.git''	                   # skip .git dir in trees
alias grep='grep --colour=auto'                # colored output in grep
alias vi='nvim'
alias venv='workon $(workon | fzf --layout=reverse)'

alias blog='bundle exec jekyll serve'	       # deploy blog to localhost

autoload -Uz compinit
compinit -i





# exports
# -------

export PATH=/usr/local/bin:/usr/local/Cellar:/bin:/usr/sbin:/sbin:/usr/bin:/Library/TeX/Root/bin/x86_64-darwin/
export EDITOR="/usr/local/bin/nvim"
export GOPATH=$HOME/programming/hackerrank/go

# Add RVM to PATH for scripting. Make sure this is the last PATH variable change.
export PATH="$PATH:$HOME/.rvm/bin"
export AWS_REGION=us-west-2




# virtualenvwrapper
# -----------------

export VIRTUALENVWRAPPER_PYTHON=/usr/local/bin/python3.7
export VIRTUALENVWRAPPER_VIRTUALENV=/usr/local/bin/virtualenv
export WORKON_HOME=~/virtualenvs
source /usr/local/bin/virtualenvwrapper.sh

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
