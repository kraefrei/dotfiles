"Christian Freitas
" Plugins {{{
set nocompatible
filetype off

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

Plugin 'VundleVim/Vundle.vim'
Plugin 'itchyny/lightline.vim'
Plugin 'tpope/vim-fugitive'
Plugin 'airblade/vim-gitgutter'
Plugin 'thaerkh/vim-indentguides'
Plugin 'miyakogi/conoline.vim'
" Color Schemes
Plugin 'tyrannicaltoucan/vim-deep-space'
Plugin 'KeitaNakamura/neodark.vim'
Plugin 'joshdick/onedark.vim'
" Syntax Highlighting
" Plugin 'jaxbot/semantic-highlight.vim'
Plugin 'pangloss/vim-javascript'
Plugin 'octol/vim-cpp-enhanced-highlight'
Plugin 'moll/vim-node'
Plugin 'rust-lang/rust.vim'
"
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
if (has("autocmd") && !has('termguicolors'))
  let g:onedark_termcolors = 256
  augroup colorset
    autocmd!
    let s:white = { "gui": "#ABB2BF", "cterm": "145", "cterm16" : "7" }
    autocmd ColorScheme * call onedark#set_highlight("Normal", { "fg": s:white })
    " `bg` will not be styled since there is no `bg` setting
  augroup END
endif
let g:conoline_color_normal_dark = 'guibg=#2C323C'
let g:conoline_color_normal_nr_dark = 'guibg=#2C323C'
let g:conoline_color_insert_dark = 'guibg=#181A1F'
let g:conoline_color_insert_nr_dark = 'guibg=#181A1F'
let g:indentguides_conceal_color = get(g:, 'indentguides_conceal_color', 'ctermfg=238 ctermbg=NONE guifg=#3E4452 guibg=NONE')
let g:indentguides_specialkey_color = get(g:, 'indentguides_specialkey_color',  'ctermfg=238 ctermbg=NONE guifg=#3E4452 guibg=NONE')

colorscheme onedark

" }}}
" Spaces & Tabs {{{
set tabstop=4           " 2 space tab
set expandtab           " use spaces for tabs
set softtabstop=4       " 2 space tab
set shiftwidth=4
set modelines=1
set backspace=indent,eol,start
set autoindent
let g:indentguides_spacechar = '┃'
let g:indentguides_tabchar = ''
let g:indentguides_firstlevel = 1
let g:listchar_guides = 'trail:█'
set list
set listchars=tab:▞▞,trail:█,extends:>,precedes:< "eol:¶
set fillchars+=vert:┃
" }}}
" UI Layout {{{
set number
set noshowmode                  " dont show command in bottom bar
set wildmode=longest,list
set wildmenu
set lazyredraw
set ttyfast                     " faster redraw
set showmatch                   " higlight matching parenthesis
set ai                          " set auto-indenting on for programming
set smartindent                 " try to be smart about indenting (C-style)
set vb                          " turn on the "visual bell" - which is much quieter than the "audio blink"
set nowrap                      " turn on line wrap
set textwidth=100               " text width to 100 characters
set formatoptions=crob1jl       " TODO: Add definitions for each of these Args
set scrolloff=3                 " show a minimum of a few lines above and below the current
set sidescrolloff=5             " show some to the sides
set autochdir                   " automatically change to the directory of the current file
set splitbelow
set splitright
" }}}
" Searching {{{
set ignorecase          " ignore case when searching NOTE: Use I flag in search and replace to override
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
  \             [ 'filename' ] ],
  \   'right': [ [ 'lineinfo' ],
  \              [ 'gitstats' ],
  \              [ 'fileformat','fileencoding','filetype' ] ]
  \ },
  \ 'inactive': {
  \   'right': [ [  ],
  \              [ 'gitstats','lineinfo' ],
  \              [ 'filetype' ] ]
  \ },
  \ 'component': {
  \   'lineinfo': ' %3l·%-2v',
  \ },
  \ 'component_function': {
  \   'readonly': 'LightlineReadonly',
  \   'modified': 'LightlineModified',
  \   'fugitive': 'LightlineFugitive',
  \   'filename': 'LightlineFilename',
  \   'gitstats': 'LightlineGetHunkSummary'
  \ },
  \ 'separator': { 'left': "", 'right': "" },
  \ 'subseparator': { 'left': "", 'right': "·" }
  \ }
let g:lightline.tabline = {
  \ 'left': [ [ 'tabs' ] ],
  \ 'right': [ [ 'bufnum' ],[ ] ] }
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
function! LightlineGetHunkSummary()
  if exists('*fugitive#head')
    let branch = fugitive#head()
    if len(branch) != 0
      return '+' . GitGutterGetHunkSummary()[0] . ' ~' . GitGutterGetHunkSummary()[1] . ' -' . GitGutterGetHunkSummary()[2]
    endif
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
autocmd FileType c,cpp,java,php,ruby,python,rust,julia,vim autocmd BufWritePre <buffer> :call <SID>StripTrailingWhitespaces()
augroup numbertoggle
  autocmd!
  autocmd BufEnter,FocusGained,InsertLeave,TermClose * if &nu | set rnu | endif
  autocmd BufLeave,FocusLost,InsertEnter   * if &nu | set nornu | endif
  autocmd TermOpen * set nonumber
  autocmd TermOpen * call clearmatches()
  autocmd TermClose * set number
  autocmd TermClose * call clearmatches()
augroup END
augroup exceedingMargin
  autocmd FileType c,cpp,java,javascript,python,rust,julia,vim autocmd BufWinEnter,FocusGained,InsertLeave * let w:margin=matchadd('ErrorMsg', '\%>100v.\+', -1) | set cc=0
  autocmd FileType c,cpp,java,javascript,python,rust,julia,vim autocmd BufWinLeave,FocusLost,InsertEnter * call clearmatches() | set cc=100
augroup END
"augroup toggleTabs
" autocmd FileType c,cpp,java,php,ruby,rust,julia,vim autocmd BufWritePre * if &modifiable | set expandtab | %retab! | endif
" autocmd FileType c,cpp,java,php,ruby,rust,julia,vim autocmd VimEnter,BufReadPost,BufWritePost * if &modifiable | set noexpandtab | %retab! | set nomodified | endif
"augroup END
autocmd TermOpen * startinsert
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
function! ClearUndo()
    let old_undolevels = &undolevels
    set undolevels=-1
    exe "normal a \<Bs>\<Esc>"
    let &undolevels = old_undolevels
endfunction
function! NewTerminalTab()
  tab split | terminal
endfunction
function! NewTerminalSplit()
  sp | terminal
endfunction
function! NewTerminalvSplit()
  vsp | terminal
endfunction
" }}}
" Shortcut Remapping & Leaders{{{
let mapleader="""
inoremap jk <esc>
nnoremap tg gT
tnoremap <Esc> <C-\><C-n>
nnoremap :tbe :tabedit
nnoremap :tbf :tabfind
nnoremap :tbc :tabclose
nnoremap :ntt :call NewTerminalTab()
nnoremap :nts :call NewTerminalSplit()
nnoremap :ntv :call NewTerminalvSplit()
" }}}
" vim:foldmethod=marker:foldlevel=0
