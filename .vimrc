" Christian Freitas
" Plugins {{{
set nocompatible            
filetype off                  

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

Plugin 'VundleVim/Vundle.vim'
Plugin 'tyrannicaltoucan/vim-deep-space'
Plugin 'vim-airline/vim-airline'
Plugin 'ctrlpvim/ctrlp.vim'
Plugin 'octol/vim-cpp-enhanced-highlight'
Plugin 'moll/vim-node'
Plugin 'jelera/vim-javascript-syntax'
Plugin 'jaxbot/semantic-highlight.vim'
Plugin 'jeffkreeftmeijer/vim-numbertoggle'
Plugin 'tpope/vim-fugitive'
"Plugin 'vim-latex/vim-latex'

call vundle#end()           
filetype plugin indent on

" }}}
" Colors {{{
syntax enable           " enable syntax processing
set background=dark
colorscheme deep-space
let g:deepspace_italics = 1
let g:airline_theme='deep_space'
let g:cpp_member_variable_highlight = 1
let g:cpp_class_scope_highlight = 1
let g:cpp_experimental_template_highlight = 1
let g:cpp_concepts_highlight = 1
if has('termguicolors')
    set termguicolors
endif
" }}}
" Spaces & Tabs {{{
set tabstop=2           " 4 space tab
set expandtab           " use spaces for tabs
set softtabstop=2       " 4 space tab
set shiftwidth=2
set modelines=1
set backspace=indent,eol,start
set autoindent
" }}}
" UI Layout {{{
set number
set showcmd             " show command in bottom bar
set cursorline          " highlight current line
set wildmenu
set lazyredraw
set ttyfast             " faster redraw
set showmatch           " higlight matching parenthesis
set ai                          " set auto-indenting on for programming
set smartindent                 " try to be smart about indenting (C-style)
set vb                          " turn on the "visual bell" - which is much quieter than the "audio blink"
set nowrap                      " turn off line wrap
set scrolloff=3                 " show a minimum of a few lines above and below the current
set sidescrolloff=5             " show some to the sides
set autochdir                   " automatically change to the directory of the current file
set noshowmode
" }}}
" Searching {{{
set ignorecase          " ignore case when searching
set incsearch           " search as characters are entered
set hlsearch            " highlight all matches
" }}}
" Folding {{{
"set foldmethod=indent  " fold based on indent level
set foldnestmax=10      " max 10 depth
set foldenable          " don't fold files by default on open
set foldlevelstart=1   " start with fold level of 1
" }}}zo
" Backups {{{
set backup
set backupdir=$HOME/.vim/backup//
set directory=$HOME/.vim/tmp//
" }}}
" Airline Config {{{
let g:airline_powerline_fonts = 1
let g:airline_extensions = ['branch','tabline']

if !exists('g:airline_symbols')
    let g:airline_symbols = {}
endif

" airline symbols
let g:airline_left_sep = ''
let g:airline_left_alt_sep = ''
let g:airline_right_sep = ''
let g:airline_right_alt_sep = ''
let g:airline_symbols.branch = ''
let g:airline_symbols.readonly = ''
let g:airline_symbols.linenr = ''
set laststatus=2
" }}}
" CtrlP settings {{{
let g:ctrlp_match_window = 'bottom,order:ttb'
let g:ctrlp_switch_buffer = 0
let g:ctrlp_working_path_mode = 0
" }}}
" Autogroups {{{
" augroup configgroup
 "    autocmd!
  "  autocmd VimEnter * highlight clear SignColumn
    " autocmd FileType java setlocal noexpandtab
" augroup END
" }}}
" Functions {{{

" toggle between number and relativenumber
function! ToggleNumber()
    if(&relativenumber == 1)
        set norelativenumber
        set number
    else
        set relativenumber
    endif
endfunction

" strips trailing whitespace at the end of files. this
" is called on buffer write in the autogroup above.
function! <SID>StripTrailingWhitespaces()
    " save last search & cursor position
    let _s=@/
    let l = line(".")
    let c = col(".")
    %s/\s\+$//e
    let @/=_s
    call cursor(l, c)
endfunction
" }}}
" Shortcut Remapping & Leaders{{{
let mapleader="'"
inoremap jk <esc>
nnoremap :te :tabedit   
nnoremap :tf :tabfind   
nnoremap :tc :tabclose   
" }}}
" vim:foldmethod=marker:foldlevel=0
