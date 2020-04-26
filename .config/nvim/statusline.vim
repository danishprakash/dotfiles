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
set statusline+=%{Mode()}         " mode
set statusline+=\ \\\             " item separator
set statusline+=%{GitBranch()}    " git branch
set statusline+=\ \\\             " item separator
set statusline+=%{BaseFileName()} " filename
set statusline+=\                 " pad
set statusline+=%M                " modified indicator

set statusline+=%=                " move to the right
set statusline+=%l:%c             " line:column
set statusline+=\ /\              " separator
set statusline+=%{FileType()}     " filetype sans []
set statusline+=\                 " right pad

" monochrome statusline
highlight StatusLine guifg=#000000 guibg=#d0d0d0
