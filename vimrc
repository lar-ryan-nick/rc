set nocompatible

let g:terminalHeight = 10

filetype off
" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'
" Install plugin for fugitive (git wrapper plugin)
Plugin 'tpope/vim-fugitive'
" Install plugin for NERDTree (directory viewer
"Plugin 'scrooloose/nerdtree'
" Install plugin for airline and it's themes
Plugin 'vim-airline/vim-airline'
Plugin 'vim-airline/vim-airline-themes'
" Install syntax highlighting for glsl
Plugin 'tikhomirov/vim-glsl'
" Markdown Renderer
Plugin 'iamcco/markdown-preview.nvim'
" All of your Plugins must be added before the following line
call vundle#end()
filetype plugin indent on

function TerminalInTab()
	return exists("g:terminalBufName") && bufwinnr(g:terminalBufName) != -1
endfunction

"function NERDTreeInTab()
"	return exists("t:NERDTreeBufName") && bufwinnr(t:NERDTreeBufName) != -1
"endfunction

function OpenTerminal()
	if !TerminalInTab()
		if exists("g:terminalBufName")
			exe 'below sb' g:terminalBufName
			exe 'resize' g:terminalHeight
			wincmd k
		else	
			exe 'below terminal ++close ++rows=' . g:terminalHeight 'bash'
			let g:terminalBufName = bufname(winnr())
			wincmd k
		endif
	endif
endfunction

"function OpenNERDTree(...)
"	if !NERDTreeInTab()
"		if a:0 > 0
"			exe 'NERDTreeToggle' fnamemodify(a:1, ':p:h')
"		elseif exists("t:NERDTreeBufName")
"			NERDTreeToggle
"		else
"			NERDTreeMirror
"		endif
"		wincmd l
"	endif
"endfunction

" Close terminal if only buffer left in tab
" Or if only left with NERDTree
function AutoCloseTerminal()
	if TerminalInTab()
		if winnr('$') == 2 && NERDTreeInTab()
			exe bufwinnr(g:terminalBufName) . 'wincmd w'
			q!
		elseif winnr('$') == 1
			q!
		endif
	endif
endfunction

" Close NERDTree if only buffer left in tab
"function AutoCloseNERDTree()
"	if winnr('$') == 1 && NERDTreeInTab()
"		q
"	endif
"endfunction

augroup bash
	autocmd!
	autocmd VimEnter * call OpenTerminal()
	autocmd TabEnter * call OpenTerminal()
	autocmd BufEnter * call AutoCloseTerminal()
augroup END

"augroup NERDTree
"	autocmd!
"	autocmd VimEnter * if argc() > 0 | call OpenNERDTree(argv()[0]) | else | call OpenNERDTree() | endif
"	autocmd TabEnter * call OpenNERDTree()
"	autocmd BufEnter * call AutoCloseNERDTree()
"augroup END

" let netrw_banner = 0
" let netrw_liststyle = 3
" let netrw_browse_split = 4
" let netrw_altv = 1
" let netrw_winsize = -30
" " Hide hidden files on default
" let ghregex = '\(^\|\s\s\)\zs\.\S\+'
" let netrw_list_hide = ghregex
" augroup netrw
" 	autocmd!
"  	autocmd StdinReadPre * let s:std_in=1
"  	autocmd VimEnter * if argc() == 1 && !exists("s:std_in") | exe 'Lexplore' fnamemodify(argv()[0], ':p:h') | else | Lexplore | endif | wincmd l
" 	autocmd BufEnter * if winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree() | q | endif
" augroup END

" airline config options
let airline_theme = 'dark'
let airline_powerline_fonts = 1
let airline_highlighting_cache = 1
let airline_inactive_collapse = 0
let airline_filetype_overrides = {'nerdtree': ['NERDTree', ''], 'netrw': ['netrw', '']}
let airline#extensions#tabline#enabled = 1

let NERDTreeMinimalUI = 1
let NERDTreeWinSize = 15

"let g:mkdp_path_to_chrome = "open -a Google\\ Chrome"
"let g:mkdp_path_to_chrome = "/Applications/Google\\ Chrome.app/Contents/MacOS/Google\\ Chrome"

"Set up persistent undo
set undodir=~/.vim/undo
set undofile
" Setup search highlightin
set hlsearch
set background=dark
set incsearch
nnoremap <Leader>cs :let @/ = ''<CR>
set showcmd
set encoding=utf-8
set backspace=indent,eol,start
set tabstop=2
set shiftwidth=2
set number
set mouse=a
set backupcopy=yes
syntax on
