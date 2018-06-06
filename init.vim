set nocompatible              " be iMproved, required
filetype off                  " required

imap jk <Esc>
imap kj <Esc>
nnoremap ; :

set path+=**
set wildmenu                " display all matching files when we tab complete

set ignorecase
set smartcase

" mixed feelings about this maps, I invented them and they work 4 me but
" remapping c-z? c'mon...
nnoremap <c-x> :bnext<CR>
nnoremap <c-z> :bprevious<CR>

" leader maps
let mapleader = "\<Space>"
map <leader>o :echo expand("%:p") <CR>
nnoremap <leader>z ^
nnoremap <leader>w :vertical resize 100<CR>
map <leader>s <C-w><C-w>
map <leader>c :noh <CR>
nnoremap <leader>g *<C-O>:%s///gn<CR>
noremap <leader>f :Ag! "<cword>"<cr>

" If you don't use return to navigate in normal mode, you can remap two returns to insert a new line
nnoremap <CR><CR> o<Esc>

" vanilla snippets!
nnoremap <leader>Sr :-1read $HOME/.config/nvim/snippets/symfony-route.yaml<CR>

" open new split panes to right and bottom, which feels more natural than Vim’s default
set splitbelow
set splitright

" tag file I usually have in main dir of project
" ok this is default in nvim I guess
set tags=./tags;

" use only spaces to indent, 2 spaces per level
set expandtab    " replace tabs with spaces
set tabstop=2    " how many columns a tab counts for
set shiftwidth=2 " control how many columns text is indented with

" Tweaks for browsing
let g:netrw_banner=0       " disable annoying banner
let g:netrw_browse_split=4 " open in prior window
let g:netrw_altv=1         " open splits to the right
let g:netrw_liststyle=3    " tree view
" Per default, netrw leaves unmodified buffers open. This autocommand
" deletes netrw's buffer once it's hidden (using ':q', for example)
autocmd FileType netrw setl bufhidden=delete

set clipboard=unnamed

syntax on
set encoding=utf-8
set backspace=2
set showcmd                 " display incomplete commands
set number
set laststatus=2
set hidden " keep files (buffers) open but dont display them
set autoread
set hlsearch                " highlight searched text
set incsearch               " do incremental searching
set noswapfile
set ruler                   " show the cursor position all the time
set autoindent
set smarttab
set si "smart indent"
set showtabline=2

set visualbell
set undolevels=9999999
set history=2000
set lazyredraw
"numbers
noremap <F2> :set number!<CR>
noremap <F3> :set relativenumber!<CR>

" stop arrow keys from typing A B C D
map ^[OA <up>
map ^[OB <Down>
map ^[OD <left>
map ^[OC <right>

map <C-\> :tab split<CR>:exec("tag ".expand("<cword>"))<CR>
map <A-]> :vsp <CR>:exec("tag ".expand("<cword>"))<CR>

" PLUGINS
call plug#begin()
" base
Plug 'itchyny/lightline.vim'
Plug 'ap/vim-buftabline'
Plug 'vim-utils/vim-interruptless'
Plug 'sheerun/vim-polyglot'
Plug 'osyo-manga/vim-brightest'
Plug 'cloudhead/neovim-fuzzy'
Plug 'kien/rainbow_parentheses.vim'
Plug 'tpope/vim-commentary'
Plug 'jrosiek/vim-mark'
Plug 'ludovicchabant/vim-gutentags'
Plug 'kshenoy/vim-signature'

Plug 'dyng/ctrlsf.vim'
Plug 'w0rp/ale'
" for learning vim
Plug 'unblevable/quick-scope'
Plug 'takac/vim-hardtime'

" filesystem
Plug 'justinmk/vim-dirvish'

" c/cpp
Plug 'octol/vim-cpp-enhanced-highlight'
" webdev
Plug 'StanAngeloff/php.vim'
Plug 'qbbr/vim-symfony'
Plug 'nelsyeung/twig.vim'
" colorschemes:
Plug 'ympek/happy_hacking.vim'
Plug 'fcpg/vim-fahrenheit'
Plug 'terryma/vim-smooth-scroll'
call plug#end()

" regarding quick-scope plugin:
augroup qs_colors
  autocmd!
  autocmd ColorScheme * highlight QuickScopePrimary ctermfg=155 cterm=underline
  autocmd ColorScheme * highlight QuickScopeSecondary ctermfg=81 cterm=underline
augroup END

" look and feel
colorscheme happy_hacking
let g:lightline = { 'colorscheme': 'fahrenheit', }
set cursorline
hi CursorLine cterm=NONE ctermbg=234
set colorcolumn=120
hi ColorColumn cterm=NONE ctermbg=239
hi BufTabLineCurrent ctermfg=047
hi BufTabLineActive ctermfg=023


nmap <leader>p :RainbowParenthesesToggleAll<CR>
au Syntax * RainbowParenthesesLoadRound
au Syntax * RainbowParenthesesLoadSquare
au Syntax * RainbowParenthesesLoadBraces

let g:rbpt_colorpairs = [
    \ ['brown',       'RoyalBlue3'],
    \ ['darkgray',    'DarkOrchid3'],
    \ ['darkgreen',   'firebrick3'],
    \ ['darkcyan',    'RoyalBlue3'],
    \ ['darkred',     'SeaGreen3'],
    \ ['darkmagenta', 'DarkOrchid3'],
    \ ['brown',       'firebrick3'],
    \ ['gray',        'RoyalBlue3'],
    \ ['black',       'SeaGreen3'],
    \ ['darkmagenta', 'DarkOrchid3'],
    \ ['Darkblue',    'firebrick3'],
    \ ['darkgreen',   'RoyalBlue3'],
    \ ['darkcyan',    'SeaGreen3'],
    \ ['darkred',     'DarkOrchid3'],
    \ ['red',         'firebrick3'],
    \ ]

nnoremap <C-p> :FuzzyOpen<CR>
if !has('gui_running')
  set t_Co=256
endif


" rename variable/fun etc in file
nnoremap <silent><leader>R :%s/\<<c-r><c-w>\>//gI<c-f>$F/i

" toggle between cpp and hpp file
function! OpenOther()
    if expand("%:e") == "cpp"
        exe "edit" fnameescape(expand("%:p:r:s?src?include?").".hpp")
    elseif expand("%:e") == "hpp"
        exe "edit" fnameescape(expand("%:p:r:s?include?src?").".cpp")
    endif
endfunction
nmap <leader>a :call OpenOther()<CR>


"remember the line I was on when I reopen a file
autocmd BufReadPost *
      \ if line("'\"") > 0 && line("'\"") <= line("$") |
      \ exe "normal! g`\"" |
      \ endif

let g:netrw_sort_by='time'
let g:netrw_sort_direction='reverse'
let g:argwrap_line_prefix = ''

" highlight ExtraWhitespace at end of line, remove them at save buffer ######################
highlight ExtraWhitespace ctermbg=red guibg=red
match ExtraWhitespace /\s\+$/
autocmd BufWinEnter * match ExtraWhitespace /\s\+$/
autocmd InsertEnter * match ExtraWhitespace /\s\+\%#\@<!$/
autocmd InsertLeave * match ExtraWhitespace /\s\+$/
autocmd BufWinLeave * call clearmatches()

" remove unwanted whitespace from file
nnoremap <leader>t :%s/\s\+$//e<CR>

noremap <silent> <c-u> :call smooth_scroll#up(&scroll, 0, 2)<CR>
noremap <silent> <c-d> :call smooth_scroll#down(&scroll, 0, 2)<CR>


nmap     <C-F>f <Plug>CtrlSFPrompt
vmap     <C-F>f <Plug>CtrlSFVwordPath
vmap     <C-F>F <Plug>CtrlSFVwordExec
nmap     <C-F>n <Plug>CtrlSFCwordPath
nmap     <C-F>p <Plug>CtrlSFPwordPath
nnoremap <C-F>o :CtrlSFOpen<CR>
nnoremap <C-F>t :CtrlSFToggle<CR>
inoremap <C-F>t <Esc>:CtrlSFToggle<CR>

