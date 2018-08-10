set tabstop=4
set noexpandtab
set shiftwidth=4
set title
set smartindent
set nrformats-=octal
set backspace=indent,eol,start
set number
set wrap
"set background=dark

highlight Search cterm=bold,reverse guibg=bold,reverse

"syntax on

"set rtp+=$GOROOT/misc/vim
"exe "set rtp+=".globpath($GOPATH, "src/github.com/nsf/gocode/vim")
"set completeopt=menu,preview

let s:dein_dir = expand('~/.cache/dein')
let s:dein_repo_dir = s:dein_dir . '/repos/github.com/Shougo/dein.vim'

let g:go_highlight_types = 1
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
