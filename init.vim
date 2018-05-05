set nocompatible              " be iMproved, required
filetype off                  " required

" my two must-have remaps
imap jk <Esc>
nnoremap ; :

set path+=**
set wildmenu                " display all matching files when we tab complete

nnoremap <c-x> :bnext<CR>
nnoremap <c-z> :bprevious<CR>

" leader maps
let mapleader = "\<Space>"
map <leader>o :echo expand("%:p") <CR>
nnoremap <leader>z ^
nnoremap <leader>f :vertical resize 100<CR>
map <leader>s <C-w><C-w>
map <leader>c :noh <CR>
"
" open new split panes to right and bottom, which feels more natural than Vim’s default
set splitbelow
set splitright

set tags=./tags;
" use only spaces to indent, 2 spaces per level
set expandtab               " replace tabs with spaces
set tabstop=2               " how many columns a tab counts for
set shiftwidth=2           " control how many columns text is indented with

" Tweaks for browsing
let g:netrw_banner=0       " disable annoying banner
let g:netrw_browse_split=4 " open in prior window
let g:netrw_altv=1         " open splits to the right
let g:netrw_liststyle=3    " tree view
" Per default, netrw leaves unmodified buffers open. This autocommand
" deletes netrw's buffer once it's hidden (using ':q', for example)
autocmd FileType netrw setl bufhidden=delete

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

""Mappings
noremap <F2> :set number!<CR>
noremap <F3> :set relativenumber!<CR>

" stop arrow keys from typing A B C D
map ^[OA <up>
map ^[OB <Down>
map ^[OD <left>
map ^[OC <right>

map <C-\> :tab split<CR>:exec("tag ".expand("<cword>"))<CR>
map <A-]> :vsp <CR>:exec("tag ".expand("<cword>"))<CR>

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
Plug 'kshenoy/vim-signature'
" c/cpp
Plug 'octol/vim-cpp-enhanced-highlight'
" webdev
Plug 'qbbr/vim-symfony'
" colorschemes:
Plug 'YorickPeterse/happy_hacking.vim'
Plug 'fcpg/vim-fahrenheit'
call plug#end()

" look and feel
colorscheme happy_hacking
let g:lightline = { 'colorscheme': 'fahrenheit', }
set cursorline
hi CursorLine cterm=NONE ctermbg=234
set colorcolumn=120
hi ColorColumn cterm=NONE ctermbg=239
hi Search ctermfg=000 ctermbg=214

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
