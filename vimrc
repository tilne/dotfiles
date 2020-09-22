set nocompatible ruler laststatus=2 showcmd showmode
filetype plugin on

" supposedly, give access to system clipboard
set clipboard=unnamed

set foldmethod=syntax

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

Plugin 'gmarik/Vundle.vim'
Plugin 'tpope/vim-fugitive'
Plugin 'airblade/vim-gitgutter'
Plugin 'tmhedberg/SimpylFold'
Plugin 'vim-python/python-syntax'
Plugin 'ctrlpvim/ctrlp.vim'
Plugin 'preservim/nerdtree'

call vundle#end()

let g:python_highlight_all = 1

set ts=4            " Tab width
set sw=4            " Shift width
set softtabstop=4   " If softtabstop equals tabstop and expandtab is not set,
                    " vim will always use tabs. When expandtab is set, vim will
                    " always use the appropriate number of spaces.
set smarttab        " Tab inserted when indenting and/or correct alignment spaces
set expandtab       " Use spaces when tab key is pressed
set autoindent
set nocindent
set nosmartindent
set ruler           " Cursor location
set title           " Screen title updates to open buffer
set mouse=a         " Enables mouse use in all modes
set t_Co=256        " Sets vim to 256 colors
set background=dark
colo apprentice
syntax enable               " Syntax highlighting
filetype plugin indent on   " Detection of such
" incsearch == show matches as search progresses
" smartcase == don't care about capitalization in search
" hlsearch  == higlight search matches
set incsearch smartcase hlsearch
set number          " number lines
set autoread        " if local file is modified, read it into vim immediately
set encoding=utf-8  " unicode
set scrollback=20000  " 20k lines of scrollback buffer in terminal emulator

" necessary to use ctrl-w to delete whole words for some reason
set backspace=indent,eol,start

set splitbelow
set splitright

nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

" Tell vim to remember certain things when we exit
"  '10  :  marks will be remembered for up to 10 previously edited files
"  "100 :  will save up to 100 lines for each register
"  :20  :  up to 20 lines of command-line history will be remembered
"  %    :  saves and restores the buffer list
"  n... :  where to save the viminfo files
set viminfo='10,\"100,:20,%,n~/.viminfo


" When opening a file, restore the cursor to the line it was on when the file
" closed.
function! ResCur()
    if line("'\"") <= line("$")
        normal! g`"
        return 1
    endif
endfunction

augroup resCur
    autocmd!
    autocmd BufWinEnter * call ResCur()
augroup END

" autocmd vimenter * NERDTree
autocmd BufEnter * :syntax sync fromstart

" NERDTree aliases
cnoreabbrev nt NERDTree
cnoreabbrev ntt NERDTreeToggle
cnoreabbrev rso resize 1

" F2 sets all windows to equal width
nnoremap <F2> =

" Various shortcut mappings
nnoremap <Leader>f :Autoformat<CR>
nnoremap <Leader>n :noh<CR>

" Run a shell command and show the output in a new window
command! -complete=shellcmd -nargs=+ Shell call s:RunShellCommand(<q-args>)
function! s:RunShellCommand(cmdline)
  echo a:cmdline
  let expanded_cmdline = a:cmdline
  for part in split(a:cmdline, ' ')
     if part[0] =~ '\v[%#<]'
        let expanded_part = fnameescape(expand(part))
        let expanded_cmdline = substitute(expanded_cmdline, part, expanded_part, '')
     endif
  endfor
  botright new
  setlocal buftype=nofile bufhidden=wipe nobuflisted noswapfile nowrap
  call setline(1, 'You entered:    ' . a:cmdline)
  call setline(2, 'Expanded Form:  ' .expanded_cmdline)
  call setline(3,substitute(getline(2),'.','=','g'))
  execute '$read !'. expanded_cmdline
  setlocal nomodifiable
  1
endfunction

set tags=~/pcluster-tags

" polling period for GitGutter, 100 ms instead of default 4 seconds
set updatetime=100

" Use virtualenv if one is activated
" vim must be compiled with python3 support for the following to work
" If it was compiled with python2 support the command can be changed
" from 'py3' to 'py' and it should work.
py3 << EOF
import os
import site
import sys

import vim

venv = os.environ.get('VIRTUAL_ENV')

if venv:
    old_os_path = os.environ['PATH']
    os.environ['PATH'] = os.path.join(venv, 'bin') + os.pathsep + old_os_path
    site_packages = os.path.join(venv, 'lib', 'python%s' % sys.version[:3], 'site-packages')
    site.addsitedir(site_packages)
    sys.real_prefix = sys.prefix
    sys.prefix = venv
    # Move the added items to the front of the path:
    prev_sys_path = list(sys.path)
    new_sys_path = []
    for item in list(sys.path):
        if item not in prev_sys_path:
            new_sys_path.append(item)
            sys.path.remove(item)
    sys.path[:0] = new_sys_path
EOF
