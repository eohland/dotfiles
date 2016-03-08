" Global variables for Epitech Headers
let g:epi_name ='emmanuel ohland'
let g:epi_login='ohland_e'
let g:epi_dformat='%a %b %d %T %Y'

" Custom Epitech Headers at source files
function! s:insert_headers(f_com, com, l_com)
  set paste
  let pre="\n" . a:com . ' '
  execute 'normal! i'. a:f_com .
        \ pre . expand("%") . ' for in ' expand("%:p:h") .
        \ pre .
        \ pre . 'Made by ' . g:epi_name .
        \ pre . 'Login   <' . g:epi_login . '@epitech.net>' .
        \ pre .
        \ pre . 'Started on  ' . strftime(g:epi_dformat) . ' ' . g:epi_name .
        \ pre . 'Last update ' . strftime(g:epi_dformat) . ' ' . g:epi_name .
        \ "\n" . a:l_com ."\n\n"
  "setlocal formatoptions=fo
  set nopaste
endfunction
autocmd BufNewFile *.{c,h} call <SID>insert_headers('/*','**','*/')
autocmd BufNewFile *.php call <SID>insert_headers("<?php\n//",'//','//')
autocmd BufNewFile *.php execute 'normal! o?>' | execute 'normal!k'
autocmd BufNewFile *.{cpp,hpp} call <SID>insert_headers('//','//','//')
autocmd BufNewFile Makefile,*.py call <SID>insert_headers('##','##','##')
autocmd BufNewFile *.sh call <SID>insert_headers("#!/bin/sh\n##",'##','##')

function! s:update_headers()
  if &modified
    let save_cursor = getpos('.')
    let n = '8,9' " min([8, line("$")])
    keepjumps exe n . 's#^\(.\{1,5}Last update \).*#\1' .
        \ strftime(g:epi_dformat) . ' ' . g:epi_name . '#e'
   call histdel('search', -1)
   call setpos('.', save_cursor)
  endif
endfunction
autocmd BufWritePre * call <SID>update_headers()

" Protect C/C++ header files (with #ifndef)
function! s:insert_gates()
  let gatename = substitute(toupper(expand("%:t")), "\\.", "_", "g")
  execute "normal! i#ifndef\t\t" . gatename . "_"
  execute "normal! o# define\t" . gatename . "_"
  execute "normal! Go#endif\t\t/* !" . gatename . "_ */"
  normal! ko
endfunction
autocmd BufNewFile *.{h,hpp} call <SID>insert_gates()
