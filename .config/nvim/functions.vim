" Functions -----------------------------------------------

nnoremap <silent> <leader>ue :redir @a<CR>:g//<CR>:redir END<CR>:new<CR>:put! a<CR>

" WIP
func! UnescapeNewlines()
    let l:beg = col("'<")
    let l:end =  col("'>")
    echo beg
    echo end
endfunc


" custom completion source test
" func! ListNames()
"     call complete(col('.'), ['Danish', 'Aman', 'Hallelujah'])
"     return ''
" endfunc

" inoremap <leader>y <C-R>=ListNames()<CR>

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
