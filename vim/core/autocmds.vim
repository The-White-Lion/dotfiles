augroup core_autocmds
  autocmd!

  autocmd BufReadPost *
    \ if line("'\"") > 1 && line("'\"") <= line("$") |
    \   exe "normal! g'\"" |
    \ endif

  autocmd BufEnter *
    \ if bufname("") !~ "^\\[A-Za-z0-9\\]*://" |
    \   lcd %:p:h |
    \ endif
augroup END


