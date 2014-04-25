" .vimrc
" See: http://vimdoc.sourceforge.net/htmldoc/options.html for details

" For multi-byte character support (CJK support, for example):
"set fileencodings=ucs-bom,utf-8,cp936,big5,euc-jp,euc-kr,gb18030,latin1

set tabstop=4       " Number of spaces that a <Tab> in the file counts for.

set shiftwidth=2    " Number of spaces to use for each step of (auto)indent.

set expandtab       " Use the appropriate number of spaces to insert a <Tab>.
                    " Spaces are used in indents with the '>' and '<' commands
                    " and when 'autoindent' is on. To insert a real tab when
                    " 'expandtab' is on, use CTRL-V <Tab>.

set smarttab        " When on, a <Tab> in front of a line inserts blanks
                    " according to 'shiftwidth'. 'tabstop' is used in other
                    " places. A <BS> will delete a 'shiftwidth' worth of space
                    " at the start of the line.

set showcmd         " Show (partial) command in status line.

"set number          " Show line numbers.

set showmatch       " When a bracket is inserted, briefly jump to the matching
                    " one. The jump is only done if the match can be seen on the
                    " screen. The time to show the match can be set with
                    " 'matchtime'.

set hlsearch        " When there is a previous search pattern, highlight all
                    " its matches.

set incsearch       " While typing a search command, show immediately where the
                    " so far typed pattern matches.

set ignorecase      " Ignore case in search patterns.

set smartcase       " Override the 'ignorecase' option if the search pattern
                    " contains upper case characters.

set backspace=2     " Influences the working of <BS>, <Del>, CTRL-W
                    " and CTRL-U in Insert mode. This is a list of items,
                    " separated by commas. Each item allows a way to backspace
                    " over something.

set autoindent      " Copy indent from current line when starting a new line
                    " (typing <CR> in Insert mode or when using the "o" or "O"
                    " command).

set textwidth=79    " Maximum width of text that is being inserted. A longer
                    " line will be broken after white space to get this width.

set formatoptions=c,q,r,t " This is a sequence of letters which describes how
                    " automatic formatting is to be done.
                    "
                    " letter    meaning when present in 'formatoptions'
                    " ------    ---------------------------------------
                    " c         Auto-wrap comments using textwidth, inserting
                    "           the current comment leader automatically.
                    " q         Allow formatting of comments with "gq".
                    " r         Automatically insert the current comment leader
                    "           after hitting <Enter> in Insert mode.
                    " t         Auto-wrap text using textwidth (does not apply
                    "           to comments)

set ruler           " Show the line and column number of the cursor position,
                    " separated by a comma.

"set mouse=a         " Enable the use of the mouse.

" Colors config
set background=dark
colorscheme molokai
se t_Co=256
let g:rehash256 = 1

filetype plugin indent on
syntax on

" Show whitespaces
set list
set listchars=tab:»·,trail:·

set colorcolumn=80

let Tlist_Compact_Format = 1
let Tlist_GainFocus_On_ToggleOpen = 1
let Tlist_Close_On_Select = 1
nnoremap <C-l> :TlistToggle<CR>

" Pathogen runtime path manupulation
execute pathogen#infect()

" Airline configuration
set laststatus=2
set ttimeoutlen=50
set noshowmode
let g:airline_theme = 'badwolf'
let g:airline_powerline_fonts = 1
let g:bufferline_echo = 0
let g:airline#extensions#tabline#enabled = 1

" auto-source .vimrc
autocmd! bufwritepost .vimrc source %

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
