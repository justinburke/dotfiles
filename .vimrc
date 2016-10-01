" numerics
set backspace=2		" so i can backspace over newlines, indentation, etc.

" ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
" Vundle configuration
filetype off                  " required
" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'

" Ctrl-P
Plugin 'git://github.com/ctrlpvim/ctrlp.vim'
let g:ctrlp_match_window = 'results:100'  " Load up to 100 results instead of limiting to window size.

" Plugin 'git://github.com/tpope/vim-fugitive.git'

Plugin 'git://github.com/majutsushi/tagbar.git'
" Plugin 'bling/vim-bufferline'
"
Plugin 'vim-airline/vim-airline'
Plugin 'vim-airline/vim-airline-themes'
" Enable tabline:
let g:airline#extensions#tabline#enabled = 1

Plugin 'rking/ag.vim'

Plugin 'LucHermitte/lh-vim-lib'
Plugin 'LucHermitte/local_vimrc'

"Plugin 'kana/vim-operator-user'
"Plugin 'rhysd/vim-clang-format'

" clang-format.py
let g:clang_format_path = '/usr/bin/clang-format-3.8'

" I could not get this to work...
"Plugin 'editorconfig/editorconfig-vim'
"let g:EditorConfig_verbose = 1

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

" ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

autocmd GUIEnter * :colors koehler
set background=dark

" my wordfile
"set dictionary=/usr/share/dict/words

set hidden		" allow hidden buffers. supposedly a 'must have'
set hlsearch		" highlight matches on searches
set ignorecase		" ignore case on searches
set laststatus=2	" Always show a status line, even when there's only a single window.
set magic		" enable extended regexp support
set nobackup		" don't store my crap in /tmp
set nocompatible	" non-vi compatible mode
set nostartofline	" preserve column on page movements
set nowrap		" so lines don't wrap
set nowritebackup	" don't create a backup file before overwrite
set ruler		" show curson position
set showbreak=>\        " String to put at the start of lines that have been wrapped.
set showcmd		" show current uncompleted command
set showmode		" show current mode
set wildmenu		" displays filenames in menubar
set wildmode=list:longest

syntax enable           " Enable syntax highlighting, keep current color settings.

set pastetoggle=<F12>

" Coding settings
au BufNewFile,BufRead *.{php,pl,phps,cgi} set expandtab shiftwidth=4 autoindent smartindent

au BufNewFile,BufRead *.{c,h,cc,cpp,C} set expandtab shiftwidth=3 formatoptions=croq autoindent cindent smartindent backspace=2

" CMake
au BufNewFile,BufRead CMakeLists.txt set expandtab shiftwidth=2

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

" Tagbar Focus
map <F9> :TagbarOpen j<CR>

" allow for quick saves
map <F10> :w<CR>
imap <F10> <ESC>:w<CR>a

" Find merge conflicts
nmap <F6> /<<<<<<<\\|=======\\|>>>>>>><CR>

" Manully create fold by matching the item under the cursor.
map <F7> V%zf<CR>

" Formatting
" map <F6> :!sort --ignore-case<CR>
nmap <F7> :%pyf /usr/share/clang/clang-format-3.8/clang-format.py<CR>
vmap <F7> :pyf /usr/share/clang/clang-format-3.8/clang-format.py<CR>

" format paragraphs
"imap <C-j> !}fmt<CR>

" ,cmt will insert "// " at the start of the line. Works in blocks too.
"map ,cmt :s/^/\/\/ /

" cycle fast thru buffers ...
" nnoremap <C-n> :bn<CR>
" nnoremap <C-p> :bp<CR>

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Faster grepping (from https://robots.thoughtbot.com/faster-grepping-in-vim)
" Use Silver Searcher if available:
if executable('ag')
  " Use ag over grep
  set grepprg=ag\ --nogroup\ --nocolor

  " Use ag in CtrlP for listing files. Lightning fast and respects .gitignore
  let g:ctrlp_user_command = 'ag %s -l --nocolor -g ""'

  " ag is fast enough that CtrlP doesn't need to cache
  let g:ctrlp_use_caching = 0
endif

"noremap <leader>t :CtrlP<CR>
"noremap <leader>r :CtrlPTag<cr>
"noremap <leader>R :CtrlPBufTag<cr>
"let g:ctrlp_match_window_reversed = 0
"let g:ctrlp_root_markers = ['.agignore', '.gitignore']
"" just use the directory vim is started in
"let g:ctrlp_working_path_mode = ''
"if executable('ag')
"  let g:ctrlp_user_command = 'ag %s -i --nocolor --nogroup --hidden
"        \ --ignore .git
"        \ --ignore .svn
"        \ --ignore .hg
"        \ --ignore .DS_Store
"        \ --ignore "**/*.pyc"
"        \ -g ""'
"endif

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Highlight trialing whitespace
" http://vim.wikia.com/wiki/Highlight_unwanted_spaces
highlight ExtraWhitespace ctermbg=red guibg=red
match ExtraWhitespace /\s\+$/
autocmd BufWinEnter * match ExtraWhitespace /\s\+$/
autocmd InsertEnter * match ExtraWhitespace /\s\+\%#\@<!$/
autocmd InsertLeave * match ExtraWhitespace /\s\+$/
autocmd BufWinLeave * call clearmatches()
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

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
" http://www.cmake.org/Wiki/CMake_Editors_Support
:autocmd BufRead,BufNewFile *.cmake,CMakeLists.txt,*.cmake.in runtime! indent/cmake.vim
:autocmd BufRead,BufNewFile *.cmake,CMakeLists.txt,*.cmake.in setf cmake
:autocmd BufRead,BufNewFile *.ctest,*.ctest.in setf cmake

" vim:filetype=vim:syntax=on
