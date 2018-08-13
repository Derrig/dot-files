" Activates filetype detection
filetype plugin indent on

" activates syntax highlighting among other things
syntax on

" allows you to deal with multiple unsaved
" buffers simultaneously without resorting
" to misusing tabs
set hidden

" just hit backspace without this one and
" see for yourself
set backspace=indent,eol,start

" disable folding
set nofoldenable    

call plug#begin('~/.vim/plugged')
Plug 'arrufat/vala.vim'
Plug 'arcticicestudio/nord-vim'
call plug#end()

colorscheme nord
