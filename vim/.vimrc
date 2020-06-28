au BufRead *.txt setlocal spell spelllang=en_us
au BufRead *.tex setlocal spell spelllang=en_us
au BufRead *.md  setlocal spell spelllang=en_us

set wrap
set linebreak
set mouse=a

autocmd Filetype tex setlocal nofoldenable
let vimrplugin_vimpager = "no"
set backup
set backupskip=/tmp/*,/private/tmp/*
let mapleader = ','
let maplocalleader = ','
let r_indent_align_args = 1
let r_indent_ess_comments = 1
set enc=utf-8
set ruler

set nohlsearch
set tabpagemax=100
set laststatus=2
set statusline=[%l,%c\ %P%M]\ 0x%B\ %f\ %r%h%w

set expandtab
set shiftwidth=4
set softtabstop=4

"set tw=100
set number
noremap Q gq}

"" edit directory containing file
" map <LocalLeader>e :e <C-R>=expand("%:p:h") . "/" <CR>

"setup for hardcopy
"set printfont=Courier:h10
"set printfont=Monaco:h12
set printfont=IBM_Plex_Mono:h9
"set printfont=Courier:h14
set printoptions=left:15pt,right:15pt,top:15pt,bottom:15pt

colorscheme dek01
if has("gui_macvim")
    "set guifont=Monaco:h13
    set guifont=IBM_Plex_Mono:h14
else
    set columns=80
endif

"if has("gui_macvim")
"   hi Conceal guibg=White guifg=Black
"   set cole=2
"   "let g:tex_conceal= 'adgm'
"endif

" for plugins
set modelines=1
set nocompatible
filetype plugin on
"syntax enable
syntax on
filetype indent on

" kelley: for R docs, convert \code{\link{something}} to [something()], i.e. Rd to md format
:map <F1> :s/\\code{\\link{\([^}]*\)}}/[\1()]/gc
" kelley: for R docs, convert \code{something} to `something`, i.e. Rd to md format
:map <F2> :s/\\code{\([^}]*\)}/`\1`/gc
" kelley: undo roxygen (seems not to work in for functions etc??)
:map <F3> :s/`\([^`]*\)`/\\code{\1}/gc
" kelley: F12 runs !make
:map <F12> :!make<CR>

"" vimorganizer
" au! BufRead,BufWrite,BufWritePost,BufNewFile *.org
" au BufEnter *.org            call org#SetOrgFileType()


if $VIM_CRONTAB == "true"
    set nobackup
    set nowritebackup
endif
set backupskip=/tmp/*,/private/tmp/*"

" 2014-05-08
autocmd BufNewFile,BufReadPost *.Rmd set filetype=Rnoweb
autocmd BufNewFile,BufReadPost *.md set filetype=markdown
autocmd BufNewFile,BufReadPost *.txt set filetype=markdown
let g:instant_markdown_slow = 1

" vimr
if has("gui_vimr")
    set number
endif
augroup XML
    autocmd!
    autocmd FileType xml setlocal foldmethod=indent foldlevelstart=999 foldminlines=0
augroup END

"" for pathogen (see https://github.com/tpope/vim-pathogen)
"execute pathogen#infect()

" display error char for trailing blanks on lines
match ErrorMsg '\s\+$'

" escape as jj
inoremap jj <esc>

"call plug#begin('~/.vim/plugged')
" 
"Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --no-bash' }
"Plug 'junegunn/fzf.vim'
"
"call plug#end()

" vimwiki: use markdown format
let g:vimwiki_list = [{'path': '~/vimwiki/',
                      \ 'syntax': 'markdown', 'ext': '.wiki'}]
