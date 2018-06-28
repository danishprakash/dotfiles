" ---------------------------------------------------------
" vim-zen section
" ---------------------------------------------------------
call zen#init()

Plugin 'junegunn/goyo.vim'
Plugin 'airblade/vim-gitgutter'
Plugin 'tpope/vim-surround'
Plugin 'townk/vim-autoclose'
Plugin 'tpope/vim-commentary'
Plugin 'morhetz/gruvbox'
Plugin 'junegunn/fzf'
Plugin 'scrooloose/nerdtree'
Plugin 'ervandew/supertab'
Plugin 'prakashdanish/vimport'
Plugin 'w0rp/ale'


" Plugin 'neomake/neomake'
" Plugin 'zchee/deoplete-jedi'
" Plugin 'Shougo/deoplete.nvim'



" ---------------------------------------------------------
" Plugin configurations
" ---------------------------------------------------------
let g:deoplete#enable_at_startup = 1
let g:python2_host_prog = '/usr/local/bin/python'
let g:python3_host_prog = '/usr/local/Cellar/python3/3.6.3/bin/python3'
let g:completor_python_binary = '/usr/local/bin/python3'
let NERDTreeMinimalUI=1



" ---------------------------------------------------------
" vim level configurations
" ---------------------------------------------------------
highlight Visual cterm=NONE ctermfg=White ctermbg=DarkGrey
syntax on
filetype plugin indent on
colorscheme gruvbox
let leader="\\"
set nowrap
set background=dark
set smartcase
set ignorecase			    " ignore case while searching
set mouse=a			        " allows mouse interaction within vim
set number 			        " always show line number
set relativenumber 		    " show line numbers relative to the current line
set cursorline			    " highlight current cursor column
set showmatch 			    " set show matching parenthesis
set hlsearch 			    " enable search highlights
set completeopt-=preview	" deoplete: turn off preview window
set scrolloff=10			" cursor remains at ~center of the window
set shortmess+=c   		    " Shut off completion messages
set belloff+=ctrlg 		    " If Vim beeps during completion
set tabstop=4
set shiftwidth=4
set expandtab
set completeopt+=menuone
set mouse=a
set nohlsearch
" set magic
" set ruler
" set ai "auto indent"
" set si: smart indent"
" set wrap
" set mouse=a
" set ts=4 sw=4
" set nuw=4



" ---------------------------------------------------------
" Autocommands
" ---------------------------------------------------------

" autocmd VimEnter * NERDTree



" ---------------------------------------------------------
" Remappings
" ---------------------------------------------------------

" inoremap jk <esc>
" vnoremap jk <esc>
" nnoremap jk <esc>
" 
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

nnoremap <leader>sp :so /Users/danishprakash/.local/share/nvim/site/autoload/zen.vim<cr>

nnoremap <C-t> :FZF <cr>

" move around wrapped lines as if separate lines
noremap <silent> j gj
noremap <silent> k gk

" move to beginning/end of line
nnoremap H ^
nnoremap L $

"move 5 lines up and down while holding Shift and j/k
nnoremap <silent> <S-j> :+5 <CR>
nnoremap <silent> <S-k> :-5 <CR>

" nnoremap <ESC> :noh<ESC><ESC>



" ---------------------------------------------------------
" Statusline
" ---------------------------------------------------------

" function to return branch name of working directory
function! GitBranch() abort
    let l:branch = system("git branch 2> /dev/null | awk '{print $2}'")
    return len(l:branch) > 0 ? substitute(l:branch, '\n', '', '') : '' 
endfunction

set statusline=                                         " clear the statusline
set statusline+=\ \ \ %F                                " path of the file
set statusline+=\ \ <%{GitBranch()}>                    " git branch
set statusline+=%=                                      " right align items henceforth
set statusline+=\ %y                                    " filetype
set statusline+=\ [%l:%c]                               " current row and column 
set statusline+=\ %p\ \                                 " percentage of file at current cursor position

" hi StatusLine ctermfg=235 ctermbg=245
hi StatusLineNC ctermfg=235 ctermbg=237



" ---------------------------------------------------------
" vim settings from this url to hide unnecessary crap
" https://www.reddit.com/r/unixporn/comments/5vke7s/osx_iterm2_tmux_vim/de2ubek/
" ---------------------------------------------------------
hi vertsplit ctermfg=235 ctermbg=235
hi LineNr ctermfg=232
hi Search ctermbg=58 ctermfg=15
hi Default ctermfg=1
hi clear SignColumn
hi SignColumn ctermbg=235
hi GitGutterAdd ctermbg=235 ctermfg=245
hi GitGutterChange ctermbg=235 ctermfg=245
hi GitGutterDelete ctermbg=235 ctermfg=245
hi GitGutterChangeDelete ctermbg=235 ctermfg=245
hi EndOfBuffer ctermfg=235 ctermbg=235

" set statusline=%=&P\ %f\ %m
set fillchars=vert:\ ,stl:\ ,stlnc:\ 
set laststatus=2
set noshowmode
