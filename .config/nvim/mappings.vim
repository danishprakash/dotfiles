" Mappings ------------------------------------------------

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

" codefmt 
nnoremap <leader>fm :FormatCode<cr>
vnoremap <leader>fm :FormatLines<cr>

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
" nnoremap <silent> <C-j> <nop>
" nnoremap <silent> <C-k> <nop>

" source plugin file (dev)
nnoremap <leader>sp :so /Users/danishprakash/.local/share/nvim/site/autoload/zen.vim<cr>

" flash the current line when changing window position using `zz`
" nnoremap <silent>zz zz :call StrobeCursorLine()<CR>

" :w!! to save with sudo
ca w!! w !sudo tee >/dev/null "%"

