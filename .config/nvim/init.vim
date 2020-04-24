" init.vim - nvim configuration
" =========================================================
" - https://github.com/danishprakash/dotfiles
" - danishpraka.sh


" Configurations ------------------------------------------

set background=dark
set belloff+=ctrlg                 " If Vim beeps during completion
set cursorline                     " highlight current cursor column
set expandtab                      " expand tab to spaces
set hlsearch                       " enable search highlights
set ignorecase                     " ignore case while searching
set magic                          " :h pattern
set mouse=a                        " enable mouse for `a`ll modes
set nomodeline                     " vim reading random lines as modelines
set noshowmode                     " hide current mode label
set nowrap                         " disable line wrapping
set number                         " always show line number
set relativenumber                 " show line numbers relative to the current line
set scrolloff=10                   " cursor remains at ~center of the window
set shiftwidth=4                   " tab width while autoindenting
set tabstop=4                      " tab width for things like :retab
set shortmess+=c                   " disable completion messages in statusline
set shortmess+=a                   " suppress a bunch of info messages
set shortmess+=I                   " don't show intro messages on startup
set showmatch                      " set show matching parenthesis
set undodir=~/.config/nvim/undodir " undo meta file location
set undofile                       " maintain undo history bw sessions
set ai                             " auto indent
set inccommand=nosplit             " interactive substitution
set smartindent                    " smart indent
set smartcase                      " override ignorecase if case is searched for explicitly
set signcolumn=yes                 " always show signcolumns
set cmdheight=1                    " prompt height
set hidden                         " temp coc.nvim configuration, if hidden is not set, TextEdit might fail.
set updatetime=300                 " Smaller updatetime for CursorHold & CursorHoldI
set backspace=eol,start,indent     " more natural backspace
set breakindent                    " indented line break


" Sources -------------------------------------------------

source ~/.config/nvim/plugins.vim
source ~/.config/nvim/extras.vim
source ~/.config/nvim/colors.vim
source ~/.config/nvim/mappings.vim
source ~/.config/nvim/functions.vim
source ~/.config/nvim/autocommands.vim
