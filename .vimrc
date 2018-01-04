" Christian Freitas
" Plugins {{{
set nocompatible
filetype off

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

Plugin 'VundleVim/Vundle.vim'
Plugin 'itchyny/lightline.vim'
Plugin 'tpope/vim-fugitive'
" Color Schemes
Plugin 'tyrannicaltoucan/vim-deep-space'
Plugin 'KeitaNakamura/neodark.vim'
Plugin 'joshdick/onedark.vim'
" Syntax Highlighting
Plugin 'jaxbot/semantic-highlight.vim'
Plugin 'pangloss/vim-javascript'
Plugin 'octol/vim-cpp-enhanced-highlight'
Plugin 'moll/vim-node'
Plugin 'rust-lang/rust.vim'

call vundle#end()
filetype plugin indent on

" }}}
" Colors {{{
syntax enable           " enable syntax processing
set background=dark
let g:cpp_member_variable_highlight = 1
let g:cpp_class_scope_highlight = 1
let g:cpp_experimental_template_highlight = 1
let g:cpp_concepts_highlight = 1
if has('termguicolors')
  set termguicolors
endif
" onedark.vim override: Don't set a background color when running in a terminal
" `gui` is the hex color code used in GUI mode/nvim true-color mode
" `cterm` is the color code used in 256-color mode
" `cterm16` is the color code used in 16-color mode
colorscheme onedark 
" }}}
" Spaces & Tabs {{{
set tabstop=2           " 2 space tab
set expandtab           " use spaces for tabs
set softtabstop=2       " 2 space tab
set shiftwidth=2
set modelines=1
set backspace=indent,eol,start
set autoindent
" }}}
" UI Layout {{{
set number
set noshowmode                  " show command in bottom bar
set cursorline                  " highlight current line
set wildmode=longest,list
set wildmenu
set lazyredraw
set ttyfast                     " faster redraw
set showmatch                   " higlight matching parenthesis
set ai                          " set auto-indenting on for programming
set smartindent                 " try to be smart about indenting (C-style)
set vb                          " turn on the "visual bell" - which is much quieter than the "audio blink"
"set nowrap                      " turn off line wrap
set scrolloff=3                 " show a minimum of a few lines above and below the current
set sidescrolloff=5             " show some to the sides
set autochdir                   " automatically change to the directory of the current file
set noshowmode
set splitbelow
set splitright
set list
set listchars=trail:-,extends:>,preceds:<
" }}}
" Searching {{{
set ignorecase          " ignore case when searching
set incsearch           " search as characters are entered
set hlsearch            " highlight all matches
" }}}
" Folding {{{
set foldnestmax=10      " max 10 depth
set foldenable          " don't fold files by default on open
set foldlevelstart=1   " start with fold level of 1
" }}}
" Lightline Config {{{

" lightline symbols
let g:lightline = {
  \ 'colorscheme': 'onedark',
  \ 'active': {
  \   'left': [ [ 'mode' ],
  \             [ 'fugitive' ],
  \             [ 'filename' ] ]
  \ },
  \ 'component': {
  \   'lineinfo': ' %3l:%-2v',
  \ },
  \ 'component_function': {
  \   'readonly': 'LightlineReadonly',
  \   'modified': 'LightlineModified',
  \   'fugitive': 'LightlineFugitive',
  \   'filename': 'LightlineFilename'
  \ },
  \ 'separator': { 'left': "\ue0b0", 'right': "\ue0b2" },
  \ 'subseparator': { 'left': "\ue0b1", 'right': "\ue0b3" }
  \ }
let g:lightline.tabline = {
  \ 'left': [ [ 'tabs' ] ],
  \ 'right': [ [ 'bufnum' ],['relativepath'] ] }
function! LightlineFilename()
	return ('' != LightlineReadonly() ? LightlineReadonly() . ' ' : '') .
	      \ (&ft == 'vimfiler' ? vimfiler#get_status_string() :
        \  &ft == 'unite' ? unite#get_status_string() :
	      \ '' != expand('%:t') ? expand('%:t') : '[No Name]') .
	      \ ('' != LightlineModified() ? ' ' . LightlineModified() : '')
endfunction
function! LightlineReadonly()
  return &readonly ? '' : ''
endfunction
function! LightlineModified()
  return &modifiable && &modified ? '+' : ''
endfunction
function! LightlineFugitive()
  if exists('*fugitive#head')
    let branch = fugitive#head()
    return branch !=# '' ? ' '.branch : ''
  endif
  return ''
endfunction

set showtabline=2
set laststatus=2
"let g:airline_symbols.branch = ''
"let g:airline_symbols.readonly = ''
"let g:airline_symbols.linenr = ''
"let g:airline_symbols.paste = 'ρ'
"let g:airline_symbols.whitespace = 'Ξ'
" }}}
" Autocommands {{{
autocmd BufWritePre * :call <SID>StripTrailingWhitespaces()
augroup numbertoggle
  autocmd!
  autocmd BufEnter,FocusGained,InsertLeave * if &nu | set rnu   | endif
  autocmd BufLeave,FocusLost,InsertEnter   * if &nu | set nornu | endif
augroup END

autocmd FileType tex autocmd BufEnter <buffer> :setlocal spell spelllang=en_us

" }}}
" Functions {{{
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
let mapleader="""
inoremap jk <esc>
nnoremap tg gT
nnoremap :te :tabedit
nnoremap :tf :tabfind
nnoremap :tc :tabclose
" }}}
" vim:foldmethod=marker:foldlevel=0
