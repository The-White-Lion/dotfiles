set statusline=%<%f\
set statusline+=%w%h%m%r
set statusline+=\ [%{&ff}/%Y]
set statusline+=\ [%{getcwd()}]
set statusline+=%=%-14.(%l,%c%V%)\ %p%%

hi CursorLine ctermfg=NONE ctermbg=239 guibg=NONE guibg=#4e4e4e

set t_Co=256
set termguicolors
colorscheme deus
