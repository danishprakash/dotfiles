#!/usr/bin/env bash

# =============================================================================
# .zshrc - Z Shell Configuration
# =============================================================================
# - https://github.com/danishprakash/dotfiles
# - danishpraka.sh


# =============================================================================
# Options & Settings
# =============================================================================

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
setopt LIST_PACKED            # make completion list smaller
setopt LIST_ROWS_FIRST        # match completions horizontally, not vertically
# setopt CORRECT                # correct spellings for misspelled commands

zstyle ':completion:*' menu select
fpath=(~/.zsh/completion $fpath)
autoload -Uz compinit
autoload -U zmv
compinit -i
set -o vi

autoload -z edit-command-line
zle -N edit-command-line
bindkey "^X^E" edit-command-line

# The following lines were added by compinstall
zstyle :compinstall filename '/Users/danishprakash/.zshrc'


# =============================================================================
# Environment Variables & Exports
# =============================================================================

# SSH agent via gnome-keyring
export SSH_AUTH_SOCK="$XDG_RUNTIME_DIR/keyring/ssh"

export LIBVIRT_DEFAULT_URI="qemu:///system"

export EDITOR=$(which nvim)

# anki messes up if this is not disabled
export QT_AUTO_SCREEN_SCALE_FACTOR=0

# default region for aws/sam
export AWS_REGION=us-west-2

# disable homebrew update before install
export HOMEBREW_NO_AUTO_UPDATE=1

# some weird warning nvim was throwing about locales
export LC_ALL=en_US.UTF-8

# enable buildkit integration while doing docker build
export DOCKER_BUILDKIT=1

# enable `go mod` support in golang
export GO111MODULE=on

# How many lines of history to keep in memory
export HISTSIZE=5000

# Where to save history to disk
export HISTFILE=~/.zsh_history

# Number of history entries to save to disk
export SAVEHIST=8000

# Erase duplicates in the history file
export HISTDUP=erase

# use nvim for reading manpages
export MANPAGER="nvim +Man! -c 'set ft=man' -"

export FZF_DEFAULT_OPTS="--color='bw' --height=20% --layout='reverse'"

export FZF_DEFAULT_COMMAND='ag --hidden --ignore .git -l -g ""'

export TERM=xterm-256color

export NVIM_HOME="~/.config/nvim"

export SDK_DPI_SCALE=0.5

export SDK_SCALE=2

export PATH="$HOME/.rbenv/bin:$PATH"
eval "$(rbenv init -)"

export ANDROID_HOME="/home/danishprakash/Android/Sdk"

# color for history suggestions
ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=#5e5d5d'

export PAGER=less

# The next line updates PATH for the Google Cloud SDK.
if [ -f '/home/danishprakash/code/gcloud/google-cloud-sdk/path.zsh.inc' ]; then . '/home/danishprakash/code/gcloud/google-cloud-sdk/path.zsh.inc'; fi

# The next line enables shell command completion for gcloud.
if [ -f '/home/danishprakash/code/gcloud/google-cloud-sdk/completion.zsh.inc' ]; then . '/home/danishprakash/code/gcloud/google-cloud-sdk/completion.zsh.inc'; fi


# =============================================================================
# Paths
# =============================================================================

export GOPATH=$HOME/code/go

export VIRTUALENVWRAPPER_PYTHON=/usr/local/bin/python3.7

export VIRTUALENVWRAPPER_VIRTUALENV=/usr/local/bin/virtualenv

# Add RVM to PATH for scripting. Make sure this is the last PATH variable change.
export PATH="$PATH:$HOME/.rvm/bin"
export PATH="$PATH:/usr/local/go/bin"
export PATH="$PATH:$HOME/.local/share/gem/ruby/3.4.0/bin"
export PATH="/usr/local/bin:/usr/local/Cellar:/bin:/usr/sbin:/sbin:/usr/bin:$GOPATH/bin:$GOPATH:/usr/local/bin/:${PATH}"


# =============================================================================
# Aliases
# =============================================================================

alias kc='kubectl'
alias kx='kubectx'

# print ansi color codes
alias colors='for code in {000..255}; do print -P -- "$code: %F{$code}Color%f"; done'

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

# append P to copy command output via pipe
alias -g P='| pbcopy'

# quick history grep
alias h='cat ~/.zsh_history | rg'

# ask for confirmation before rm
alias rm='rm -i'

# adds trailing '/' for dirs and -G for colors
alias ls='ls -aF'

# list mode for ls with above flags
alias ll='ls -alhF'

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
alias bejs='bundle exec jekyll serve'

# check current application tag running on cluster
alias atag='kubectl get pods | head -n 2 | grep coderunner | awk '{print $1}' | xargs kubectl describe pod | grep git | awk -F ":" '{print $3}''

alias isc='osc -A api.suse.de'


