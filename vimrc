
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
set history=50           " keep 50 lines of command line history
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
set cursorline           " set column or line color or "set cursorcolumn

:nnoremap <Leader>c :set cursorline! <CR>
:nnoremap <Leader>p :set paste! <CR>
:nnoremap <Leader>n :set nu! <CR>
:nnoremap <Leader>t :set expandtab! <CR>
nmap <F5> :e ++enc=cp936<CR>  " for fileencoding is not utf8
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
set background=dark
set gfn=Consolas:h12:cANSI

" only windows, not macvim, TODO
if has ("gui_running")
	set background=light

	source $VIMRUNTIME/mswin.vim
	behave mswin

	set diffexpr=MyDiff()
	function MyDiff()
		let opt = '-a --binary '
		if &diffopt =~ 'icase' | let opt = opt . '-i ' | endif
		if &diffopt =~ 'iwhite' | let opt = opt . '-b ' | endif
		let arg1 = v:fname_in
		if arg1 =~ ' ' | let arg1 = '"' . arg1 . '"' | endif
		let arg2 = v:fname_new
		if arg2 =~ ' ' | let arg2 = '"' . arg2 . '"' | endif
		let arg3 = v:fname_out
		if arg3 =~ ' ' | let arg3 = '"' . arg3 . '"' | endif
		let eq = ''
		if $VIMRUNTIME =~ ' '
			if &sh =~ '\<cmd'
				let cmd = '""' . $VIMRUNTIME . '\diff"'
				let eq = '"'
			else
				let cmd = substitute($VIMRUNTIME, ' ', '" ', '') . '\diff"'
			endif
		else
			let cmd = $VIMRUNTIME . '\diff'
		endif
		silent execute '!' . cmd . ' ' . opt . arg1 . ' ' . arg2 . ' > ' . arg3 . eq
	endfunction

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

" for UltiSnips
" Trigger configuration. Do not use <tab> if you use
" https://github.com/Valloric/YouCompleteMe.
let g:UltiSnipsExpandTrigger="<c-x>"
let g:UltiSnipsJumpForwardTrigger="<c-b>"
let g:UltiSnipsJumpBackwardTrigger="<c-z>"
" If you want :UltiSnipsEdit to split your window.
let g:UltiSnipsEditSplit="vertical"

" for NERDTree
nnoremap <C-n>t :NERDTreeToggle<CR>
" :p:h on a directory name results on the directory name itself
nnoremap <C-n>p :NERDTree %:p:h<CR>

" Local config
if filereadable($HOME . "/.vimrc.local")
  source ~/.vimrc.local
endif

