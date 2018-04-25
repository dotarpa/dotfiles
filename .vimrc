set tabstop=4
set expandtab
set shiftwidth=4
set title
set smartindent
set nrformats-=octal
set backspace=indent,eol,start

set rtp+=$GOROOT/misc/vim
exe "set rtp+=".globpath($GOPATH, "src/github.com/nsf/gocode/vim")
set completeopt=menu,preview

"dein Scripts-----------------------------
if &compatible
      set nocompatible               " Be iMproved
endif

" Required:
set runtimepath+=~/.vim/bundles/dein/repos/github.com/Shougo/dein.vim

" Required:
if dein#load_state('~/.vim/bundles/dein')
    call dein#begin('~/.vim/bundles/dein')

    " Let dein manage dein
    " Required:
    call dein#add('~/.vim/bundles/dein/repos/github.com/Shougo/dein.vim')

    " Add or remove your plugins here:
    call dein#add('Shougo/neosnippet.vim')
    call dein#add('Shougo/neosnippet-snippets')

    " go plugins
    call dein#add('faith/vim-go')

    " You can specify revision/branch/tag.
    call dein#add('Shougo/deol.nvim', { 'rev': 'a1b5108fd' })

    " Required:
    call dein#end()
    call dein#save_state()
endif

" Required:
filetype plugin indent on
syntax enable

" If you want to install not installed plugins on startup.
"if dein#check_install()
"  call dein#install()
"endif
