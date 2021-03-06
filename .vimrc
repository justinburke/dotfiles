" Setup Vundle
set nocompatible              " be iMproved, required
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'

" Load Plugins
Plugin 'fatih/vim-go'
Plugin 'majutsushi/tagbar'

" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required
" To ignore plugin indent changes, instead use:
"filetype plugin on
"
" Brief help
" :PluginList       - lists configured plugins
" :PluginInstall    - installs plugins; append `!` to update or just :PluginUpdate
" :PluginSearch foo - searches for foo; append `!` to refresh local cache
" :PluginClean      - confirms removal of unused plugins; append `!` to auto-approve removal
"
" see :h vundle for more details or wiki for FAQ
" Put your non-Plugin stuff after this line

" numerics
set backspace=2		" so i can backspace over newlines, indentation, etc.

autocmd GUIEnter * :colors koehler
set background=dark

" my wordfile
"set dictionary=/usr/share/dict/words

set hidden		" allow hidden buffers. supposedly a 'must have'
set hlsearch		" highlight matches on searches
set ignorecase		" ignore case on searches
set magic		" enable extended regexp support
set nobackup		" don't store my crap in /tmp
set nocompatible	" non-vi compatible mode
set nostartofline	" preserve column on page movements
set nowrap		" so lines don't wrap
set nowritebackup	" don't create a backup file before overwrite
set ruler		" show curson position
set showcmd		" show current uncompleted command
set showmode		" show current mode
set wildmenu		" displays filenames in menubar
set wildmode=list:longest

syntax enable           " Enable syntax highlighting, keep current color settings.

set pastetoggle=<F12>

" my coding settings
au BufNewFile,BufRead *.{php,pl,phps,cgi} set expandtab shiftwidth=4 autoindent smartindent

au BufNewFile,BufRead *.{c,h,cc,cpp,C} set expandtab shiftwidth=3 formatoptions=croq autoindent cindent smartindent backspace=2

au BufNewFile,BufRead mutt* set tw=72 wrap formatoptions=tq2 syntax=mail
au BufNewFile,BufRead mutt* map <buffer> <F8> :%g/^> >/d<CR>
au BufNewFile,BufRead mutt* setlocal spell spelllang=en_us
"au Syntax mail source ~/.vim/after/syntax/mail.vim

hi def link mailQuoted1		Identifier
hi def link mailQuoted2		Statement
hi def link mailQuoted3		Type
hi def link mailQuoted4		Special
hi def link mailQuoted5		Comment
hi def link mailQuoted6		mailQuoted1
hi def link mailHeaderEmail	mailEmail
hi def link mailEmail		String

au BufNewFile,BufREad *.tex set ai tw=80 et
au BufNewFile,BufREad *.tex map <buffer> <F8> :w<CR> :!latex %<CR>
 
au Syntax help syn clear helpNote

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"" ABBREVIATIONS
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

ab Jusitn Justin

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"" MAPPINGS
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

"imap <C-h> i
imap <C-g> i
imap <C-k> ka
imap <C-l> la
imap <C-j> ja

"fix the backspace
imap [3~ <BS>

map <F4> :nohl<CR>

" allow for quick saves
map <F10> :w<CR>
imap <F10> <ESC>:w<CR>a


" format paragraphs
"imap <C-j> !}fmt<CR>

" ,cmt will insert "// " at the start of the line. Works in blocks too.
"map ,cmt :s/^/\/\/ /

" cycle fast thru buffers ...
nnoremap <C-n> :bn<CR>
nnoremap <C-p> :bp<CR>

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" http://vim.wikia.com/wiki/Easily_switch_between_source_and_header_file
map <F8> :e %:p:s,.h$,.X123X,:s,.cpp$,.h,:s,.X123X$,.cpp,<CR>

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Relative line numberings
function! NumberToggle()
  if(&relativenumber == 1)
    set nonumber
    set norelativenumber
  else
    set number
    set relativenumber
  endif
endfunc

nnoremap <C-j> :call NumberToggle()<CR>

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" " http://www.cmake.org/Wiki/CMake_Editors_Support
" :autocmd BufRead,BufNewFile *.cmake,CMakeLists.txt,*.cmake.in runtime! indent/cmake.vim
" :autocmd BufRead,BufNewFile *.cmake,CMakeLists.txt,*.cmake.in setf cmake
" :autocmd BufRead,BufNewFile *.ctest,*.ctest.in setf cmake

" vim:filetype=vim:syntax=on
