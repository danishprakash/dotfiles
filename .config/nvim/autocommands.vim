" Autocommands --------------------------------------------

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
