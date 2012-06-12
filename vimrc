""""""""""""""""""""""""""""""""""""""""""""""""""""""
"My Commands 
""""""""""""""""""""""""""""""""""""""""""""""""""""""

command! Module :s/\(\s\+\)\(\w\+\),/\1.\2(\2),/


""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => General
""""""""""""""""""""""""""""""""""""""""""""""""""""""

"make it easier to jump to specific mark locations
nnoremap ' `
nnoremap ` '
"keep longer history log
set history=700
"change terminal title(hopefully)
set title

filetype plugin on
filetype indent on

"auto read when a file is changed from the outside
set autoread

let mapleader = ","
let g:mapleader = ","

"fast saving
nmap <leader>w :w!<cr>

"when vimrc is edited, reload it
autocmd! bufwritepost vimrc source ~/.vimrc

""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => VIM userinterface 
""""""""""""""""""""""""""""""""""""""""""""""""""""""
"Mouse Option
set mouse=a
set ttymouse=xterm2

"center page on cursor a bit better
set scrolloff=7

"show menu with possible tab completions
set wildmenu

"always show cucrent position
set ruler

set cmdheight=1

"Set backspace confi
set backspace=eol,start,indent
set whichwrap+=<,>,h,l

"search casing
set ignorecase
set smartcase

set hlsearch "Highlight search things

"set incsearch "make search act like search in modern browser
set nolazyredraw "don't redraw while executing macros

set magic "Set magic on, for regex

set showmatch "Show batching brackets when text indicator is over them
set mat=2 "how many tenths of a second to blink

"No sound on errors
set noerrorbells
set novisualbell
set t_vb=

""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Colors and Fonts
""""""""""""""""""""""""""""""""""""""""""""""""""""""

syntax enable "enable syntax hl

set gfn=Monospace\ 10
set shell=/bin/bash

colorscheme ron
set background=dark

set encoding=utf8

try
	lang en_US
catch
endtry

"highlight Pmenu ctermfg=0 ctermbg=3
"highlight PmenuSel ctermfg=0 ctermbg=7
"if &bg == "dark"
"	highlight MatchParen ctermbg=darkblue guibg=blue
"endif


""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Files, backups, and undo
""""""""""""""""""""""""""""""""""""""""""""""""""""""

"Turn backup off, since most stuff is rev control anyways
set nobackup
set nowb
set noswapfile

"Persistent undo
try
	set undodir=~/.vim/undodir
	set undofile
catch
endtry

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Text, tab and indent related
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set noet
set shiftwidth=8
set tabstop=8
set softtabstop=8
set smarttab

set lbr
set tw=80

set ai "Auto indent
set si "Smart indet
"set wrap "Wrap lines

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Moving around, tabs and buffers
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"Map Leader to something good
"let mapleader = 

" Map space to / (search) and c-space to ? (backwards search)
map <space> /
map <c-space> ?
map <silent> <leader><cr> :noh<cr>

" Smart way to move btw. windows
map <C-j> <C-W>j
map <C-k> <C-W>k
map <C-h> <C-W>h
map <C-l> <C-W>l

" Close the current buffer
map <leader>bd :Bclose<cr>

" Close all the buffers
map <leader>ba :1,300 bd!<cr>

" Use the arrows to something usefull
map <C-right> :tabn<cr>
map <C-left> :tabp<cr>

" Tab configuration
map <leader>tn :tabnew<cr>
map <leader>te :tabedit
map <leader>tc :tabclose<cr>
map <leader>tm :tabmove

" When pressing <leader>cd switch to the directory of the open buffer
map <leader>cd :cd %:p:h<cr>


command! Bclose call <SID>BufcloseCloseIt()
function! <SID>BufcloseCloseIt()
	let l:currentBufNum = bufnr("%")
	let l:alternateBufNum = bufnr("#")

	if buflisted(l:alternateBufNum)
		buffer #
	else
		bnext
	endif

	if bufnr("%") == l:currentBufNum
		new
	endif

	if buflisted(l:currentBufNum)
		execute("bdelete! ".l:currentBufNum)
	endif
endfunction

" Specify the behavior when switching between buffers 
try
	set switchbuf=usetab
	set stal=2
catch
endtry

""""""""""""""""""""""""""""""
" => Statusline
""""""""""""""""""""""""""""""
" Always hide the statusline
set laststatus=2

" Format the statusline
set statusline=\ %{HasPaste()}%F%m%r%h\ %w\ \ CWD:\ %r%{CurDir()}%h\ \ \ Line:\ %l/%L:%c


function! CurDir()
	let curdir = substitute(getcwd(), '/Users/ryancm/', "~/", "g")
	return curdir
endfunction

function! HasPaste()
	if &paste
		return 'PASTE MODE  '
	else
		return ''
	endif
endfunction

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Parenthesis/bracket expanding
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
vnoremap $1 <esc>`>a)<esc>`<i(<esc>
vnoremap $2 <esc>`>a]<esc>`<i[<esc>
vnoremap $3 <esc>`>a}<esc>`<i{<esc>
vnoremap $$ <esc>`>a"<esc>`<i"<esc>
vnoremap $q <esc>`>a'<esc>`<i'<esc>
vnoremap $e <esc>`>a"<esc>`<i"<esc>

