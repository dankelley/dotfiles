if has('python3')
endif
set nofoldenable " disable folding
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
let r_indent_align_args = 0 " 1 means align to (
let r_indent_ess_comments = 0 " 1 means single # aligns at col 40
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

" edit directory containing file
map <LocalLeader>e :e <C-R>=expand("%:p:h") . "/" <CR>

"setup for hardcopy
"set printfont=Courier:h10
"set printfont=Monaco:h12
set printfont=IBM_Plex_Mono:h12
"set printfont=Courier:h14
set printoptions=left:15pt,right:15pt,top:15pt,bottom:15pt

if has("gui_running")
    colorscheme dek01
    set guifont=IBMPlexMono-Medium:h16
    "set guifont=Monaco:h13
    "colorscheme base16-default-dark
else
    "colorscheme default
    colorscheme dek01
endif
set columns=80

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

" Touchbar
amenu TouchBar.make :!make<CR>
amenu TouchBar.@q @q

"" vimorganizer
" au! BufRead,BufWrite,BufWritePost,BufNewFile *.org
" au BufEnter *.org            call org#SetOrgFileType()


if $VIM_CRONTAB == "true"
    set nobackup
    set nowritebackup
endif
set backupskip=/tmp/*,/private/tmp/*"

" 2014-05-08
"autocmd BufRead,BufNewFile *.rmd set filetype=rmarkdown
autocmd BufRead,BufNewFile *.md set filetype=markdown
"autocmd BufRead,BufNewFile *.txt set filetype=markdown
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
"inoremap jj <esc>


call plug#begin('~/.vim/plugged')
"Plug 'vim-airline/vim-airline'
"Plug 'vim-airline/vim-airline-themes'
"Plug 'voldikss/vim-floaterm'
"let g:floaterm_keymap_new = '<Leader>ft'
" Plug 'vim-airline/vim-airline'
" https://github.com/SirVer/ultisnips
" https://www.sirver.net/about.html
Plug 'chriskempson/base16-vim'
Plug 'SirVer/ultisnips'
Plug 'honza/vim-snippets'
Plug 'petRUShka/vim-sage'
let g:UltiSnipsExpandTrigger="<tab>"
"let g:UltiSnipsJumpForwardTrigger="<c-b>"
"let g:UltiSnipsJumpBackwardTrigger="<c-z>"
let g:UltiSnipsEditSplit="vertical"
"Plug 'neovim/nvim-lspconfig'
">" org mode https://github.com/kristijanhusak/orgmode.nvim
">Plug 'kristijanhusak/orgmode.nvim'
" Telescope https://github.com/nvim-telescope/telescope.nvim
"Plug 'neoclide/coc.nvim', {'branch': 'release'}
if has('nvim')
" treesitter
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}  " We recommend updating the parsers on update
"Plug 'vim-pandoc/vim-pandoc'
"Plug 'vim-pandoc/vim-pandoc-syntax'
Plug 'nvim-lua/popup.nvim'
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'
" Find files using Telescope command-line sugar.
nnoremap <localleader>ff <cmd>Telescope find_files<cr>
nnoremap <localleader>fg <cmd>Telescope live_grep<cr>
nnoremap <localleader>fb <cmd>Telescope buffers<cr>
nnoremap <localleader>fh <cmd>Telescope help_tags<cr>
" Using Lua functions
nnoremap <localleader>ff <cmd>lua require('telescope.builtin').find_files()<cr>
nnoremap <localleader>fg <cmd>lua require('telescope.builtin').live_grep()<cr>
nnoremap <localleader>fb <cmd>lua require('telescope.builtin').buffers()<cr>
nnoremap <localleader>fh <cmd>lua require('telescope.builtin').help_tags()<cr>
Plug 'jremmen/vim-ripgrep'
endif
" Julia
Plug 'jpalardy/vim-slime', { 'for': ['julia']}
Plug 'hanschen/vim-ipython-cell', { 'for': ['julia'] }
Plug 'JuliaEditorSupport/julia-vim'
Plug 'kdheepak/JuliaFormatter.vim'
"Plug 'neoclide/coc.nvim', {'branch': 'release'}
"Plug 'chuling/ci_dark.vim'
Plug 'drewtempelmeyer/palenight.vim'
"Plug 'vimwiki/vimwiki'
Plug 'jalvesaq/Nvim-R', {'branch': 'stable'}
"Plug 'jalvesaq/zotcite'
Plug 'vim-pandoc/vim-pandoc'
Plug 'vim-pandoc/vim-pandoc-syntax'
Plug 'vim-pandoc/vim-rmarkdown'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --no-bash' }
Plug 'junegunn/fzf.vim'
call plug#end()

"> " vimwiki: use markdown format
"> let g:vimwiki_list = [{'path': '~/git/vimwiki/',
">                       \ 'syntax': 'markdown', 'ext': '.md'}]
"> " https://unix.stackexchange.com/questions/124407/what-color-codes-can-i-use-in-my-ps1-prompt
"> hi VimwikiHeader1 guifg=#C00000 " muted red
"> hi VimwikiHeader2 guifg=#00C000 " muted green
"> hi VimwikiHeader3 guifg=#C0C000 " muted yellow
"> hi VimwikiHeader4 guifg=#0000C0 " muted blue
"> hi VimwikiHeader5 guifg=#C000C0 " muted magenta
"> hi VimwikiHeader6 guifg=#00C0C0 " muted cyan
"> hi link VimwikiHeader1 pandocBlockQuoteLeader1
" set hi link VimwikiHeader2 pandocBlockQuoteLeader2
" set hi link VimwikiHeader3 pandocBlockQuoteLeader3
" set hi link VimwikiHeader4 pandocBlockQuoteLeader4
" set hi link VimwikiHeader5 pandocBlockQuoteLeader5
" set hi link VimwikiHeader6 pandocBlockQuoteLeader6

"
" turn off incremental search, which neovim uses
set noincsearch

set cursorline

" R
vmap <Space> <Plug>RDSendSelection
nmap <Space> <Plug>RDSendLine

" Show partial lines (useful for single-line paragraphs)
set display+=lastline


" Slime
let g:slime_target = "tmux"
let g:slime_default_config = {"socket_name": "default", "target_pane": "{last}"}
let g:slime_dont_ask_default = 1
" Julia: make <Space>j run current line. Note that <C-c><C-c> runs paragraph.
autocmd Filetype julia xnoremap <Space>j :SlimeSendCurrentLine<cr>
autocmd Filetype julia nnoremap <Space>j :SlimeSendCurrentLine<cr>
let g:slime_cell_delimiter = "#%%"
"nmap <localleader>s <Plug>SlimeSendCell
"autocmd Filetype julia xnoremap <localleader>s :SlimeSendCell<cr>
"autocmd Filetype julia nnoremap <localleader>s :SlimeSendCell<cr>

" Fancy line numbering.
" https://jeffkreeftmeijer.com/vim-number/
set number relativenumber
augroup numbertoggle
  autocmd!
  autocmd BufEnter,FocusGained,InsertLeave * set relativenumber
  autocmd BufLeave,FocusLost,InsertEnter   * set norelativenumber
augroup END


" For ctags: see https://github.com/preservim/tagbar/wiki#r,
" which also explains how to edit .zshrc
" NB. on macOS, need to use the brew version of ctags.
let g:tagbar_type_r = {
    \ 'ctagstype' : 'r',
    \ 'kinds'     : [
        \ 'f:Functions',
        \ 'g:GlobalVariables',
        \ 'v:FunctionVariables',
    \ ]
\ }

:command! Rtags :!Rscript -e 'rtags(path="./", recursive=TRUE, ofile="TAGS", type="ctags")'
set tags+=rtags

let g:airline_theme='base16'

