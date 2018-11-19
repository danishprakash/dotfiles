"         _
"  __   _(_)_ __ ___  _ __ ___ 
"  \ \ / / | '_ ` _ \| '__/ __|
"   \ V /| | | | | | | | | (__ 
"    \_/ |_|_| |_| |_|_|  \___|
" 



" vim-zen
" -------

call zen#init()

" code formatting
Plugin 'w0rp/ale'
Plugin 'ambv/black'
Plugin 'sheerun/vim-polyglot'
Plugin 'pangloss/vim-javascript'
Plugin 'prettier/vim-prettier'
" Plugin 'google/vim-maktaba'
" Plugin 'google/vim-codefmt'

" colorschemes
Plugin 'morhetz/gruvbox'
Plugin 'joshdick/onedark.vim'
Plugin 'arcticicestudio/nord-vim'
Plugin 'Lokaltog/vim-monotone'

" table mode
Plugin 'godlygeek/tabular'
Plugin 'dhruvasagar/vim-table-mode'

" general utils
Plugin '/usr/local/opt/fzf'
Plugin 'junegunn/fzf.vim'
Plugin 'ervandew/supertab'
Plugin 'junegunn/goyo.vim'
Plugin 'simeji/winresizer'
Plugin 'tpope/vim-surround'
" Plugin 'scrooloose/nerdtree'
Plugin 'townk/vim-autoclose'
Plugin 'tpope/vim-commentary'
Plugin 'airblade/vim-gitgutter'
Plugin 'davidhalter/jedi-vim'
Plugin 'ap/vim-css-color'
Plugin 'SirVer/ultisnips'
Plugin 'honza/vim-snippets'
Plugin 'ap/vim-buftabline'

" self
Plugin '/Users/danishprakash/programming/vimport'
Plugin '/Users/danishprakash/programming/vim-githubinator'
Plugin '/Users/danishprakash/programming/vim-md'

" Plugin 'prakashdanish/vim-githubinator'
" Plugin 'prakashdanish/vimport'





" globals
" -------

" define leader key
let g:leader="\\"

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
let g:jedi#use_splits_not_buffers = "left"
let g:jedi#popup_select_first = 0
let g:jedi#show_call_signatures = "1"

" scroll through suggestion in up->down manner
let g:SuperTabDefaultCompletionType = '<C-n>'
let g:SuperTabContextDefaultCompletionType = "<c-x><c-o>"
set omnifunc=jedi#completions

" linters for ale
let g:ale_linters = {'python': ['flake8'], 'javascript': ['eslint']}

" smooth scrolling remaps
let g:comfortable_motion_scroll_down_key = "j"
let g:comfortable_motion_scroll_up_key = "k"

" UltiSnipps
let g:UltiSnipsExpandTrigger='<tab>'
let g:UltiSnipsJumpForwardTrigger='<c-b>'
let g:UltiSnipsJumpBackwardTrigger='<c-z>'

" If you want :UltiSnipsEdit to split your window.
let g:UltiSnipsEditSplit='vertical'





" configurations
" --------------

set nowrap
set background=dark
set smartcase
set ignorecase           " ignore case while searching
set number               " always show line number
set relativenumber       " show line numbers relative to the current line
set cursorline           " highlight current cursor column
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





" autocmds
" --------

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

" cycle through buffers
nnoremap <C-n> :bnext<CR>
nnoremap <C-p> :bprevious<CR>

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
nnoremap <leader>1 :GFiles<CR>

" open line finder
nnoremap <leader>2 :Lines<CR>

" open buffer finder
nnoremap <leader>3 :Buffers<CR>

" search using rg
nnoremap <leader>4 :Rg 

" \_ uses last changed or yanked text as an object
onoremap <leader>_ :<C-U>normal! `[v`]<CR>

" remap return to ':'
nnoremap <CR> :

" start nerdtree 
nnoremap <leader>nd :NERDTreeToggle<CR>

" hit enter to insert highlighted item in popup list
inoremap <expr> <CR> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"

" enable Goyo for markdown writing and toggle ALE
nnoremap <silent> <leader>go :Goyo 90<cr> :ALEToggle<cr> :set showtabline=0<CR>