" Map auto complete of (, ", ', [
inoremap $1 ()<esc>i
inoremap $2 []<esc>i
inoremap $3 {}<esc>i
inoremap $4 {<esc>o}<esc>O
inoremap $q ''<esc>i
inoremap $e ""<esc>i
inoremap $t <><esc>i

"Delete trailing white space, useful for Python ;)
func! DeleteTrailingWS()
	exe "normal mz"
	%s/\s\+$//ge
	exe "normal `z"
endfunc
autocmd BufWrite *.py :call DeleteTrailingWS()

set guitablabel=%t

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Cope
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Do :help cope if you are unsure what cope is. It's super useful!
map <leader>cc :botright cope<cr>
map <leader>n :cn<cr>
map <leader>p :cp<cr>

""""""""""""""""""""""""""""""
" => Python section
""""""""""""""""""""""""""""""
let python_highlight_all = 1
au FileType python syn keyword pythonDecorator True None False self

au BufNewFile,BufRead *.jinja set syntax=htmljinja
au BufNewFile,BufRead *.mako set ft=mako

au FileType python inoremap <buffer> $r return
au FileType python inoremap <buffer> $i import
au FileType python inoremap <buffer> $p print
au FileType python inoremap <buffer> $f #--- PH ----------------------------------------------<esc>FP2xi
au FileType python map <buffer> <leader>1 /class
au FileType python map <buffer> <leader>2 /def
au FileType python map <buffer> <leader>C ?class
au FileType python map <buffer> <leader>D ?def

""""""""""
" => MIST
"""""""""
" Remove the Windows ^M - when the encodings gets messed up
noremap <Leader>m mmHmt:%s/<C-V><cr>//ge<cr>'tzt'm

"Quickly open a buffer for scripbble
map <leader>q :e ~/buffer<cr>
au BufRead,BufNewFile ~/buffer iab <buffer> xh1 ===========================================

map <leader>pp :setlocal paste!<cr>

map <leader>bb :cd ..<cr>



""""""""""""MY STUFF
set nowrap
"ignore case unless capitals are present
"ignore these file endings when completing names
set wildignore=.svn,CVS,.git,*.o,*.a,*.swp,*.obj,*.jpg,*.png,*.gif,*.bmp

"display line numbers
set number

"turn off expandnig tabs for makefiles
autocmd BufEnter Makefile set noet ts=8 sw=8

autocmd! BufNewFile * silent! 0r ~/.vim/templates/tmp1.%:e

nmap <F1> :echo<CR>
imap <F1> <C-o>:echo<CR>

""""""""""""""""""""""""""""
" => LaTeX Section
""""""""""""""""""""""""""""

let g:tex_flavor = "latex"

au FileType tex set tw=80
au FileType tex set spell
