"         _
"  __   _(_)_ __ ___  _ __ ___ 
"  \ \ / / | '_ ` _ \| '__/ __|
"   \ V /| | | | | | | | | (__ 
"    \_/ |_|_| |_| |_|_|  \___|
" 



" vim-zen
" -------

call plug#begin()

" code formatting
Plug 'w0rp/ale'
Plug 'ambv/black'
Plug 'sheerun/vim-polyglot'
Plug 'pangloss/vim-javascript'
Plug 'prettier/vim-prettier'
Plug 'tell-k/vim-autopep8'
" Plug 'google/vim-maktaba'
" Plug 'google/vim-codefmt'

" colorschemes
Plug 'joshdick/onedark.vim'
Plug 'arcticicestudio/nord-vim'
" Plug 'ewilazarus/preto'

" local fork of preto to disable bold fonts
Plug '~/.local/share/nvim/plugged/preto'

" when someone else is using my setup
Plug 'sickill/vim-monokai'

" Go dev
Plug 'fatih/vim-go'

" table mode
Plug 'godlygeek/tabular'
Plug 'dhruvasagar/vim-table-mode'

" general utils
Plug 'danishprakash/vim-githubinator'
Plug 'danishprakash/vimport'
Plug 'ludovicchabant/vim-gutentags'
Plug '/usr/local/opt/fzf'
Plug 'junegunn/fzf.vim'
Plug 'ervandew/supertab'
Plug 'junegunn/goyo.vim'
Plug 'simeji/winresizer'
Plug 'tpope/vim-surround'
Plug 'townk/vim-autoclose'
Plug 'tpope/vim-commentary'
Plug 'airblade/vim-gitgutter'
Plug 'davidhalter/jedi-vim'
Plug 'SirVer/ultisnips'
Plug 'honza/vim-snippets'
Plug 'scrooloose/nerdtree'
Plug 'tpope/vim-eunuch'
Plug 'tpope/vim-fugitive'
Plug 'ap/vim-buftabline'

" self
" Plug '/Users/danishprakash/programming/vim-md'
" Plug '/Users/danishprakash/programming/vimport'
" Plug '/Users/danishprakash/programming/vim-blameline'
" Plug '/Users/danishprakash/programming/vim-githubinator'

call plug#end()





" globals
" -------

" define leader key
" let mapleader='\\'

" hide bloat in NERDTree
let g:NERDTreeMinimalUI=1

" python execs for nvim
let g:python2_host_prog = '/usr/local/bin/python'
let g:completor_python_binary = '/usr/local/bin/python3'
let g:python3_host_prog = '/usr/local/Cellar/python3/3.6.3/bin/python3'

" use default mappings for vim-githubinator
let g:githubinator_no_default_mapping=0

" vim-jedi
let g:jedi#auto_vim_configuration = 0
let g:jedi#use_splits_not_buffers = 'left'
let g:jedi#popup_select_first = 0
let g:jedi#show_call_signatures = '1'

" scroll through suggestion in up->down manner
let g:SuperTabDefaultCompletionType = '<C-n>'
let g:SuperTabContextDefaultCompletionType = '<c-x><c-o>'
set omnifunc=jedi#completions

" linters for ale
let g:ale_linters = {'python': ['flake8'], 'javascript': ['eslint']}

" UltiSnipps
let g:UltiSnipsJumpForwardTrigger='<c-r>'
let g:UltiSnipsJumpBackwardTrigger='<c-t>'

" If you want :UltiSnipsEdit to split your window.
let g:UltiSnipsEditSplit='vertical'

let g:vimwiki_list = [{'path': '~/vimwiki/',
                      \ 'syntax': 'markdown', 'ext': '.md'}]




" configurations
" --------------

set linebreak
set background=dark
set ignorecase           " ignore case while searching
set number               " always show line number
set relativenumber       " show line numbers relative to the current line
" set cursorline           " highlight current cursor column
set showmatch            " set show matching parenthesis
set hlsearch             " enable search highlights
set scrolloff=10         " cursor remains at ~center of the window
set shortmess+=c         " Shut off completion messages
set belloff+=ctrlg       " If Vim beeps during completion
set noshowmode           " hide current mode label
set mouse=a              " enable mouse for `a`ll modes
set tabstop=4
set shiftwidth=4
set expandtab
set completeopt+=menuone
set nohlsearch
set magic
set t_Co=256
set undofile	         " maintain undo history bw sessions
set undodir=~/.config/nvim/undodir

