
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
Plug 'neoclide/coc.nvim', {'tag': '*', 'do': './install.sh'}

" colorschemes
Plug 'ewilazarus/preto'
Plug '/Users/danish/programming/vim-yami'

" when someone else is using my setup
" they will need colors
Plug 'sickill/vim-monokai'

" Go development
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
" Plug 'ervandew/supertab'
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
" Plug 'ap/vim-buftabline'
Plug 'itchyny/lightline.vim'
Plug 'Yggdroot/indentLine'
Plug 'RRethy/vim-illuminate'
Plug '/Users/danish/programming/vim-docker'



" tmux
Plug 'christoomey/vim-tmux-navigator'


" self
" Plug '/Users/danishprakash/programming/vim-md'
" Plug '/Users/danishprakash/programming/vimport'
" Plug '/Users/danishprakash/programming/vim-blameline'
" Plug '/Users/danishprakash/programming/vim-githubinator'

call plug#end()





" globals
" -------

" define leader key
let mapleader=' '

" hide bloat in NERDTree
let g:NERDTreeMinimalUI=1

" python execs for nvim
let g:completor_python_binary = '/usr/local/bin/python3'
let g:python2_host_prog = '/usr/local/bin/python'
let g:python3_host_prog = '/usr/local/bin/python3'

" use default mappings for vim-githubinator
let g:githubinator_no_default_mapping=0

" vim-jedi
let g:jedi#auto_vim_configuration = 0
let g:jedi#use_splits_not_buffers = 'left'
let g:jedi#popup_select_first = 0
let g:jedi#show_call_signatures = '1'

" scroll through suggestion in up->down manner
" let g:SuperTabDefaultCompletionType = '<C-n>'
" let g:SuperTabContextDefaultCompletionType = '<c-x><c-o>'
" set omnifunc=jedi#completions

" linters for ale
let g:ale_linters = {'python': ['flake8'], 'javascript': ['eslint']}
let g:ale_python_flake8_options = '--ignore=E501'

" UltiSnipps
let g:UltiSnipsJumpForwardTrigger='<c-r>'
let g:UltiSnipsJumpBackwardTrigger='<c-t>'

" If you want :UltiSnipsEdit to split your window.
let g:UltiSnipsEditSplit='vertical'

let g:vimwiki_list = [{'path': '~/vimwiki/',
                      \ 'syntax': 'markdown', 'ext': '.md'}]

let g:lightline = {
      \ 'colorscheme': 'yami',
      \ 'active': {
      \   'left': [ [ 'mode', 'paste' ],
      \             [ 'gitbranch', 'readonly', 'filename', 'modified' ], ['tabline']],
      \   'right': [ [ 'lineinfo' ],
      \              [ 'percent' ],
      \              [ 'filetype' ] ]
      \ },
      \ 'component_function': {
      \   'gitbranch': 'fugitive#head'
      \ },
      \ 'separator': {
      \ 'right': ''
      \ },
      \ } 

let g:go_def_mapping_enabled = 0


" configurations
" --------------

set linebreak
set background=dark
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
set magic
set t_Co=256
set undofile	         " maintain undo history bw sessions
set undodir=~/.config/nvim/undodir

" folding
set foldmethod=indent
set foldlevel=10
set nomodeline           " vim reading random lines as modelines
set nowrap

" set ruler
" set ai                   " auto indent
" set si                   " smart indent
" set mouse=a              " allows mouse interaction within vim
" set completeopt-=preview " deoplete: turn off preview window
" set clipboard=unnamed    " set system clipboard as vim clipboard
" set smartcase
" set completeopt+=menuone
" set list





" autocmds
" --------

" " remember cursor position while switching buffer
" if v:version >= 700
"   au BufLeave * let b:winview = winsaveview()
"   au BufEnter * if(exists('b:winview')) | call winrestview(b:winview) | endif
" endif

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
"
"
"

