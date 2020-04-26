" Plugins -------------------------------------------------

call plug#begin()

" code formatting
Plug 'ambv/black'
Plug 'neoclide/coc.nvim', {'tag': '*', 'do': './install.sh'}


" Colors

Plug 'danishprakash/vim-yami'       " defaul monochrome

Plug 'ayu-theme/ayu-vim'            " light scheme for writing
let ayucolor="light"

Plug 'sickill/vim-monokai'          " for other users

" async linting
Plug 'w0rp/ale'
let g:ale_linters = {'python': ['flake8'], 'javascript': ['eslint']}
let g:ale_python_flake8_options = '--ignore=E501'

" sh(ell) script formatter
Plug 'z0mbix/vim-shfmt', { 'for': 'sh' }
let g:shfmt_extra_args = '-i 4 -ci'   " formatting options as per Google's Style Guide
let g:shfmt_fmt_on_save = 1           " format shell script on save using shfmt

" fuzzy finder
Plug 'junegunn/fzf.vim'
Plug '/usr/local/opt/fzf'
let g:fzf_preview_window = ''         " disable preview window while picking files
let g:fzf_layout = { 'down': '~25%' } " this is analogous to the height flag
let $FZF_DEFAULT_OPTS=" --color='bw'"  " disable colors for fzf

" current line blameline
Plug 'danishprakash/nvim-blameline'
let g:blameline_delay = 1000 " delay for displaying blameline

Plug 'fatih/vim-go'
let g:go_def_mapping_enabled = 0      " use lsp for go-to-def, disable vim-go
let g:go_fmt_command = "goimports"    " set goimports as the fmt command for vim-go

" UltiSnips
Plug 'SirVer/ultisnips'
let g:UltiSnipsJumpBackwardTrigger='<c-t>'
let g:UltiSnipsJumpForwardTrigger='<c-r>'
let g:UltiSnipsEditSplit='vertical'         " If you want :UltiSnipsEdit to vertically split your window.

" vim-jedi
Plug 'davidhalter/jedi-vim'
let g:jedi#auto_vim_configuration = 0
let g:jedi#popup_select_first = 0
let g:jedi#show_call_signatures = '1'
let g:jedi#use_splits_not_buffers = 'left'

Plug 'danishprakash/vim-githubinator'
let g:githubinator_no_default_mapping=0     " use default mappings for vim-githubinator

" file explorer
Plug 'scrooloose/nerdtree'
let g:NERDTreeMinimalUI=1                   " hide bloat in NERDTree

" writing mode
Plug 'junegunn/goyo.vim'
" configure goyo.vim for writing
function! s:goyo_enter()
    set nocursorline
endfunction

function! s:goyo_leave()
    set cursorline
endfunction

autocmd! User GoyoEnter nested call <SID>goyo_enter()
autocmd! User GoyoLeave nested call <SID>goyo_leave()


Plug 'RRethy/vim-illuminate'
Plug 'airblade/vim-gitgutter'
Plug 'danishprakash/vimport'
Plug 'godlygeek/tabular'
Plug 'honza/vim-snippets'
Plug 'ludovicchabant/vim-gutentags'
Plug 'simeji/winresizer'
Plug 'townk/vim-autoclose'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-fugitive'
Plug 'machakann/vim-sandwich'


" plugin development
Plug '/Users/danish/programming/vim-docker'
Plug '/Users/danish/programming/vim-yami'
" Plug '/Users/danish/programming/nvim-blameline'
" Plug '/Users/danishprakash/programming/vim-githubinator'
" Plug '/Users/danishprakash/programming/vim-md'
" Plug '/Users/danishprakash/programming/vimport'


call plug#end()