" execute current buffer with python3 
autocmd FileType python nnoremap <buffer> <F9> :exec '!python3' shellescape(@%, 1)<cr>

" codefmt 
nnoremap <leader>fm :FormatCode<cr>
vnoremap <leader>fm :FormatLines<cr>

" ALE toggle
nnoremap <leader>al :ALEToggle<cr>

" moving across splits
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l

" open a vertical split window and fire up FZF
nnoremap <leader>v :vnew<cr>:FZF ~/programming<cr>

" convert current word to uppercase and enter insert mode
nnoremap <S-u> viwU<esc>el

" comment using commentary
nnoremap <leader>q :bd<cr>

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





" colors
" ------

syntax on
colorscheme nord
filetype on
filetype plugin indent on
set listchars=tab:│\ ,nbsp:␣,trail:∙,extends:>,precedes:<
set fillchars=vert:\│

" hi LineNr ctermfg=1 ctermbg=1
" hi LineNr guifg=#000000 guibg=#2d313a
hi Default ctermfg=1
hi Search ctermbg=58 ctermfg=15
hi CursorLine guibg=#363b47
" hi CursorLineNr guibg=#363b47 guifg=#ffffff 

hi clear SignColumn
hi SignColumn ctermbg=235
" hi EndOfBuffer ctermfg=235 ctermbg=235
hi GitGutterAdd ctermbg=235 ctermfg=235
hi GitGutterChange ctermbg=235 ctermfg=235
hi GitGutterDelete ctermbg=235 ctermfg=235
hi GitGutterChangeDelete ctermbg=235 ctermfg=235

hi Visual ctermfg=White ctermbg=Black
hi VertSplit guifg=#282C34

" enable 256 color support
if (has("nvim"))
    let $NVIM_TUI_ENABLE_TRUE_COLOR=1
endif

if (has("termguicolors"))
    set termguicolors
endif




" statusline
" ----------

" function to return branch name of working directory
function! GitBranch() abort
    let l:branch = system("git symbolic-ref HEAD 2&> /dev/null | awk 'BEGIN{FS=\"/\"} {print $3}'")
    return len(l:branch) > 0 ? toupper(substitute(l:branch, '\n', '', '')) : '!' 
endfunction

set statusline=                         " clear the statusline
set statusline+=%#FilePath#             " filepath highlight group
set statusline+=\ %t\                   " name of the file
if GitBranch() != '!'
    set statusline+=%#GitBranch#            " git branch highlight group
    set statusline+=\ [%{GitBranch()}]\     " git branch
    hi GitBranch guibg=#363d47 guifg=#4f4f4f
endif
set statusline+=%#Sep1#                 " empty space in the middle
set statusline+=%=                      " right align items henceforth
set statusline+=%#FileType#             " filetype highlight group
set statusline+=\ [%Y]\                 " filetype
set statusline+=%#CursorInfo#           " cursor info highlight group
set statusline+=\ [%l:%c]               " current row and column
set statusline+=\ %p\                   " percentage of file at current cursor position

" statusline colors
" NOTE: use cterm if `set termguicolors`
hi statusline guibg=#3d3e3f guifg=#3d3e3f
hi FilePath guibg=#88C0D0 guifg=#8f8f8f
hi FileType guibg=#4C566A guifg=#4f4f4f
hi CursorInfo guibg=#4C566A guifg=#4f4f4f
hi Sep1 guibg=#2E3440 guifg=#282C34

set fcs=eob:\ 


" functions
" ---------

" enable focused writing mode
function! FocusedMode()
    exec 'normal :Goyo'
    set showtabline=0
    exec 'normal! :ALEToggle'
endfunction

" blink cursorline for searches
nnoremap <silent> n n:cal StrobeCursorLine()<cr>
nnoremap <silent> N N:call StrobeCursorLine()<cr>

function! StrobeCursorLine()
    for count in range(3)
        set invcursorline
        redraw
        exec 'sleep 10m'
        set invcursorline
        redraw
        exec 'sleep 10m'
    endfor
endfunction
