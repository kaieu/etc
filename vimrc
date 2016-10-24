" INDENT
set autoindent
set smartindent

" DISPLAY
set number
set foldcolumn=2
set laststatus=2

" COLORS
syntax on
set background=dark
set t_Co=256

" MOUSE
set mouse=a
set ttymouse=sgr

" MISC
set hlsearch


" PLUGINS

call plug#begin('~/.vim/plugged')
Plug 'junegunn/vim-easy-align'
Plug 'mhinz/vim-rfc'
Plug 'vim-scripts/rfc-syntax', {'for': 'rfc'}
call plug#end()