# =============================================================================
# Functions
# =============================================================================

# override fzf history widget to use history from mariadb
# displays command history with relative timestamps in a columnar format
# adapts to terminal width to ensure timestamps are always visible
fzf-history-widget() {
    # calculate dynamic column widths based on terminal size
    local term_width=$(tput cols)
    local time_width=15
    local cmd_width=$((term_width - time_width - 5))

    # query mariadb for command history with timestamps
    # groups by command to show unique commands with their most recent execution time
    # optimized: only processes the 10000 most recent commands for speed
    local selected=$(mariadb -ucli-history -B -N -e "
        select
            command,
            UNIX_TIMESTAMP(created) as ts
        from (
            select command, created
            from sh.history
            order by created desc
            limit 10000
        ) as recent
        group by command
        order by max(ts) desc;" |
        awk -F'\t' -v now="$(date +%s)" -v cmd_w="$cmd_width" '
        # convert unix timestamp to human-readable relative time
        function relative_time(ts) {
            diff = now - ts
            if (diff < 60) return "just now"
            if (diff < 3600) return int(diff/60) "m ago"
            if (diff < 86400) return int(diff/3600) "h ago"
            if (diff < 172800) return "yesterday"
            if (diff < 604800) return int(diff/86400) "d ago"
            if (diff < 2592000) return int(diff/604800) "w ago"
            if (diff < 31536000) return int(diff/2592000) "mo ago"
            return int(diff/31536000) "y ago"
        }
        {
            cmd = $1
            ts = $2
            rel = relative_time(ts)
            # truncate long commands to fit terminal width
            if (length(cmd) > cmd_w) {
                cmd = substr(cmd, 1, cmd_w - 3) "..."
            }
            # format as: "command │ time" with proper column alignment
            printf "%-*s │ %s\n", cmd_w, cmd, rel
        }' |
        FZF_DEFAULT_OPTS= fzf \
            --height=40% \
            --layout=reverse \
            --border=sharp \
            --header-first \
            --delimiter=' │ ' \
            --with-nth=1,2 \
            --nth=1 \
            --tiebreak=index \
            --bind=ctrl-r:toggle-sort \
            --query=${LBUFFER} \
            --no-multi \
            --no-info \
            --prompt='> ' \
            --pointer='→ ' \
            --color='bw' \
            --ansi)
    local ret=$?

    # extract just the command part (strip timestamp and truncation marker)
    if [[ -n "$selected" ]]; then
        BUFFER=$(echo "$selected" | awk -F' │ ' '{print $1}' | sed 's/[[:space:]]*$//' | sed 's/\.\.\.$//')
        CURSOR=$#BUFFER
    fi

    zle reset-prompt
    return $ret
}
zle     -N   fzf-history-widget
bindkey '^R' fzf-history-widget

# wrapper over frequently used kubectl subcommands
kr() {
    POD_ID=$(kubectl get pods | fzf --reverse | awk '{print $1}')
    case $1 in
        --delete|-d)
            CMD="kubectl delete pod '${POD_ID}'"
            echo "${CMD}"; eval "${CMD}"
            if [[ $? != "0" ]]
            then
                echo "unable to kill pod"
            fi
            ;;
        --exec|-e)
            CONTAINER=$(echo "${POD_ID}" | sed 's/\-[a-zA-Z0-9]\{8,10\}.*//g')
            CMD="kubectl exec '${POD_ID}' --container '${CONTAINER}' --stdin --tty -- sh"
            echo "${CMD}"; eval "${CMD}"
            if [[ $? != "0" ]]
            then
                echo "unable to exec into pod"
            fi
            ;;
        --logs|-l)
            CONTAINER=$(echo "${POD_ID}" | sed 's/\-[a-zA-Z0-9]\{8,10\}.*//g')
            CMD="kubectl logs --follow '${POD_ID}' --container '${CONTAINER}'"
            echo "${CMD}"; eval "${CMD}"
            if [[ $? != "0" ]]
            then
                echo "unable to fetch logs for pod"
            fi
            ;;
        --tag|-t)
            CMD="kubectl describe pod '${POD_ID}' | grep Image | grep -i coderunner:git | awk -F'-' '{print \$NF}'"
            echo "${CMD}"; eval "${CMD}"
            if [[ $? != "0" ]]
            then
                echo "unable to fetch image tag for pod"
            fi
    esac
}


# create a temporary file and open it for editing
tmpf() {
    dir=$(mktemp /var/tmp/"tmp.$(date +'%Y%m%d-%H%M%S').XXXXX")
    ${EDITOR} +"set filetype=$1" + "$dir"
}


