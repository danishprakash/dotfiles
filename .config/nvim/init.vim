" init.vim - nvim configuration
" =========================================================
" - https://github.com/danishprakash/dotfiles
" - https://danishpraka.sh



" Configurations ------------------------------------------

set background=dark
set belloff+=ctrlg                 " if Vim beeps during completion
set nocursorline                   " highlight current cursor column
set expandtab                      " expand tab to spaces
set hlsearch                       " enable search highlights
set ignorecase                     " ignore case while searching
set magic                          " :h pattern
set mouse=a                        " enable mouse for `a`ll modes
set nomodeline                     " vim reading random lines as modelines
set noshowmode                     " hide current mode label
set nowrap                         " disable line wrapping
set number                         " always show line number
set norelativenumber               " show line numbers relative to the current line
set scrolloff=10                   " cursor remains at ~center of the window
set shiftwidth=4                   " tab width while autoindenting
set tabstop=4                      " tab width for things like :retab
set shortmess+=c                   " disable completion messages in statusline
set shortmess+=a                   " suppress a bunch of info messages
set shortmess+=I                   " don't show intro messages on startup
set shortmess+=W                   " don't show 'written' when writing a file
set showmatch                      " set show matching parenthesis
set undodir=~/.config/nvim/undodir " dir to store undo files
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
set linebreak

set filetype=on
filetype plugin indent on
syntax manual


" Plugins -------------------------------------------------

call plug#begin()

" code formatting
Plug 'neoclide/coc.nvim', {'branch': 'release'}
autocmd CursorHold * silent call CocActionAsync("highlight")
nmap <silent> <leader>ep <Plug>(coc-diagnostic-previous)
nmap <silent> <leader>en <Plug>(coc-diagnostic-next)


" Colors

" async linting
Plug 'w0rp/ale'
let g:ale_linters = {'python': ['flake8'], 'javascript': ['eslint']}
let g:ale_python_flake8_options = '--ignore=E501'
let g:ale_linters = {'cpp': ['g++']}
let g:ale_cpp_cc_executable = "g++"

" sh(ell) script formatter
Plug 'z0mbix/vim-shfmt', { 'for': 'sh' }
let g:shfmt_extra_args = '-i 4 -ci'   " formatting options as per Google's Style Guide
let g:shfmt_fmt_on_save = 1           " format shell script on save using shfmt

" fuzzy finder
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
let g:fzf_preview_window = ''         " disable preview window while picking files
let g:fzf_layout = { 'down': '~25%' } " this is analogous to the height flag
let $FZF_DEFAULT_OPTS=" --color='bw'"  " disable colors for fzf
let $FZF_DEFAULT_COMMAND = 'ag --hidden --ignore .git -l -g ""'

" current line blameline
Plug 'danishprakash/nvim-blameline'
let g:blameline_delay = 1000 " delay for displaying blameline

Plug 'fatih/vim-go'
let g:go_def_mapping_enabled = 0      " use lsp for go-to-def, disable vim-go
let g:go_fmt_command = "goimports"    " set goimports as the fmt command for vim-go
let g:go_gopls_enabled = 0
" let g:go_gopls_options = ['-remote=auto']
" let g:go_def_mode='gopls'
" let g:go_info_mode='gopls'
" let g:go_referrers_mode = 'gopls'

Plug 'vim-ruby/vim-ruby'
Plug 'tpope/vim-rails'

" UltiSnips
" Plug 'SirVer/ultisnips'
" let g:UltiSnipsJumpBackwardTrigger='<c-t>'
" let g:UltiSnipsJumpForwardTrigger='<c-r>'
" let g:UltiSnipsEditSplit='vertical'         " If you want :UltiSnipsEdit to vertically split your window.

" vim-jedi
" Plug 'davidhalter/jedi-vim'
" let g:jedi#auto_vim_configuration = 0
" let g:jedi#popup_select_first = 0
" let g:jedi#show_call_signatures = '1'
" let g:jedi#use_splits_not_buffers = 'left'

Plug 'danishprakash/vim-githubinator'
let g:githubinator_no_default_mapping=0     " use default mappings for vim-githubinator

