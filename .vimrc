" Don't try to be vi compatible (must set first)
set nocompatible

" Don't wrap files
set nowrap

" Enhance command line completion
set wildmenu

" Set completion behavior, see :help wildmode for details
set wildmode=longest:full,list:full


" Blink cursor on error instead of beeping (grr)
set visualbell
set t_vb=

" Encoding
set encoding=utf-8

" no bom char
set nobomb

" Plugins essential
syntax on
filetype plugin indent on

" Autocomplétion intelligente
set omnifunc=syntaxcomplete#Complete

" Color
set cursorline

" For some stupid reason, vim requires the term to begin with "xterm", so the
" automatically detected "rxvt-unicode-256color" doesn't work.
set term=xterm-256color

let base16colorspace=256  " Access colors present in 256 colorspace"
set t_Co=256 " Explicitly tell vim that the terminal supports 256 colors"
set background=dark
colorscheme delek

" Show line number / columns
set ruler

" Write the file when we leave the buffer
set autowrite

" Reload a file when it is changed from the outside
set autoread

" Write the file when we leave the buffer
set autowrite

" Hide buffers instead of closing them
set hidden


" Disable swapfiles too
set noswapfile

" Color the column after textwidth, usually the 80th
"if version >= 703
"  set colorcolumn=+1
"endif

set fillchars=vert:│

" Make backspace behave as expected
set backspace=eol,indent,start

" Rendering
set ttyfast

" Tab and indent
set autoindent
set smartindent
set smarttab
set noexpandtab
set copyindent
set preserveindent
set softtabstop=0
set shiftwidth=4
set tabstop=4

" Allow mouse use in vim
set mouse=a

" Search
set hlsearch " Highlight all search result
hi Search ctermbg=LightYellow
hi Search ctermfg=Red

" Highlight matching brace
set showmatch

" Show last line
"set noshowmode
set showmode
set showcmd

" Always show status line
set laststatus=2

" Format the status line
" This status line comes from Pierre Bourdon's vimrc
"set statusline=%f\ %l\|%c\ %m%=%p%%\ (%Y%R)

" Enhance command line completion
set wildmenu

" Set completion behavior, see :help wildmode for details
set wildmode=longest:full,list:full

" Don't redraw while executing macros (performance config)
set lazyredraw

" Display extra whitespace
"set list listchars=tab:»·,trail:·,eol:¬,space:·,extends:>,precedes:<
set list listchars=tab:»─,trail:·,eol:¬,space:·,extends:>,precedes:<
set nolist

" Number of undo levels
set undolevels=1000

" Set how many history vim has to remember
set history=1000

" Ignore files vim doesnt use
set wildignore+=.git,.hg,.svn
set wildignore+=*.aux,*.out,*.toc
set wildignore+=*.o,*.obj,*.exe,*.dll,*.manifest,*.rbc,*.class
set wildignore+=*.ai,*.bmp,*.gif,*.ico,*.jpg,*.jpeg,*.png,*.psd,*.webp
set wildignore+=*.avi,*.divx,*.mp4,*.webm,*.mov,*.m2ts,*.mkv,*.vob,*.mpg,*.mpeg
set wildignore+=*.mp3,*.oga,*.ogg,*.wav,*.flac
set wildignore+=*.eot,*.otf,*.ttf,*.woff
set wildignore+=*.doc,*.pdf,*.cbr,*.cbz
set wildignore+=*.zip,*.tar.gz,*.tar.bz2,*.rar,*.tar.xz,*.kgb
set wildignore+=*.swp,.lock,.DS_Store,._*

""""""""""""""""""""""""""""""""""""""""""""""""""
" Mappings
""""""""""""""""""""""""""""""""""""""""""""""""""

" Set "," as map leader
let mapleader = ","

" Toggle paste mode
noremap <leader>pp :setlocal paste!<cr>

" Move between rows in wrapped lines
noremap j gj
noremap k gk

" Yank from cursor to end of line, to be consistent with C and D
nnoremap Y y$

" Write as root, when you forgot to sudoedit
cnoreabbrev w!! w !sudo tee % >/dev/null

" map ; to :
noremap ; :

" Open the quickfix window if there are errors, or close it if there are no
" errors left
noremap <leader>cw :botright :cw<cr>

" Run make silently, then skip the 'Press ENTER to continue'
noremap <leader>m :silent! :make! \| :redraw!<cr>

