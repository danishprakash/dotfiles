#           _
#   _______| |__  _ __ ___ 
#  |_  | __| '_ \| '__/ __|
#   / /\__ \ | | | | | (__ 
#  |___\___/_| |_|_|  \___|
# 



# FUNCTIONS ---

# exec into compile, execute container
function dex {
    PS=$(docker ps)
    CID=$(echo $PS | grep $1 | awk '{print $1}')
    CNAME=$(echo $PS | grep $1 | awk '{print $3}')
    echo "Exec(ing) into $CNAME:$CID"
    docker exec -it $CID sh
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
    dir=$(find . ~/programming -not -path '*/\.*' -type d -maxdepth 2 | fzf --layout=reverse --preview "ls -FG {}")
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


# zle -N edit_files_widget edit_files
# bindkey "^w" edit_files_widget


# function to start a timer in bg / pomodoro
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
    branch=$(git rev-parse --abbrev-ref HEAD 2> /dev/null | awk 'BEGIN{FS="/"} {print $NF}')
    if [[ $branch == "" ]];
    then
        :
    else
        echo '('$branch') '
    fi
}


# open man with `less` pager directly at a given switch
# e.g. mans ls -G -> will open man page for ls at -G option
function mans () {
    man -P "less -p \"^ +$2\"" $1
}



# OPTIONS ---

setopt ALWAYS_TO_END          # move cursor to end if word had one match
setopt APPEND_HISTORY         # Append history to the history file (no overwriting)
setopt AUTO_LIST              # automatically list choices on ambiguous completion
setopt AUTO_MENU              # automatically use menu completion
setopt HIST_EXPIRE_DUPS_FIRST # remove oldest duplicate entry when history needs to be trimmed
setopt HIST_FIND_NO_DUPS      # don't show duplicates when searching history
setopt HIST_IGNORE_ALL_DUPS   # remove older duplicate entries from history
setopt HIST_IGNORE_DUPS       # don't add duplicate entry to history file
setopt HIST_REDUCE_BLANKS     # remove superfluous blanks from history items
setopt INC_APPEND_HISTORY     # write history file as soon as command is entered
setopt MENU_COMPLETE          # insert first suggestion while autocompleting
setopt PROMPT_SUBST           # allow command, param and arithmetic expansion in the prompt
setopt SHARE_HISTORY          # Share history across terminals
setopt CORRECT                # correct spellings for misspelled commands
setopt LIST_PACKED            # make completion list smaller
setopt LIST_ROWS_FIRST        # match completions horizontally, not vertically

HISTSIZE=5000                 # How many lines of history to keep in memory
HISTFILE=~/.zsh_history       # Where to save history to disk
SAVEHIST=8000                 # Number of history entries to save to disk
HISTDUP=erase                 # Erase duplicates in the history file

# lines configured by zsh-newuser-install
export TERM=xterm-256color
PROMPT='%F{green}$(git_branch)%F{yellow}%2~ $ %F{reset}'

zstyle ':completion:*' menu select

fpath=(~/.zsh/completion $fpath)

autoload -Uz compinit
autoload -U zmv
compinit -i



# KEYBINDINGS ---

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
bindkey "^g" backward-word
bindkey "^f" forward-word
bindkey '^[[3^' kill-word

# insert arg from previous command
bindkey "^]" insert-last-word

# The following lines were added by compinstall
zstyle :compinstall filename '/Users/danishprakash/.zshrc'


# ALIAS ---

# open new file in vim with previous day's date (journal)
alias journal='nvim $(date -v-1d "+%d-%m-%Y").md'

# alias for function `doro` defined above
# runs a trivial pomodoro timer on the cli
alias pomo='doro'

# fuzzy find and checkout git branch
alias bra='git checkout $(git branch | fzf --layout=reverse) 2> /dev/null'

# fuzzy search history
alias hgrep='cat ~/.zsh_history | fzf'               

# consistency bw terminal and editor, not really
alias :q=exit                                        

# append C to count lines via pipe
alias -g C='| wc -l'                                 

# append L to pipe output to less
alias -g L='| less'                                  

# append P to copy command output via pipe
alias -g P='| pbcopy'                                

# format JSON output, -M - monochrome flag
alias -g J='| jq -M'                                 

# quick history grep
alias h='cat ~/.zsh_history | rg'                    

# ask for confirmation before rm
alias rm='rm -i'                                     
    
# adds trailing '/' for dirs and -G for colors
alias ls='ls -F'                                     
    
# list mode for ls with above flags
alias ll='ls -althF'                                 
    
# open .zshrc for editing
alias ez='nvim ~/.zshrc'                             
    
# source .zshrc
alias sz='source ~/.zshrc 2> /dev/null'              