" file explorer
Plug 'scrooloose/nerdtree'
let g:NERDTreeMinimalUI=1                   " hide bloat in NERDTree

Plug 'Yggdroot/indentLine'
let g:vim_json_syntax_conceal = 0
let g:indentLine_concealcursor='nc'

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

" resize buffers
Plug 'simeji/winresizer'
let g:winresizer_vert_resize=2              " vertical resize step
let g:winresizer_horiz_resize=2             " vertical resize step

Plug 'plasticboy/vim-markdown'


Plug 'airblade/vim-gitgutter'
Plug 'godlygeek/tabular'
Plug 'ludovicchabant/vim-gutentags'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-fugitive'


" plugin development
Plug '/home/danish/work/interviewstreet/go/src/github.com/danishprakash/vim-gosortstructs'
Plug '/Users/danish/programming/vim-docker'
Plug '/home/danish/work/personal/vim-yami'
Plug '/Users/danish/programming/vim-yuki'
" Plug '/Users/danish/programming/nvim-blameline'
" Plug '/Users/danishprakash/programming/vim-githubinator'
" Plug '/Users/danishprakash/programming/vim-md'
" Plug '/Users/danishprakash/programming/vimport'
" Plug 'danishprakash/vim-yami'       " default monochrome


call plug#end()



" Mappings ------------------------------------------------

" search for visually selected text with *
vnoremap // y/\V<C-R>=escape(@",'/\')<CR><CR>

" define leader key
let mapleader=' '