" folding
set foldmethod=indent
set foldlevel=10

" set ruler
" set ai                   " auto indent
" set si                   " smart indent
" set mouse=a              " allows mouse interaction within vim
" set completeopt-=preview " deoplete: turn off preview window
" set clipboard=unnamed    " set system clipboard as vim clipboard
" set smartcase





" autocmds
" --------

" remember cursor position while switching buffer
if v:version >= 700
  au BufLeave * let b:winview = winsaveview()
  au BufEnter * if(exists('b:winview')) | call winrestview(b:winview) | endif
endif

" source vimrc when saved 
augroup VimReload
    autocmd!
    autocmd BufWritePost $MYVIMRC source $MYVIMRC
augroup END

" setting wrap while editing markdown files
autocmd FileType markdown set wrap

" start nerdtree on start-up 
" autocmd VimEnter * NERDTree

autocmd FileType python setlocal completeopt-=preview





" remappings
" ----------

" keybinding for tags fuzzy finder
nnoremap <leader>t :Tags<CR>

" add daily journal title
nnoremap <leader>jj :r! echo %<CR>

" cycle through buffers
nnoremap <silent><C-n> :bnext<CR>
nnoremap <silent><C-p> :bprevious<CR>

" add new line(o/O) without entering insert mode
nnoremap <leader>o o<esc>
nnoremap <leader>O O<esc>

" overwrite write op on protected files
cnoremap w!! execute 'silent! write !sudo tee % >/dev/null' <bar> edit!

" remap C-/ to comment out the current line
nnoremap <C-_> gcc

" toggle gitgutter
nnoremap <leader>gt :GitGutterToggle<CR>

" open file finder
nnoremap <leader>1 :Files<CR>

" open line finder
nnoremap <leader>2 :Lines<CR>

" open buffer finder
nnoremap <leader>b :Buffers<CR>

" search using rg
nnoremap <leader>4 :Rg <c-r>=expand("<cword>")<cr><CR>

" \_ uses last changed or yanked text as an object
onoremap <leader>_ :<C-U>normal! `[v`]<CR>

" remap return to ':'
nnoremap <CR> :

" start nerdtree 
nnoremap <leader>nd :NERDTreeToggle<CR>

" hit enter to insert highlighted item in popup list
inoremap <expr> <CR> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"

" enable Goyo for markdown writing and toggle ALE
nnoremap <silent> <leader>go :Goyo 90<cr> :call FocusedMode()<cr> :set showtabline=0<CR>

" execute current buffer with python3 
autocmd FileType python nnoremap <buffer> <F9> :exec '!python3' shellescape(@%, 1)<cr>

" codefmt 
nnoremap <leader>fm :FormatCode<cr>
vnoremap <leader>fm :FormatLines<cr>

" ALE toggle
nnoremap <leader>al :ALEToggle<cr>

" moving across splits
nnoremap <C-h> <C-w>h
nnoremap <C-l> <C-w>l
" nnoremap <C-j> <C-w>j
" nnoremap <C-k> <C-w>k

" open a vertical split window and fire up FZF
nnoremap <leader>v :vnew<cr>:Files<cr>

" convert current word to uppercase and enter insert mode
nnoremap <S-u> viwU<esc>el

" comment using commentary
nnoremap <silent><leader>q :bd<cr>

" save current file
nnoremap <leader>p <esc>:w<cr>

" surround current word with double-quotes
nnoremap <leader>" viw<esc>a"<esc>hbi"<esc>lel

" open vimrc in vertial split and source it
nnoremap <leader>ev :vsplit $MYVIMRC<cr>
nnoremap <leader>so :so $MYVIMRC<cr>

" move around wrapped lines as if separate lines
noremap <silent> j gj
noremap <silent> k gk

" move to beginning/end of line
nnoremap H ^
nnoremap L $

"move 5 lines up and down while holding Shift and j/k
nnoremap <silent> <C-j> :+5 <CR>
nnoremap <silent> <C-k> :-5 <CR>

" source plugin file (dev)
nnoremap <leader>sp :so /Users/danishprakash/.local/share/nvim/site/autoload/zen.vim<cr>

" flash the current line when changing window position using `zz`
nnoremap <silent>zz zz :call StrobeCursorLine()<CR>