# skip .git dir in trees
alias lt='tree -I '.git''                            

# colored output in grep
alias grep='grep --colour=auto'                      

# save to chars
alias vi='nvim'                                      

# fuzzy choose a venv to work on
alias venv='workon $(workon | fzf --layout=reverse)' 

# deploy blog to localhost
alias blog='bundle exec jekyll serve'                

# gcloud
alias gcdev='export CLOUDSDK_CORE_PROJECT=coderunner-dev'
alias gcprod='export CLOUDSDK_CORE_PROJECT=coderunner'

# check current application tag running on cluster
alias atag='kubectl get pods | head -n 2 | grep coderunner | awk '{print $1}' | xargs kubectl describe pod | grep git | awk -F ":" '{print $3}''



# SOURCES ---

# autocomplete pairs of delimiters
# source ~/autopair.zsh

# syntax highlighting for zsh
# source ~/zsh-syntax-highlighting.zsh

# suggestions from history
source /usr/local/share/zsh-autosuggestions/zsh-autosuggestions.zsh

source ~/z.sh

# docker completion
# source ~/zsh-docker-completion

# kubectl aliases
# https://github.com/ahmetb/kubectl-aliases
[ -f ~/.kubectl.zsh ] && source ~/.kubectl.zsh

# prints the complete command referred by the alias
# function kubectl() { echo "+ kubectl $@"; command kubectl $@; }

# echo aws profile in use when executing aws or sam commands
# function sam() { echo "+ using profile: $AWS_DEFAULT_PROFILE"; command sam $@; }
# function aws() { echo "+ using profile: $AWS_DEFAULT_PROFILE"; command aws $@; }



# EXPORTS ---

export PATH=/usr/local/bin:/usr/local/Cellar:/bin:/usr/sbin:/sbin:/usr/bin:/Library/TeX/Root/bin/x86_64-darwin/:$GOPATH/bin
export EDITOR="/usr/local/bin/nvim"
export GOPATH=$HOME/programming/go
export PATH=$PATH:$GOPATH
export PATH="$PATH:$HOME/.rvm/bin" # Add RVM to PATH for scripting. Make sure this is the last PATH variable change.
export AWS_REGION=us-west-2      # default region for aws/sam
export HOMEBREW_NO_AUTO_UPDATE=1 # disable homebrew update before install
export LC_ALL=en_US.UTF-8        # some weird warning nvim was throwing about locales
export DOCKER_BUILDKIT=1         # enable buildkit integration while doing docker build
export GO111MODULE=on            # enable `go mod` support in golang



# VIRTUALENVWRAPPER ---

export VIRTUALENVWRAPPER_PYTHON=/usr/local/bin/python3.7
export VIRTUALENVWRAPPER_VIRTUALENV=/usr/local/bin/virtualenv
export WORKON_HOME=~/virtualenvs
# source /usr/local/bin/virtualenvwrapper.sh

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
if [ /usr/local/bin/kubectl ]; then source <(kubectl completion zsh); fi

# tabtab source for serverless package
# uninstall by removing these lines or running `tabtab uninstall serverless`
[[ -f /usr/local/lib/node_modules/serverless/node_modules/tabtab/.completions/serverless.zsh ]] && . /usr/local/lib/node_modules/serverless/node_modules/tabtab/.completions/serverless.zsh
# tabtab source for sls package
# uninstall by removing these lines or running `tabtab uninstall sls`
[[ -f /usr/local/lib/node_modules/serverless/node_modules/tabtab/.completions/sls.zsh ]] && . /usr/local/lib/node_modules/serverless/node_modules/tabtab/.completions/sls.zsh
# tabtab source for slss package
# uninstall by removing these lines or running `tabtab uninstall slss`
[[ -f /usr/local/lib/node_modules/serverless/node_modules/tabtab/.completions/slss.zsh ]] && . /usr/local/lib/node_modules/serverless/node_modules/tabtab/.completions/slss.zsh

# The next line updates PATH for the Google Cloud SDK.
if [ -f '/Users/danish/Downloads/google-cloud-sdk/path.zsh.inc' ]; then . '/Users/danish/Downloads/google-cloud-sdk/path.zsh.inc'; fi

# The next line enables shell command completion for gcloud.
if [ -f '/Users/danish/Downloads/google-cloud-sdk/completion.zsh.inc' ]; then . '/Users/danish/Downloads/google-cloud-sdk/completion.zsh.inc'; fi

export PATH="$HOME/.yarn/bin:$HOME/.config/yarn/global/node_modules/.bin:$PATH"

# added by travis gem
[ -f /Users/danish/.travis/travis.sh ] && source /Users/danish/.travis/travis.sh