" clear search highlight on <c-[> (esc)
nnoremap <silent><c-[> :nohlsearch<CR>

" correct previous spelling mistakes
" https://castel.dev/post/lecture-notes-1/
inoremap <C-l> <c-g>u<Esc>[s1z=`]a<c-g>u

" skip to next git change
nnoremap <leader>j :GitGutterPrevHunk<CR>
nnoremap <leader>k :GitGutterNextHunk<CR>

" focus current file in NERDTree
nnoremap <leader>nf :NERDTreeFind<CR>

" remap c-u and c-d to use lesser jumps
nnoremap <C-d> 8j
nnoremap <C-u> 8k

" keybinding for tags fuzzy finder
nnoremap <leader>t :Tags<CR>

" add daily journal title
nnoremap <leader>jj :call SetJournalHeader()<CR>

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

" start nerdtree
nnoremap <leader>nd :NERDTreeToggle<CR>

" hit enter to insert highlighted item in popup list
inoremap <expr> <CR> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"

" enable Goyo for markdown writing and toggle ALE
nnoremap <silent> <leader>go :Goyo<cr>

" execute current buffer with python3
autocmd FileType python nnoremap <buffer> <F9> :exec '!python3' shellescape(@%, 1)<cr>

" ALE toggle
nnoremap <leader>al :ALEToggle<cr>

" moving across splits
nnoremap <C-h> <C-w>h
nnoremap <C-l> <C-w>l
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k

" open a vertical split window and fire up FZF
nnoremap <silent><leader>v :vnew<cr>:Files<CR>

" convert current word to uppercase and enter insert mode
nnoremap <S-u> viwU<esc>el

" close current buffer
nnoremap <silent><leader>q :bd<cr>

" save current file
nnoremap <leader>w <esc>:w<cr>

" surround current word with double-quotes
" nnoremap <leader>" viw<esc>a"<esc>hbi"<esc>lel

" open vimrc in vertial split and source it
nnoremap <silent> <leader>evi :vsplit $MYVIMRC<cr>
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
" nnoremap <silent> <C-j> <nop>
" nnoremap <silent> <C-k> <nop>

" source plugin file (dev)
nnoremap <leader>sp :so /Users/danishprakash/.local/share/nvim/site/autoload/zen.vim<cr>

" flash the current line when changing window position using `zz`
" nnoremap <silent>zz zz :call StrobeCursorLine()<CR>

" :w!! to save with sudo
ca w!! w !sudo tee >/dev/null "%"



" Functions -----------------------------------------------

function! WritingMode()
    set background=light
endfunction

nnoremap <silent> <leader>Y :call YankBuffer()<CR>
function! YankBuffer()
    let l:curview = winsaveview()
    norm! gg"+yG
    call winrestview(l:curview)
endfunction

" from Practical Vim (pg 217)
xnoremap * :<C-u>call <SID>VSetSearch('/')<CR>/<C-R>=@/<CR><CR>
xnoremap * :<C-u>call <SID>VSetSearch('?')<CR>/<C-R>=@/<CR><CR>

function! s:VSetSearch(cmd_type)
    let temp = @s
    norm! gv"sy
    let @/ = '\V' . substitute(escape(@s, a:cmd_type.'|'), '\n', '\\n', 'g')
    let @s = temp
endfunction

func! TrimWhitespaces()
    let @/ = '\s\+$'
    execute "%s///ge"
endfunc
command! -bang TrimWS call TrimWhitespaces()

" WIP
func! UnescapeNewlines()
    let l:beg = col("'<")
    let l:end =  col("'>")
    echo beg
    echo end
endfunc

" set header title for journal
" and enter writing mode
function! SetJournalHeader()
    execute 'normal gg'
    let filename = '#' . ' ' . expand('%:r')
    call setline(1, filename)
    execute 'normal o'
    execute 'Goyo'
endfunction

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

function! s:todo() abort
  let entries = []
  for cmd in ['git grep -niI -e TODO -e FIXME -e XXX 2> /dev/null',
            \ 'grep -rniI -e TODO -e FIXME -e XXX * 2> /dev/null']
    let lines = split(system(cmd), '\n')
    if v:shell_error != 0 | continue | endif
    for line in lines
      let [fname, lno, text] = matchlist(line, '^\([^:]*\):\([^:]*\):\(.*\)')[1:3]
      call add(entries, { 'filename': fname, 'lnum': lno, 'text': text })
    endfor
    break
  endfor

  if !empty(entries)
    call setqflist(entries)
    copen
  endif
endfunction
command! Todo call s:todo()

function! s:autosave(enable)
  augroup autosave
    autocmd!
    if a:enable
      autocmd TextChanged,InsertLeave <buffer>
            \  if empty(&buftype) && !empty(bufname(''))
            \|   silent! update
            \| endif
    endif
  augroup END
endfunction

command! -bang AutoSave call s:autosave(<bang>1)



" Autocommands --------------------------------------------

" augroup CursorLine
"     au!
"     au VimEnter,WinEnter,BufWinEnter * setlocal cursorline
"     au WinLeave * setlocal nocursorline
" augroup END

" set indent rules for yaml files
autocmd FileType yaml setlocal ts=2 sts=2 sw=2 expandtab

" disable statusline when fzf is active
autocmd! FileType fzf set laststatus=0 noshowmode noruler
        \| autocmd BufLeave <buffer> set laststatus=2 showmode ruler

" autocommands for go development
" augroup GoDev
"     autocmd!

"     " run `GoImports` on every buffer write for go files
"     autocmd BufWritePost *.go :GoImports
" augroup END

augroup NERDTree
    autocmd!
    autocmd FileType nerdtree set syntax=ON
augroup END

" workflow for daily journal
augroup journal
    autocmd!

    " populate journal template
    autocmd VimEnter */journal/**   0r ~/.config/nvim/templates/journal.skeleton

    " set header for the particular journal
    autocmd VimEnter */journal/**   :call SetJournalHeader()

    " other configurations
    autocmd VimEnter */journal/**   set ft=markdown
    autocmd VimEnter */journal/**   syntax off

    " https://stackoverflow.com/questions/12094708/include-a-directory-recursively-for-vim-autocompletion
    autocmd VimEnter */journal/**   set complete=k/Users/danish/programming/mine/journal/**/*
augroup END


" source vimrc when saved
" augroup VimReload
"     autocmd!
"     autocmd BufWritePost $MYVIMRC source $MYVIMRC
" augroup END

" setting wrap while editing markdown files
autocmd FileType markdown set wrap

" start nerdtree on start-up
" autocmd VimEnter * NERDTree

autocmd FileType python setlocal completeopt-=preview

" reload file if changed outside of vim (think branch changes)
" Triger `autoread` when files changes on disk
" https://unix.stackexchange.com/questions/149209/refresh-changed-content-of-file-opened-in-vim/383044#383044
" https://vi.stackexchange.com/questions/13692/prevent-focusgained-autocmd-running-in-command-line-editing-mode
autocmd FocusGained,BufEnter,CursorHold,CursorHoldI * if mode() != 'c' | checktime | endif
" Notification after file change
" https://vi.stackexchange.com/questions/13091/autocmd-event-for-autoread
autocmd FileChangedShellPost *
  \ echohl WarningMsg | echo "File changed on disk. Buffer reloaded." | echohl None

" highlight superfluous whitespace
autocmd BufWinEnter * match ExtraWhitespace /\s\+$/
autocmd InsertLeave * match ExtraWhitespace /\s\+$/

" don't highlight it while in insert mode
autocmd InsertEnter * match ExtraWhitespace /\s\+\%#\@<!$/

" clear superfluous whitespace buffer write
" autocmd BufWritePre * %s/\s\+$//e


" Colors --------------------------------------------------

colorscheme yami
syntax on
set listchars=tab:│\ ,nbsp:␣,trail:∙,extends:>,precedes:<
set fillchars=vert:\│

highlight ExtraWhitespace guibg=#db6969
match ExtraWhitespace /\s\+\%#\@<!$/

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

" highlight matching parens with a darker shade (required when using no syntax)
hi MatchParen guifg=white guibg=gray



" Statusline ----------------------------------------------

set laststatus=2

" Mode returns the full mode name
function! Mode()
    let l:mode = mode()
    if l:mode == "n"
        return "NORMAL"
    elseif l:mode == "v" || l:mode == "V" || l:mode == "\<C-V>"
        return "VISUAL"
    elseif l:mode == "i"
        return "INSERT"
    elseif l:mode == "c"
        return "COMMAND"
    elseif l:mode == "t"
        return "TERMINAL"
    endif
endfunction

" GitBranch wraps over FugitiveHead and returns the
" branch for the current repo and a - if not in one
function! GitBranch()
    " using the exported fugitive function because this
    " result in cursor flickering after every statusline redraw
    " return system("git rev-parse --abbrev-ref HEAD 2> /dev/null | awk 'BEGIN{FS=\"/\"} {print $NF}' | tr -d '\n'")

    " don't return empty string in case we're not in a git repo
    let l:branch = FugitiveHead()
    return l:branch != "" ? l:branch : "-"
endfunction

" BaseFileName returns the basename for the file
function! BaseFileName()
    return expand("%:t")
endfunction

" FileType returns the filetype set for the current buffer
function! FileType()
    let l:filetype = getbufvar(bufnr(), "&filetype")

    " don't return empty string in case ft is not set
    return l:filetype == "" ? "no ft" : l:filetype
endfunction

set statusline=                   " start off empty
set statusline+=\                 " left pad
" set statusline+=%{Mode()}         " mode
" set statusline+=\ \\\             " item separator
set statusline+=%{BaseFileName()} " filename
" set statusline+=\ \\\             " item separator
" set statusline+=%{GitBranch()}    " git branch
set statusline+=\                 " pad
set statusline+=%M                " modified indicator

set statusline+=%=                " move to the right
set statusline+=%l:%c             " line:column
set statusline+=\ /\              " separator
set statusline+=%{FileType()}     " filetype sans []
set statusline+=\                 " right pad

" monochrome statusline
highlight StatusLine guifg=#050505 guibg=#ffffff
highlight StatusLineNC guifg=#050505 guibg=#ffffff
" highlight StatusLineNC guifg=#8f8f8f


" Extras --------------------------------------------------

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

" python execs for nvim
let g:completor_python_binary = '/usr/local/bin/python3'
let g:python2_host_prog = '/usr/local/bin/python'
let g:python3_host_prog = '/usr/bin/python3'