nnoremap <silent><c-[> :nohlsearch<CR>

nnoremap <leader>i :GoImport 
" open current file in NERDTree
nnoremap <leader>j :GitGutterPrevHunk<CR>

" disable search results highlighting
" nnoremap <CR> :nohlsearch<CR>

" correct previous spelling mistakes
" https://castel.dev/post/lecture-notes-1/
inoremap <C-l> <c-g>u<Esc>[s1z=`]a<c-g>u

" add quotes
nnoremap <silent> <leader>" ysiw"
nnoremap <silent> <leader>' ysiw'

" skip to next git change
nnoremap <leader>j :GitGutterPrevHunk<CR>
nnoremap <leader>k :GitGutterNextHunk<CR>

" focus current file in NERDTree
nnoremap <leader>n :NERDTreeFind<CR>

" remap c-u and c-d to use lesser jumps
nnoremap <C-d> 8j
nnoremap <C-u> 8k

" keybinding for tags fuzzy finder
nnoremap <leader>t :Tags<CR>

" add daily journal title
nnoremap <leader>jj :r! echo %<CR>

" cycle through buffers
" nnoremap <silent><C-n> :bnext<CR>
" nnoremap <silent><C-p> :bprevious<CR>

" open file finder
" nnoremap <silent><C-p> :Files<CR>

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
nnoremap <silent> <leader><leader> :Files<CR>

" open line finder
nnoremap <silent> <leader>l :Lines<CR>

" open buffer finder
nnoremap <silent> <leader>b :Buffers<CR>

" search using rg
nnoremap <leader>4 :Rg <c-r>=expand("<cword>")<cr><CR>

" \_ uses last changed or yanked text as an object
onoremap <leader>_ :<C-U>normal! `[v`]<CR>

" remap return to ':'
nnoremap <CR> :echo "nope"<CR>

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

" close current buffer
nnoremap <silent><leader>q :bd<cr>

" save current file
nnoremap <leader>w <esc>:w<cr>

" surround current word with double-quotes
" nnoremap <leader>" viw<esc>a"<esc>hbi"<esc>lel

" open vimrc in vertial split and source it
nnoremap <silent> <leader>ev :vsplit $MYVIMRC<cr>
nnoremap <silent> <leader>so :so $MYVIMRC<cr> :CocRestart<CR>

" move around wrapped lines as if separate lines
noremap <silent> j gj
noremap <silent> k gk

" move to beginning/end of line
nnoremap H ^
nnoremap L $

"move 5 lines up and down while holding Shift and j/k
" nnoremap <silent> <C-j> :+5 <CR>
" nnoremap <silent> <C-k> :-5 <CR>
nnoremap <silent> <C-j> <nop>
nnoremap <silent> <C-k> <nop>

" source plugin file (dev)
nnoremap <leader>sp :so /Users/danishprakash/.local/share/nvim/site/autoload/zen.vim<cr>

" flash the current line when changing window position using `zz`
" nnoremap <silent>zz zz :call StrobeCursorLine()<CR>

" :w!! to save with sudo
ca w!! w !sudo tee >/dev/null "%"





" colors
" ------

colorscheme yami
filetype on
filetype plugin indent on
syntax on
set listchars=tab:│\ ,nbsp:␣,trail:∙,extends:>,precedes:<
set fillchars=vert:\│


" settings are specific to preto colorscheme
hi ALEError cterm=none

" enable 256 color support
if (has("nvim"))
    let $NVIM_TUI_ENABLE_TRUE_COLOR=1
endif

if (has("termguicolors"))
    set termguicolors
endif


" clear end of buffer chars
set fillchars=eob:\ 



" functions
" ---------

" figure out highlight group under cursor
function! SynStack()
  if !exists("*synstack")
    return
  endif
  echo map(synstack(line('.'), col('.')), 'synIDattr(v:val, "name")')
endfunc

" Highlight all instances of word under cursor, when idle.
" Useful when studying strange source code.
" Type z/ to toggle highlighting on/off.
nnoremap z/ :if AutoHighlightToggle()<Bar>set hls<Bar>endif<CR>
function! AutoHighlightToggle()
  let @/ = ''
  if exists('#auto_highlight')
    au! auto_highlight
    augroup! auto_highlight
    setl updatetime=4000
    echo 'Highlight current word: off'
    return 0
  else
    augroup auto_highlight
      au!
      au CursorHold * let @/ = '\V\<'.escape(expand('<cword>'), '\').'\>'
    augroup end
    setl updatetime=500
    echo 'Highlight current word: ON'
    return 1
  endif
endfunction

" enable focused writing mode
function! FocusedMode()
    exec 'normal :Goyo'
    set showtabline=0
    set nocursorline
    syntax off
    exec 'normal! :ALEToggle'
endfunction

" blink cursorline for searches
" nnoremap <silent> n n:cal StrobeCursorLine()<cr>
" nnoremap <silent> N N:call StrobeCursorLine()<cr>

" function! StrobeCursorLine()
"     for l:count in range(3)
"         set invcursorline
"         redraw
"         exec 'sleep 10m'
"         set invcursorline
"         redraw
"         exec 'sleep 10m'
"     endfor
" endfunction

" reload file if changed outside of vim (think branch changes)
" Triger `autoread` when files changes on disk
" https://unix.stackexchange.com/questions/149209/refresh-changed-content-of-file-opened-in-vim/383044#383044
" https://vi.stackexchange.com/questions/13692/prevent-focusgained-autocmd-running-in-command-line-editing-mode
autocmd FocusGained,BufEnter,CursorHold,CursorHoldI * if mode() != 'c' | checktime | endif
" Notification after file change
" https://vi.stackexchange.com/questions/13091/autocmd-event-for-autoread
autocmd FileChangedShellPost *
  \ echohl WarningMsg | echo "File changed on disk. Buffer reloaded." | echohl None


" temp coc.nvim configuration
" if hidden is not set, TextEdit might fail.
set hidden

" Some servers have issues with backup files, see #649
set nobackup
set nowritebackup

" Better display for messages
set cmdheight=1

" Smaller updatetime for CursorHold & CursorHoldI
set updatetime=300

" don't give |ins-completion-menu| messages.
set shortmess+=c

" always show signcolumns
set signcolumn=yes

" Use tab for trigger completion with characters ahead and navigate.
" Use command ':verbose imap <tab>' to make sure tab is not mapped by other plugin.
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"

inoremap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"

" Remap keys for gotos
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)
