" ---------------------------------------------------------
" VIM-ZEN
" ---------------------------------------------------------
call zen#init()

Plugin 'w0rp/ale'
Plugin 'junegunn/fzf'
Plugin 'morhetz/gruvbox'
Plugin 'junegunn/goyo.vim'
Plugin 'ervandew/supertab'
Plugin 'simeji/winresizer'
Plugin 'google/vim-maktaba'
Plugin 'google/vim-codefmt'
Plugin 'tpope/vim-surround'
Plugin 'scrooloose/nerdtree'
Plugin 'townk/vim-autoclose'
Plugin 'tpope/vim-commentary'
Plugin 'airblade/vim-gitgutter'
Plugin '/Users/danishprakash/programming/vimport'


" Plugin 'neomake/neomake'
" Plugin 'zchee/deoplete-jedi'
" Plugin 'Shougo/deoplete.nvim'
" Plugin 'prakashdanish/vimport'
" Plugin 'sonph/onehalf', {'rtp': 'vim/'}



" ---------------------------------------------------------
" GLOBALS
" ---------------------------------------------------------
let g:leader="\\"
let g:NERDTreeMinimalUI=1
let g:deoplete#enable_at_startup = 1
let g:python2_host_prog = '/usr/local/bin/python'
let g:completor_python_binary = '/usr/local/bin/python3'
let g:python3_host_prog = '/usr/local/Cellar/python3/3.6.3/bin/python3'



" ---------------------------------------------------------
" CONFIGURATIONS
" ---------------------------------------------------------

set wrap
set background=dark
set smartcase
set ignorecase			    " ignore case while searching
set number 			        " always show line number
set relativenumber 		    " show line numbers relative to the current line
set cursorline			    " highlight current cursor column
set showmatch 			    " set show matching parenthesis
set hlsearch 			    " enable search highlights
set scrolloff=10			" cursor remains at ~center of the window
set shortmess+=c   		    " Shut off completion messages
set belloff+=ctrlg 		    " If Vim beeps during completion
set noshowmode              " hide current mode label
set mouse=a                 " enable mouse for `a`ll modes
set tabstop=4
set shiftwidth=4
set expandtab
set completeopt+=menuone
set nohlsearch
set magic

" set ruler
" set ai "auto indent"
" set si: smart indent"
" set mouse=a			    " allows mouse interaction within vim
" set completeopt-=preview	" deoplete: turn off preview window



" ---------------------------------------------------------
" AUTOCOMMANDS
" ---------------------------------------------------------

" autocmd VimEnter * NERDTree



" ---------------------------------------------------------
" REMAPPINGS
" ---------------------------------------------------------

" run current python file    
nnoremap <leader>l3 :!python3 expand('%:p')<cr>

" Codefmt 
nnoremap <leader>fm :FormatCode<cr>
vnoremap <leader>fm :FormatLines<cr>


" ALE toggle
nnoremap <leader>al :ALEToggle<cr>

" Moving across splits
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l

" open a vertical split window and fire up FZF
nnoremap <leader>v :vnew<cr>:FZF<cr>

" convert current word to uppercase and enter insert mode
nnoremap <S-u> viwU<esc>el

" comment using commentary
nnoremap <leader>q :q<cr>

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
nnoremap <silent> <S-j> :+5 <CR>
nnoremap <silent> <S-k> :-5 <CR>


nnoremap <leader>sp :so /Users/danishprakash/.local/share/nvim/site/autoload/zen.vim<cr>
nnoremap <C-t> :FZF <cr>



" ---------------------------------------------------------
" STATUSLINE
" ---------------------------------------------------------

" function to return branch name of working directory
function! GitBranch() abort
    let l:branch = system("git branch 2> /dev/null | awk '{print $2}'")
    return len(l:branch) > 0 ? substitute(l:branch, '\n', '', '') : '' 
endfunction

set statusline=                               " clear the statusline
set statusline+=\ %F                          " path of the file
set statusline+=\ \ <%{GitBranch()}>          " git branch
set statusline+=%=                            " right align items henceforth
set statusline+=\ %y                          " filetype
set statusline+=\ [%l:%c]                     " current row and column 
set statusline+=\ %p\ \                       " percentage of file at current cursor position

hi Statusline ctermfg=237 ctermbg=245
hi StatusLineNC ctermfg=237 ctermbg=238
hi VertSplit ctermfg=235 ctermbg=237



" ---------------------------------------------------------
" COLORS
" ---------------------------------------------------------

syntax on
colorscheme gruvbox
filetype plugin indent on
set fillchars=vert:\│

hi LineNr ctermfg=232 ctermbg=235
hi Default ctermfg=1
hi Search ctermbg=58 ctermfg=15

hi clear SignColumn
hi SignColumn ctermbg=235
hi EndOfBuffer ctermfg=235 ctermbg=235
hi GitGutterAdd ctermbg=235 ctermfg=235
hi GitGutterChange ctermbg=235 ctermfg=235
hi GitGutterDelete ctermbg=235 ctermfg=235
hi GitGutterChangeDelete ctermbg=235 ctermfg=235
hi Visual ctermfg=White ctermbg=Black
