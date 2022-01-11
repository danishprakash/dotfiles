#!/usr/bin/env bash

# .zshrc - z shell configuration
# =========================================================
# - https://github.com/danishprakash/dotfiles
# - danishpraka.sh


# Options -------------------------------------------------

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



# The following lines were added by compinstall
zstyle :compinstall filename '/Users/danishprakash/.zshrc'


# Source --------------------------------------------------

# work-specific configuration and exports
[ -f ~/.zsh.hackerrank ] && source ~/.zsh.hackerrank

# suggestions from history
source ~/zsh-autosuggestions.zsh

# z dir switcher
source ~/z.sh

# docker completion
# source ~/zsh-docker-completion

# kubectl aliases; https://github.com/ahmetb/kubectl-aliases
[ -f ~/.kubectl.zsh ] && source ~/.kubectl.zsh

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# The next line updates PATH for the Google Cloud SDK.
if [ -f '/Users/danish/google-cloud-sdk/path.zsh.inc' ]; then . '/Users/danish/google-cloud-sdk/path.zsh.inc'; fi

# The next line enables shell command completion for gcloud.
if [ -f '/Users/danish/google-cloud-sdk/completion.zsh.inc' ]; then . '/Users/danish/google-cloud-sdk/completion.zsh.inc'; fi

# added by travis gem
[ -f /Users/danish/.travis/travis.sh ] && source /Users/danish/.travis/travis.sh

# Add RVM to PATH for scripting. Make sure this is the last PATH variable change.
export PATH="$PATH:$HOME/.rvm/bin"
export PATH="$PATH:/usr/local/go/bin"

# source shell config
for file in ~/.zsh.{functions,prompt,exports,aliases,keybindings,paths,histdb,hackerrank}; do
	if [[ -r "$file" ]] && [[ -f "$file" ]]; then
		source "$file"
	fi
done