# create a temporary directory and enter it
tmpd() {
	local dir
	if [ $# -eq 0 ]; then
		dir=$(mktemp -d)
	else
		dir=$(mktemp -d -t "${1}.XXXXXXXXXX")
	fi
	cd "$dir" || exit
}


# exec into docker container
de() {
  local cid
  cid=$(docker ps -a --format "{{.ID}} \t{{.Names}}\t {{.Status}}\t{{.Image}}" | sed 1d | fzf -1 -q "$1" | awk '{print $1}')
  [ -n "$cid" ] && docker exec -it "$cid" sh
}


# serve current directory over http
serve() {
	local port="${1:-8000}"
	sleep 1 && open "http://localhost:${port}/" &

	# Set the default Content-Type to `text/plain` instead of `application/octet-stream`
	# And serve everything as UTF-8 (although not technically correct, this doesn't break anything for binary files)
	python -c $'import SimpleHTTPServer;\nmap = SimpleHTTPServer.SimpleHTTPRequestHandler.extensions_map;\nmap[""] = "text/plain";\nfor key, value in map.items():\n\tmap[key] = value + ";charset=UTF-8";\nSimpleHTTPServer.test();' "$port"
}


# better history command
fh() {
    print -z $( ([ -n "$ZSH_NAME" ] && fc -l 1 || history | uniq) | fzf +s --tac | sed 's/ *[0-9]* *//')
}


# exec into compile, execute container
dex() {
    PS=$(docker ps)
    CID=$(echo $PS | grep $1 | awk '{print $1}')
    CNAME=$(echo $PS | grep $1 | awk '{print $3}')
    echo "Exec(ing) into $CNAME:$CID"
    docker exec -it $CID sh
}


# move to the top-level parent directory
cdp() {
    TEMP_PWD=`pwd`
    while ! [ -d .git ]; do
        cd ..
    done
    OLDPWD=$TEMP_PWD
}


# search for a pattern and open the file
rf() {
    result=$(rg --no-heading -n $1 . | fzf --reverse)
    file_path=$(echo $result | awk -F ':' '{print $1}')
    line_number=$(echo $result | awk -F ':' '{print $2}')
    ${EDITOR} $file_path +$line_number
}


# find and kill process by pid
kp() {
    kill -9 $(ps -ef | fzf --reverse | awk '{print $2}') &> /dev/null
    if [[ $? != "0" ]]
    then
        echo "Unable to kill process"
    fi
}


# facilitate new git repo
create_repo() {
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
quick_find() {
    dir=$(find . -not -path '*/\.*' -type d -maxdepth 2 | fzf --layout=reverse --preview "ls -FG {}")
    if [[ "$?" != "0" ]]; then return; fi;
    cd $dir
    zle reset-prompt
}
# zle -N quick_find_widget quick_find # define a widget for the func above
# bindkey "^o" quick_find_widget     # remap ^i to the widget -> func

# list all files in current dir tree wit preview
# select one to open in vim
edit_files() {
    file=$(find . -type f -not -path '*/\.git/*' | fzf --layout=reverse --preview "cat {}")

    if [[ "$?" != "0" ]]; then
        return
    fi

    ${EDITOR} $file
}

zle -N quick_find_widget edit_files # define a widget for the func above
bindkey "^o" quick_find_widget     # remap ^i to the widget -> func


# function to start a timer in bg / pomodoro
doro() {
    if [[ $# == 0 ]]; then
        let duration=1500           # no arguments -> 25 minutes
    else
        let duration=$(($1*60))
    fi
    sleep $duration
    (osascript -e 'tell application "System Events" to display dialog "Time for a water break!" buttons "OK" default button "OK"' && say "time up. STOP") &
}


# open man with `less` pager directly at a given switch
# e.g. mans ls -G -> will open man page for ls at -G option
mans() {
    man -P "less -p \"^ +$2\"" $1
}

# prints the complete command referred by the alias
# kubectl() { echo "+ kubectl $@"; command kubectl $@; }

# echo aws profile in use when executing aws or sam commands
# sam() { echo "+ using profile: $AWS_DEFAULT_PROFILE"; command sam $@; }
# aws() { echo "+ using profile: $AWS_DEFAULT_PROFILE"; command aws $@; }


# =============================================================================
# Keybindings
# =============================================================================
# https://zsh.sourceforge.io/Doc/Release/Zsh-Line-Editor.html#index-binding-keys

bindkey '^f' vi-forward-word
bindkey "^g" vi-forward-blank-word
bindkey "^j" vi-backward-word
bindkey '^h' vi-backward-blank-word

bindkey '^e' end-of-line
bindkey '^k' vi-change-eol
bindkey '^p' up-line-or-search
bindkey '^n' down-line-or-search
bindkey '^i' complete-word
bindkey '^a' vi-beginning-of-line
bindkey '^k' vi-kill-eol
bindkey "^y" vi-yank-whole-line
bindkey '^[[3^' kill-word
# bindkey '^h' backward-delete-word

# insert arg from previous command
bindkey "^]" insert-last-word

bindkey "^P" history-beginning-search-backward
bindkey "^N" history-beginning-search-forward
bindkey -M vicmd '/' history-incremental-pattern-search-backward


# =============================================================================
# Prompt Configuration
# =============================================================================

# figuring out current branch while supressing `not git repo` errors
function git_branch() {
    # branch=$(git rev-parse --abbrev-ref HEAD 2>/dev/null)
    branch=$(git branch --show-current 2>/dev/null)
    if [[ ${branch} == "" ]]; then
        :
    else
        echo ${branch}':'
    fi
}

SEP=' %F{reset}\ '

PROMPT='%F{white}$(git_branch)'
PROMPT+='%F{white}%2~ '

# conditional expression
# checks the result of the previous
# command executed, the string after
# the first "." is executed when the
# command returned successfully and the
# string after the second "." otherwise
PROMPT+='%(?.%F{white}%(!.#.$)%F .%F{red}%(!.#.$) )%F{reset}'


# =============================================================================
# History Database Integration
# =============================================================================
# catches original bash, writes them to mariadb or sqlite3 file
# place it to the end of ~/.bashrc
# need to find original author of preexec_invoke_exec, google it :)
# source: https://github.com/digitalist/bash_database_history

#-------------------------------------------------------------------
# Create db and schema
#-------------------------------------------------------------------
# create database if not exists bash ;
# use bash ;
# -- drop table `history`;
# CREATE TABLE `history` (
#   `oid` bigint(20) NOT NULL AUTO_INCREMENT,
#   `command` TEXT,
#   `arguments` TEXT,
#   `cwd` TEXT,
#   `created` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
#   `tag` TEXT,
#   PRIMARY KEY (`oid`),
#   KEY `created` (`created`)
# ) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ;

preexec() {
    BASH_COMMAND=$1
    if [[ -z "$HISTORY_TAG" ]]; then
        HISTORY_TAG=''
    else
        echo TAG: $HISTORY_TAG
    fi

    [ -n "$COMP_LINE" ] && return                     # do nothing if completing
    [ "$BASH_COMMAND" = "$PROMPT_COMMAND" ] && return # don't cause a preexec for $PROMPT_COMMAND

    # get current command
    local cur_cmd=$(echo $1 | sed -e "s/^[ ]*[0-9]*[ ]*//g")
    cwd=$(pwd)
    # optional: ignore alias for mariadb history search
    [[ "$BASH_COMMAND" =~ historyMysql* ]] && return
    # optional: ignore pyenv
    [[ "$BASH_COMMAND" =~ _pyenv_virtualenv_hook* ]] && return

    # TODO
    # ARGS=$@

    # place ESCAPED $BASH_COMMAND into $BASH_COMMAND_ESCAPE variable
    printf -v BASH_COMMAND_ESCAPE "%q" "$BASH_COMMAND" # from https://stackoverflow.com/a/4383994/5006740

    # trap and write to db
    mariadb -ucli-history -e "INSERT INTO sh.history (oid, command, arguments, cwd, created, tag) values (0, '${BASH_COMMAND_ESCAPE}', '', '$cwd', NOW(), '$HISTORY_TAG' )"
}


# =============================================================================
# External Sources & Third-party Tools
# =============================================================================

# work-specific configuration and exports
[ -f ~/.zsh.hackerrank ] && source ~/.zsh.hackerrank

# suggestions from history
# source ~/zsh-autosuggestions.zsh
source ~/code/dotfiles/zsh-contextualcomplete-lean.sh

# z dir switcher
source ~/z.sh

# docker completion
# source ~/zsh-docker-completion

# kubectl aliases; https://github.com/ahmetb/kubectl-aliases
[ -f ~/.kubectl.zsh ] && source ~/.kubectl.zsh

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# added by travis gem
[ -f /Users/danish/.travis/travis.sh ] && source /Users/danish/.travis/travis.sh

export PATH=$PATH:$HOME/.maestro/bin

# pnpm
export PNPM_HOME="/home/danishprakash/.local/share/pnpm"
case ":$PATH:" in
  *":$PNPM_HOME:"*) ;;
  *) export PATH="$PNPM_HOME:$PATH" ;;
esac
# pnpm end

# The next line updates PATH for the Google Cloud SDK.
if [ -f '/tmp/tmp.4QHP1XNYPT/google-cloud-sdk/path.zsh.inc' ]; then . '/tmp/tmp.4QHP1XNYPT/google-cloud-sdk/path.zsh.inc'; fi

# The next line enables shell command completion for gcloud.
if [ -f '/tmp/tmp.4QHP1XNYPT/google-cloud-sdk/completion.zsh.inc' ]; then . '/tmp/tmp.4QHP1XNYPT/google-cloud-sdk/completion.zsh.inc'; fi

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion