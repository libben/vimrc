" Set compatibility to vim only, if vi-compatible
if &compatible
    set nocompatible
endif

" If minpac is loaded
if exists('*minpac#init')
    call minpac#init()
    call minpac#add('k-takata/minpac', {'type': 'opt'})
    " Plugins
    call minpac#add('junegunn/fzf', {'do': {-> system('./install --all')}})
    call minpac#add('junegunn/fzf.vim')
    call minpac#add('itchyny/lightline.vim')
    call minpac#add('scrooloose/nerdtree')
    call minpac#add('morhetz/gruvbox')
    "call minpac#add('w0rp/ale')
endif

"Plugin settings
"Lightline already shows editing mode
set noshowmode
" Lightline has its own colorscheme
let g:lightline = { 'colorscheme': 'wombat' }
"Map nerdtree toggle to CTRL-n
map <C-n> :NERDTreeToggle<CR>
let g:gruvbox_contrast_dark='hard'
" somehow italics not working

" Helps force plug-ins to load correctly when it is turned back on below.
filetype off

" Turn on syntax highlighting.
syntax on

" For plug-ins to load correctly.
filetype plugin indent on

" Turn off modelines
set modelines=0

" Wrap text longer than screen
set wrap

" If wrapping, do it at 80 chars
set textwidth=80
" http://vimdoc.sourceforge.net/htmldoc/change.html#fo-table
set formatoptions=tcqrn
" Show tab as 8 spaces
set tabstop=4
" Autoindent 8 characters every level of indention
set shiftwidth=4
" When I hit tab, I want this amount of characters to appear
set softtabstop=4
" When I hit tab, I mean that many spaces
set expandtab
" When I hit < or >, don't round to nearest indent level
set noshiftround

" Display 7 lines above/below the cursor when scrolling with a mouse.
set scrolloff=7
" Allow backspace to be used in many circumstances (Fixes common backspace
" problems)
" http://vimdoc.sourceforge.net/htmldoc/options.html#'backspace'
set backspace=indent,eol,start

"Speedy scrolling (for local use of vim!)
set ttyfast

" Show status bar always
set laststatus=2

" Show 'partial commands' (how many lines/cols being selected in v mode)
set showcmd

" Highlight matching pairs of brackets. Use '%' char to jump between them.
set matchpairs+=<:>

" Show tabs as the CTRL-I character, show $ at EOL
set list
" Actually, show this at EOL, tabs as >\\\\\\\, trailing whitespace as •,
" overflowing unwrapped line as #, non-breakable space as .
set listchars=tab:>\ ,trail:•,extends:#,nbsp:.

" Show line numbers
set number

"Set status line display
"set statusline=\ %{HasPaste()}%F%m%r%h\ %w\ \ CWD:\ %r%{getcwd()}%h\ \ \ Line:\ %l\ \ Column:\ %c

"Encoding
set encoding=utf-8

"Highlight matching search patterns
set hlsearch
"Show where pattern, as typed so far, matches
set incsearch
" Include matching uppercase words with lowercase search term
set ignorecase
" Include only uppercase words with uppercase search term
set smartcase

" Store info from no more than 100 files at a time, 9999 lines of text, 100kb of
" data. 'Useful for copying large amounts of data between files.'
set viminfo='100,<9999,s100

" Auto-fold code
setlocal foldmethod=syntax

" Map the <Space> key to toggle a selected fold opened/closed.
nnoremap <silent> <Space> @=(foldlevel('.')?'za':"\<Space>")<CR>
vnoremap <Space> zf

" Automatically save and load folds
autocmd BufWinLeave *.* mkview
autocmd BufWinEnter *.* silent loadview"

" Use ; for :
map ; :
" Use ;; for actual ;
noremap ;; ;

" auto-read any file when it's changed outside vim
set autoread

" enhanced command line completion (show menu guessing what you mean)
set wildmenu
" Don't search compiled or version control files
set wildignore=*.o,*~,*.pyc,*/.git/*,*/.hg/*,*/.svn/*,*/.DS_Store

" Show row/col, relative pos in doc
set ruler

" Show matching brackets when text indicator is over them
set showmatch
" How many tenths of a second to blink when matching brackets
set mat=2

" No annoying sound on errors
set noerrorbells
set novisualbell
set t_vb=
set tm=500

" Properly disable sound on errors on MacVim
if has("gui_macvim")
    autocmd GUIEnter * set vb t_vb=
endif

" Enable 256 color palette in Gnome terminal
if $COLORTERM == 'gnome-terminal'
    set t_Co=256
endif

" 24-bit true-color on many terminals https://gist.github.com/XVilka/8346728
set termguicolors

" Try to set a color scheme
try
    colorscheme wombat
    set background=dark
    "highlight Normal ctermbg=none
catch
endtry


" Use Unix end-of-lines as standard
set ffs=unix,dos,mac

" Move btwn windows with ctrl-hjkl
map <C-j> <C-W>j
map <C-k> <C-W>k
map <C-h> <C-W>h
map <C-l> <C-W>l

" Go to open windows/tabs when looking for a buffer
" Only show tab line when 2+ tabs
try
    set switchbuf=useopen,usetab,newtab
    set stal=1
catch
endtry

" Return to last edit position when opening files (You want this!)
au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif

" HELPER FUNCS
" Returns true if paste mode is enabled
function! HasPaste()
    if &paste
        return 'PASTE MODE  '
    endif
    return ''
endfunction

" Define user commands for updating/cleaning the plugins.
" Each of them loads minpac, reloads .vimrc to register the
" information of plugins, then performs the task.
command! PackUpdate packadd minpac | source $MYVIMRC | call minpac#update('', {'do': 'call minpac#status()'})
command! PackClean  packadd minpac | source $MYVIMRC | call minpac#clean()
command! PackStatus packadd minpac | source $MYVIMRC | call minpac#status()
