set nocompatible ruler laststatus=2 showcmd showmode
filetype plugin on

" supposedly, give access to system clipboard
set clipboard=unnamed

set foldmethod=syntax
set nofoldenable    " disable folding on startup

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

Plugin 'VundleVim/Vundle.vim'
Plugin 'tpope/vim-fugitive'
Plugin 'tpope/vim-dispatch'
Plugin 'tpope/vim-surround'
Plugin 'airblade/vim-gitgutter'
Plugin 'tmhedberg/SimpylFold'
Plugin 'plasticboy/vim-markdown'
Plugin 'ekalinin/Dockerfile.vim'
Plugin 'sheerun/vim-polyglot'
Plugin 'drewtempelmeyer/palenight.vim'

call vundle#end()

let g:python_highlight_all = 1
" These are settings to try if nvim is found to be loading slow due to
" sourcing python providers.
" https://github.com/neovim/neovim/issues/2437
" let g:python_host_skip_check = 1
" let g:python3_host_skip_check = 1

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
colo palenight
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

" prevent automatic addition of newlines
set nofixendofline

" search down into subfolders
" provides tab-completion for all file-related tasks
set path+=**

nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

" search for visually selected text
" from https://vim.fandom.com/wiki/Search_for_visually_selected_text
vnoremap // y/\V<C-R>=escape(@",'/\')<CR><CR>

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

autocmd BufEnter * :syntax sync fromstart

" Set max line width for markdown files
"au BufRead,BufNewFile *.md setlocal textwidth=100

" F2 sets all windows to equal width
nnoremap <F2> =

" remap leader key to space
let mapleader = " "

" Various shortcut mappings
nnoremap <Leader>f :Autoformat<CR>
nnoremap <Leader>n :noh<CR>
nnoremap <Leader>sv :so ~/.vimrc<CR>
nnoremap <Leader>evv :e ~/repos/dotfiles/vimrc<CR>
nnoremap <Leader>ea :e ~/repos/dotfiles/alacritty.yml<CR>
nnoremap <Leader>ez :e ~/repos/dotfiles/zshrc<CR>
nnoremap <Leader>et :e ~/repos/dotfiles/tmux.conf<CR>
nnoremap <Leader>eg :e ~/repos/dotfiles/gitconfig<CR>
nnoremap <Leader>wh <C-w>h
nnoremap <Leader>wl <C-w>l
nnoremap <Leader>wj <C-w>j
nnoremap <Leader>wk <C-w>k
nnoremap <Leader>wc <C-w>c
nnoremap <Leader>ww :w<CR>
nnoremap <Leader>wq :wq<CR>
nnoremap <Leader>qq :q<CR>
nnoremap <Leader>spv :vsp <bar> :set number<CR>
nnoremap <Leader>sph :sp <bar> :set number<CR>
nnoremap <Leader>gs :Gstatus<CR>
nnoremap <Leader>gd :Git diff<CR>
nnoremap <Leader>gcc :Git commit -vs<CR>
nnoremap <Leader>gca :Git commit -v --amend<CR>
nnoremap <Leader>gpp :Git push<CR>
nnoremap <Leader>gpf :Git push --force<CR>
nnoremap <Leader>glg :Git log<CR>
nnoremap <Leader>pfn /^def <CR>
nnoremap <Leader>pfp ?^def <CR>
nnoremap <Leader>syn :set number<CR>
nnoremap <Leader>snn :set nonumber<CR>

" shortcuts for quick commenting/un-commenting
" https://stackoverflow.com/questions/1676632/whats-a-quick-way-to-comment-uncomment-lines-in-vim
autocmd FileType c,cpp,java,scala     let b:comment_leader = '//'
autocmd FileType zsh,sh,ruby,python   let b:comment_leader = '#'
autocmd FileType conf,fstab,make,tmux let b:comment_leader = '#'
autocmd FileType tex                  let b:comment_leader = '%'
autocmd FileType mail                 let b:comment_leader = '>'
autocmd FileType vim                  let b:comment_leader = '"'
autocmd FileType dosini               let b:comment_leader = ';'
function! CommentToggle()
    execute ':silent! s/\([^ ]\)/' . escape(b:comment_leader,'\/') . ' \1/'
    execute ':silent! s/^\( *\)' . escape(b:comment_leader,'\/') . ' \?' . escape(b:comment_leader,'\/') . ' \?/\1/'
endfunction
nnoremap <Leader>c<Space> :call CommentToggle()<CR>

" polling period for GitGutter, 100 ms instead of default 4 seconds
set updatetime=100

" support 256-bit colors
" https://github.com/alacritty/alacritty/issues/109
if exists('+termguicolors')
  let &t_8f="\<Esc>[38;2;%lu;%lu;%lum"
  let &t_8b="\<Esc>[48;2;%lu;%lu;%lum"
  set termguicolors
endif

" show how syntax highlighting categorizes word at current point
" https://stackoverflow.com/questions/29029050/vim-highlighting-is-there-a-way-to-find-out-what-is-applied-at-a-particular-po
nm <silent> <F3> :echo "hi<" . synIDattr(synID(line("."),col("."),1),"name")
    \ . '> trans<' . synIDattr(synID(line("."),col("."),0),"name")
    \ . "> lo<" . synIDattr(synIDtrans(synID(line("."),col("."),1)),"name")
    \ . ">"<CR>

" prevent vim-markdown from adding bullets, indenting when adding new list
" item
let g:vim_markdown_auto_insert_bullets = 0
let g:vim_markdown_new_list_item_indent = 0

" prevent terminals from disappearing when navigating away from them
function! HiddenTerminal()
  :terminal
  set bufhidden=hide nonumber
endfunction
command! HiddenTerminal call HiddenTerminal()
nnoremap <Leader>t :HiddenTerminal<CR>
