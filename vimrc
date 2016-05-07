
" Maintainer:	zhangzhen<zzuseme@gmail.com>

" Use Vim settings, rather then Vi settings (much better!).
" This must be first, because it changes other options as a side effect.
set nocompatible

if filereadable(expand("~/.vimrc.bundles"))
    source ~/.vimrc.bundles
endif

set fileencodings=ucs-bom,utf-8,cp936,gb18030,big5,euc-jp,euc-kr,latin1

"" after quit vim still show in terminal,not very useful now "set t_ti= t_te=

" allow backspacing over everything in insert mode
set backspace=indent,eol,start
set history=100           " keep 100 lines of command line history
set undolevels=100        " keep 100 lines of undolevels command line history
set ruler                " show the cursor position all the time
set showcmd              " display incomplete commands
set incsearch            " do incremental searching
set mps+=<:>             " use % to match <>
set tabstop=4
set shiftwidth=4         " change the number of space characters inserted
set expandtab            " change tab to space
set number               " numbers in side bar
set relativenumber
set ic                   " ignore case
set smartcase            " Case sensitive if we type an upper case
"set cursorline           " set column or line color or "set cursorcolumn
set path+=../include/

if &diff
    "echo "diff mode"
else
    set cursorline
endif

:nnoremap <Leader>c :set cursorline! <CR>
:nnoremap <Leader>p :set paste! <CR>
:nnoremap <Leader>n :set nu! <CR>
:nnoremap <Leader>r :set relativenumber! <CR>
:nnoremap <Leader>t :set expandtab! <CR>
:nnoremap <Leader>ww :set diffopt+=iwhite <CR>
:nnoremap <Leader>nw :set diffopt-=iwhite <CR>
nmap <F5> :e ++enc=cp936<CR>   " for fileencoding is not utf8
nmap <F6> :e ++enc=utf-8<CR>   " for fileencoding is utf8
nmap <F7> :set syntax=fasm<CR> " for reading asm code
" Don't use Ex mode, use Q for formatting
map Q gq

" Switch syntax highlighting on, when the terminal has colors
" Also switch on highlighting the last used search pattern.
syntax on
set hlsearch
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


else

    set autoindent		" always set autoindenting on

endif " has("autocmd")

" about colo and font
colo molokai
set gfn=Consolas:h12:cANSI
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

" only windows, not macvim, TODO
if has ("gui_running")

    colo molokai
    "	source $VIMRUNTIME/mswin.vim
    "	behave mswin
    "
    "	set diffexpr=MyDiff()
    "	function MyDiff()
    "		let opt = '-a --binary '
    "		if &diffopt =~ 'icase' | let opt = opt . '-i ' | endif
    "		if &diffopt =~ 'iwhite' | let opt = opt . '-b ' | endif
    "		let arg1 = v:fname_in
    "		if arg1 =~ ' ' | let arg1 = '"' . arg1 . '"' | endif
    "		let arg2 = v:fname_new
    "		if arg2 =~ ' ' | let arg2 = '"' . arg2 . '"' | endif
    "		let arg3 = v:fname_out
    "		if arg3 =~ ' ' | let arg3 = '"' . arg3 . '"' | endif
    "		let eq = ''
    "		if $VIMRUNTIME =~ ' '
    "			if &sh =~ '\<cmd'
    "				let cmd = '""' . $VIMRUNTIME . '\diff"'
    "				let eq = '"'
    "			else
    "				let cmd = substitute($VIMRUNTIME, ' ', '" ', '') . '\diff"'
    "			endif
    "		else
    "			let cmd = $VIMRUNTIME . '\diff'
    "		endif
    "		silent execute '!' . cmd . ' ' . opt . arg1 . ' ' . arg2 . ' > ' . arg3 . eq
    "	endfunction

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

" for neoComplete
let g:neocomplete#enable_at_startup = 1
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

" for NERDTree
nnoremap <C-n>t :NERDTreeToggle<CR>
" :p:h on a directory name results on the directory name itself
nnoremap <C-n>p :NERDTree %:p:h<CR>

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
    exec 'sleep ' . float2nr(a:blinktime * 100) . 'm'
    call matchdelete(ring)
    redraw
endfunction

" Local config
if filereadable($HOME . "/.vimrc.local")
    source ~/.vimrc.local
endif

