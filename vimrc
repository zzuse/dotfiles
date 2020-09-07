
" Maintainer:	zhangzhen<zzuseme@gmail.com>

" Use Vim settings, rather then Vi settings (much better!).
" This must be first, because it changes other options as a side effect.
set nocompatible

" using vim-plug to install plugins, seperated conf 
if filereadable(expand("~/.vimrc.bundles"))
    source ~/.vimrc.bundles
endif

" 猜测所打开文件的编码
set fileencodings=ucs-bom,utf-8,cp936,gb18030,big5,euc-jp,euc-kr,latin1
" 新建文件时会根据fileencoding的设置编码来保存
set fileencoding=utf-8
" Vim的内部使用编码,默认设置等于locale
set encoding=utf-8
" 设置和终端所使用的编码一致
set termencoding=utf-8
" unix文件换行符
set fileformat=unix

"" after quit vim still show in terminal,not very useful now "set t_ti= t_te=

set backspace=indent,eol,start " allow backspacing over everything in insert mode
set history=100           " keep 100 lines of command line history
set undolevels=100        " keep 100 lines of undolevels command line history
set ruler                " show the cursor position all the time
set showcmd              " display incomplete commands
set incsearch            " do incremental searching
set mps+=<:>             " use % to match not only () but also  <>
set tabstop=4            " TAB 解譯為幾個空白
set shiftwidth=4         " change TAB to the number of space characters inserted
set softtabstop=4        " 4 個空白會被當作一個 TAB 刪除
set expandtab            " change tab to space
set number               " numbers in side bar
set relativenumber       " relative line count
set ic                   " ignore case
set smartcase            " Case sensitive if we type an upper case
set path+=../include/
set foldmethod=syntax
set nobackup
set undodir=~/.vim/undodir

if !isdirectory(&undodir)
  call mkdir(&undodir, 'p', 0700)
endif

" cursorline disabled in diff mode
if &diff
    "echo "diff mode"
else
    " highlight cursorline
    set cul
    " highlight cursorcolumn
    set cuc
    " autocmd InsertLeave * se nocul  " 用浅色高亮当前行  
    " autocmd InsertLeave * se nocuc  " 用浅色高亮当前行  
    " autocmd InsertEnter * se cul    " 用浅色高亮当前行  
    " autocmd InsertEnter * se cuc    " 用浅色高亮当前行  
endif

" Key Mappings, ! means press second time will revert back

:nnoremap <Leader>c :set cursorline! <CR>
:nnoremap <Leader>a :set paste! <CR>
:nnoremap <Leader>n :set nu! <CR>
:nnoremap <Leader>r :set relativenumber! <CR>
:nnoremap <Leader>t :set expandtab! <CR>
:nnoremap <Leader>p :call Myclosepair()<CR>
:nnoremap <Leader>q :q <CR>
:nnoremap <Leader>wq :wq <CR>
" Ignore whitespace in diffmode 
:nnoremap <Leader>ww :set diffopt+=iwhite <CR>
:nnoremap <Leader>nw :set diffopt-=iwhite <CR>
" for file diff compare
nmap <F4> :vert diffsplit
" for fileencoding is not utf8
nmap <F5> :e ++enc=cp936<CR>
" for fileencoding is utf8
nmap <F6> :e ++enc=utf-8<CR>
" for reading asm code
nmap <F7> :set syntax=fasm<CR>
" for save to utf-8
nmap <F8> :set fileencoding=utf-8<CR>
" Don't use Ex mode, use Q for formatting
map Q gq

" Switch syntax highlighting on, when the terminal has colors
" Also switch on highlighting the last used search pattern.
syntax on
" 搜索数据时设置高亮
set hlsearch

