set encoding=utf-8
scriptencoding utf-8
set fileencoding=utf-8
set ambiwidth=double

set cursorline
set tabstop=2
set noexpandtab
set shiftwidth=2
set title
set smartindent
set nrformats-=octal
set backspace=indent,eol,start
set number
set relativenumber
set wrap
set clipboard+=unnamedplus
"set background=dark

highlight Search cterm=bold,reverse guibg=bold,reverse

let s:dein_dir = expand('~/.cache/dein')
let s:dein_repo_dir = s:dein_dir . '/repos/github.com/Shougo/dein.vim'

let g:go_highlight_functions = 1
let g:go_highlight_methods = 1

" dein installation check
if &runtimepath !~# '/dein.vim'
        if !isdirectory(s:dein_repo_dir)
                execute '!git clone https://github.com/Shougo/dein.vim' s:dein_repo_dir
        endif
        execute 'set runtimepath^=' . fnamemodify(s:dein_repo_dir, ':p')
endif

if dein#load_state(s:dein_dir)
        call dein#begin(s:dein_dir)

        let g:rc_dir    = expand('~/.vim/rc')
        let s:toml      = g:rc_dir . '/dein.toml'
        let s:lazy_toml = g:rc_dir . '/dein_lazy.toml'

        call dein#load_toml(s:toml     , {'lazy':0})
        call dein#load_toml(s:lazy_toml, {'lazy':1})

        call dein#end()
        call dein#save_state()
endif

if dein#check_install()
        call dein#install()
endif

let g:python3_host_prog = expand('/usr/bin/python3.6')

syntax enable
" colorscheme xoria256
colorscheme iceberg
set completeopt=menu,preview
let mapleader = "\<Space>"
nnoremap <Leader>w :w<CR>

let Tlist_Show_One_File = 1
let Tlist_Use_Right_Window = 1
let Tlist_Exit_OnlyWindow = 1 
nnoremap <silent> <Esc><Esc> :noh<CR>
nnoremap <silent> <C-j> :bprev<CR>
nnoremap <silent> <C-k> :bnext<CR>

augroup Filetypes
	autocmd FileType go setlocal tabstop=4 shiftwidth=4