" colors
" ------

syntax on
colorscheme preto
filetype on
filetype plugin indent on
set listchars=tab:│\ ,nbsp:␣,trail:∙,extends:>,precedes:<
set fillchars=vert:\│

" hi LineNr ctermbg=236 
" hi Default guibg=238
" hi Normal guibg=238
" hi Search ctermbg=58 ctermfg=15
" hi CursorLine guibg=#363b47
" hi CursorLineNr guibg=#363b47 guifg=#ffffff 

" hi clear SignColumn
" hi SignColumn ctermbg=238
" hi EndOfBuffer ctermfg=235 ctermbg=235
" hi GitGutterAdd ctermbg=235 ctermfg=235
" hi GitGutterChange ctermbg=235 ctermfg=235
" hi GitGutterDelete ctermbg=235 ctermfg=235
" hi GitGutterChangeDelete ctermbg=235 ctermfg=235
hi CursorLine ctermbg=235
hi Visual ctermbg=darkgray ctermfg=black cterm=bold

" settings are specific to preto colorscheme
hi ALEError cterm=none
hi Comment cterm=none

" hi Visual guibg=LightGray guifg=Black gui=bold
" hi VertSplit guibg=235

" enable 256 color support
" if (has("nvim"))
"     let $NVIM_TUI_ENABLE_TRUE_COLOR=1
" endif

" if (has("termguicolors"))
"     set termguicolors
" endif




" statusline
" ----------

" function to return branch name of working directory
function! GitBranch() abort
    let l:branch = system("git symbolic-ref HEAD 2&> /dev/null | awk 'BEGIN{FS=\"/\"} {print $3}'")
    return len(l:branch) > 0 ? substitute(l:branch, '\n', '', '') : '!' 
endfunction

set statusline=                         " clear the statusline
set statusline+=%#FilePath#             " filepath highlight group
set statusline+=\ %f\                   " name of the file

if GitBranch() !=# '!'
    set statusline+=%#GitBranch#            " git branch highlight group
    set statusline+=\ [%{GitBranch()}]\     " git branch
endif

set statusline+=%#Sep1#                 " empty space in the middle
set statusline+=%=                      " right align items henceforth
set statusline+=%#FileType#\ -          " filetype highlight group
set statusline+=\ %Y\ -                 " filetype
set statusline+=%#CursorInfo#           " cursor info highlight group
set statusline+=\ [%l:%c]               " current row and column
set statusline+=\ %p\                   " percentage of file at current cursor position

" statusline colors
" " NOTE: use cterm if `set termguicolors`
" hi statusline guibg=#3d3e3f guifg=#3d3e3f
" hi FilePath guibg=#88C0D0 guifg=#8f8f8f
" hi FileType guibg=#4C566A guifg=#4f4f4f
" hi CursorInfo guibg=#4C566A guifg=#4f4f4f
" hi Sep1 guibg=#2E3440 guifg=#282C34
hi StatusLine ctermbg=236
hi GitBranch ctermfg=white ctermbg=236

set fillchars=eob:\ 


" functions
" ---------

" enable focused writing mode
function! FocusedMode()
    exec 'normal :Goyo'
    set showtabline=0
    set nocursorline
    syntax off
    exec 'normal! :ALEToggle'
endfunction

" blink cursorline for searches
nnoremap <silent> n n:cal StrobeCursorLine()<cr>
nnoremap <silent> N N:call StrobeCursorLine()<cr>

function! StrobeCursorLine()
    for l:count in range(3)
        set invcursorline
        redraw
        exec 'sleep 10m'
        set invcursorline
        redraw
        exec 'sleep 10m'
    endfor
endfunction

" reload file if changed outside of vim (think branch changes)
" Triger `autoread` when files changes on disk
" https://unix.stackexchange.com/questions/149209/refresh-changed-content-of-file-opened-in-vim/383044#383044
" https://vi.stackexchange.com/questions/13692/prevent-focusgained-autocmd-running-in-command-line-editing-mode
autocmd FocusGained,BufEnter,CursorHold,CursorHoldI * if mode() != 'c' | checktime | endif
" Notification after file change
" https://vi.stackexchange.com/questions/13091/autocmd-event-for-autoread
autocmd FileChangedShellPost *
  \ echohl WarningMsg | echo "File changed on disk. Buffer reloaded." | echohl None