" 自动补全括号引号
let g:my_closepair = 2
function Myclosepair()
    if g:my_closepair > 1
        let g:my_closepair = 1
        :inoremap ( ()<ESC>i
        :inoremap ) <c-r>=ClosePair(')')<CR>
        :inoremap { {}<ESC>i
        :inoremap } <c-r>=ClosePair('}')<CR>
        :inoremap [ []<ESC>i
        :inoremap ] <c-r>=ClosePair(']')<CR>
        :inoremap " ""<ESC>i
        :inoremap ' ''<ESC>i
        function! ClosePair(char)
            if getline('.')[col('.') - 1] == a:char
                return "\<Right>"
            else
                return a:char
            endif
        endfunction
    else
        let g:my_closepair = 2
        :inoremap ( (
        :inoremap ) <c-r>=ClosePair(')')<CR>
        :inoremap { {
        :inoremap } <c-r>=ClosePair('}')<CR>
        :inoremap [ [
        :inoremap ] <c-r>=ClosePair(']')<CR>
        :inoremap " "
        :inoremap ' '
        function! ClosePair(char)
            return a:char
        endfunction
    endif
endfunction
call Myclosepair()

filetype plugin indent on 
"打开文件类型检测, 加了这句才可以用智能补全
set completeopt=longest,menu
" Only do this part when compiled with support for autocommands.
" will put into seperated files
if has("autocmd")

    " Enable file type detection.
    " Use the default filetype settings, so that mail gets 'tw' set to 72,
    " 'cindent' is on in C files, etc.
    " Also load indent files, to automatically do language-dependent indenting.
    filetype plugin indent on

    " Put these in an autocmd group, so that we can delete them easily.
    augroup vimrcEx
        au!

        " For all text files set 'textwidth' to 78 characters.
        autocmd FileType text setlocal textwidth=1024

        " When editing a file, always jump to the last known cursor position.
        " Don't do it when the position is invalid or when inside an event handler
        " (happens when dropping a file on gvim).
        autocmd BufReadPost *
                    \ if line("'\"") > 0 && line("'\"") <= line("$") |
                    \   exe "normal g`\"" |
                    \ endif

    augroup END
    augroup cprog
        " Remove all cprog autocommands
        au!

        " When starting to edit a file:
        "   For C and C++ files set formatting of comments and set C-indenting on.
        "   For other files switch it off.
        "   Don't change the order, it's important that the line with * comes first.
        autocmd FileType *      set formatoptions=tcql nocindent comments&
        autocmd FileType c,cpp  set formatoptions=croql cindent comments=sr:/*,mb:*,el:*/,://
        " C++
        if has("fname_case")
            au BufNewFile,BufRead *.expr setf cpp
        else
            au BufNewFile,BufRead *.expr setf cpp
        endif
    augroup END
    augroup sim
        au BufNewFile,BufRead *.sim source ~/.vim/bundle/log.vim/syntax/sim.vim
        au BufNewFile,BufRead nginx.conf source ~/.vim/bundle/log.vim/syntax/nginx.vim
    augroup END
    au BufRead * normal zR  " 默认不折叠
else

    set autoindent		" always set autoindenting on

endif " has("autocmd")

" about colo and font
colo molokai
" 设置字体
set gfn=Consolas:h12:cANSI

" 自定义重设窗口的函数
function MaximizeVOC()
    " put your actual values below
    set lines=41
    set columns=178
endfunction
function MaximizeMBP()
    " put your actual values below
    set lines=36
    set columns=158
endfunction
" simplify resizing splits
:nnoremap <Leader>j <C-w>-
:nnoremap <Leader>k <C-w>+
:nnoremap <Leader>h <C-w><
:nnoremap <Leader>l <C-w>>
:nnoremap <F1>m :call MaximizeVOC() <CR>
:nnoremap <F2>m :call MaximizeMBP() <CR>

" for windows only
if has ("gui_running")
    colo molokai
    set mouse=a
else
    if &term =~ "vt100"
        if has("terminfo")
            set t_Co=256
            set t_Sf=[3%p1%dm
            set t_Sb=[4%p1%dm
        else
            set t_Co=256
            set t_Sf=[3%dm
            set t_Sb=[4%dm
        endif
    endif
    if &term =~ "xterm"
        if has("terminfo")
            let &t_Co=256
            let &t_Sf="\<Esc>[3%p1%dm"
            let &t_Sb="\<Esc>[4%p1%dm"
        else
            let &t_Co=256
            let &t_Sf="\<Esc>[3%dm"
            let &t_Sb="\<Esc>[4%dm"
        endif
    endif
endif

"  and enable snipMate compatibility feature.
let g:neosnippet#enable_snipmate_compatibility = 1
"  Tell Neosnippet about self snippets
let g:neosnippet#snippets_directory='~/.vim/bundle/vim-snippets/snippets'
"  for neosnippet Plugin key-mappings.
imap <C-k>     <Plug>(neosnippet_expand_or_jump)
smap <C-k>     <Plug>(neosnippet_expand_or_jump)
xmap <C-k>     <Plug>(neosnippet_expand_target)
"  SuperTab like snippets behavior.
"  imap <expr><TAB>
"  \ pumvisible() ? "\<C-n>" :
"  \ neosnippet#expandable_or_jumpable() ?
"  \    "\<Plug>(neosnippet_expand_or_jump)" : "\<TAB>"
smap <expr><TAB> neosnippet#expandable_or_jumpable() ?
            \ "\<Plug>(neosnippet_expand_or_jump)" : "\<TAB>"
"  for conceal markers.
if has('conceal')
    set conceallevel=2 concealcursor=niv
endif

" for airline
"  let g:airline_section_a       (mode, crypt, paste, spell, iminsert)
"  let g:airline_section_b       (hunks, branch)
"  let g:airline_section_c       (bufferline or filename)
"  let g:airline_section_gutter  (readonly, csv)
"  let g:airline_section_x       (tagbar, filetype, virtualenv)
"  let g:airline_section_y       (fileencoding, fileformat)
"  let g:airline_section_z       (percentage, line number, column number)
"  let g:airline_section_error   (ycm_error_count, syntastic, eclim)
"  let g:airline_section_warning (ycm_warning_count, whitespace)
function! AirlineInit()
    let g:airline_section_a = airline#section#create(['mode', ' ', 'branch'])
    let g:airline_section_b = airline#section#create_left(['hunks','file','%Y'])
    let g:airline_section_c = airline#section#create(['%F',' ','',' ','%B'])
    let g:airline_section_x = airline#section#create(['%{strftime("%c")}'])
endfunction
autocmd User AirlineAfterInit call AirlineInit()
" symbols change to unicode
if !exists('g:airline_symbols')
    let g:airline_symbols = {}
endif
" unicode symbols
let g:airline_left_sep = '»'
let g:airline_left_sep = '▶'
let g:airline_right_sep = '«'
let g:airline_right_sep = '◀'
let g:airline_symbols.crypt = '🔒'
let g:airline_symbols.linenr = '␊'
let g:airline_symbols.linenr = '␤'
let g:airline_symbols.linenr = '¶'
let g:airline_symbols.branch = '⎇'
let g:airline_symbols.paste = 'ρ'
let g:airline_symbols.paste = 'Þ'
let g:airline_symbols.paste = '∥'
let g:airline_symbols.spell = 'Ꞩ'
let g:airline_symbols.notexists = '∄'
let g:airline_symbols.whitespace = 'Ξ'
let g:airline#extensions#default#layout = [
      \ [ 'c', 'z', 'y', 'x', 'warning' ],
      \ [ 'error', 'b', 'a' ]
      \ ]
let g:airline_extensions = []   " 消除卡顿
let g:airline_inactive_collapse=1

" for NERDTree
nnoremap <C-n>t :NERDTreeToggle<CR>
" :p:h on a directory name results on the directory name itself
nnoremap <C-n>p :NERDTree %:p:h<CR>

" for indentLine
" let g:indentLine_color_term = 239
" let g:indentLine_bgcolor_term = 202
let g:indentLine_char = '⎸'

" from Damian Conway
nnoremap <silent> n   n:call HLNext(0.4)<cr>
nnoremap <silent> N   N:call HLNext(0.4)<cr>
" OR ELSE just highlight the match in red...
function! HLNext (blinktime)
    highlight RedOnRed ctermfg=red ctermbg=red
    if has ("gui_running")
        highlight RedOnRed guifg=#000000 guibg=#F92672
    endif
    let [bufnum, lnum, col, off] = getpos('.')
    let matchlen = strlen(matchstr(strpart(getline('.'),col-1),@/))
    let target_pat = '\c\%#\%('.@/.'\)'
    let ring = matchadd('RedOnRed', target_pat, 101)
    redraw
    exec 'sleep ' . float2nr(a:blinktime * 10) . 'm'
    call matchdelete(ring)
    redraw
endfunction

" for python-mode plugin
let g:pymode_python = 'python3'

" Local config
if filereadable($HOME . "/.vimrc.local")
    source ~/.vimrc.local
endif

set clipboard=unnamed    " 共享剪贴板
