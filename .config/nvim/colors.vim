" Colors --------------------------------------------------

colorscheme yami
filetype on
filetype plugin indent on
syntax manual
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
