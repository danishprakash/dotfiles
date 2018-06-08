" ---------------------------------------------------------
" vim-plug section
" ---------------------------------------------------------
call plug#begin('~/.local/share/nvim/plugged')

"Plugins to install

Plug 'airblade/vim-gitgutter'
Plug 'tpope/vim-surround'
Plug 'townk/vim-autoclose'
Plug 'tpope/vim-commentary'
Plug 'morhetz/gruvbox'
Plug 'zchee/deoplete-jedi'
Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
Plug 'junegunn/fzf', {'do': './install --all' }
Plug 'neomake/neomake'
Plug 'scrooloose/nerdtree'
Plug 'ervandew/supertab'

" Plug 'prakashdanish/vimport'
" Plug 'arcticicestudio/nord-vim'
" Plug 'dracula/vim', { 'as': 'dracula' }
" Plug 'jdkanani/vim-material-theme'

" personal plugins for dev
" Plug '~/programming/vimport'

call plug#end()

call zen#add('junegunn/goyo.vim')
call zen#add('arcticicestudio/nord-vim')
call zen#add('prakashdanish/vimport')



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
syntax on
filetype indent on
colorscheme gruvbox
let leader="\\"
set background=dark
set nowrap
set smartcase
set ignorecase			" ignore case while searching
set mouse=a			" allows mouse interaction within vim
set number 			" always show line number
set relativenumber 		" show line numbers relative to the current line
set cursorline			" highlight current cursor column
set showmatch 			" set show matching parenthesis
set hlsearch 			" enable search highlights
set completeopt-=preview	" deoplete: turn off preview window
set so=20			" cursor remains at ~center of the window
set shortmess+=c   		" Shut off completion messages
set belloff+=ctrlg 		" If Vim beeps during completion
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
" set statusline+=%#warningmsg#
" set statusline+=%{SyntasticStatuslineFlag()}
" set statusline+=%*



" ---------------------------------------------------------
" Autocommands
" ---------------------------------------------------------

" autocmd VimEnter * NERDTree



" ---------------------------------------------------------
" Remappings
" ---------------------------------------------------------

" convert current word to uppercase and enter insert mode
nnoremap <S-u> viwU<esc>el

" save current file
nnoremap <leader>p <esc>:w<cr>

" surround current word with double-quotes
nnoremap <leader>" viw<esc>a"<esc>hbi"<esc>lel

" open vimrc in vertial split and source it
nnoremap <leader>ev :vsplit $MYVIMRC<cr>
nnoremap <leader>so :so $MYVIMRC<cr>

nnoremap <S-r> :FZF <cr>

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
" vim settings from this url to hide unnecessary crap
" https://www.reddit.com/r/unixporn/comments/5vke7s/osx_iterm2_tmux_vim/de2ubek/
" ---------------------------------------------------------
hi vertsplit ctermfg=235 ctermbg=235
hi LineNr ctermfg=232
hi StatusLine ctermfg=235 ctermbg=245
hi StatusLineNC ctermfg=235 ctermbg=237
hi Search ctermbg=58 ctermfg=15
hi Default ctermfg=1
hi clear SignColumn
hi SignColumn ctermbg=235
hi GitGutterAdd ctermbg=235 ctermfg=245
hi GitGutterChange ctermbg=235 ctermfg=245
hi GitGutterDelete ctermbg=235 ctermfg=245
hi GitGutterChangeDelete ctermbg=235 ctermfg=245
hi EndOfBuffer ctermfg=235 ctermbg=235

set statusline=%=&P\ %f\ %m
set fillchars=vert:\ ,stl:\ ,stlnc:\ 
set laststatus=2
set noshowmode
