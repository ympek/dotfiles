" vimrc vanilla part
imap jk <Esc>
imap kj <Esc>
nnoremap ; :

nnoremap <c-x> :bnext<CR>
nnoremap <c-z> :bprevious<CR>

" switching between splits
nnoremap sw <C-w><C-k>
nnoremap ss <C-w><C-j>
nnoremap sa <C-w><C-h>
nnoremap sd <C-w><C-l>

if exists('$TMUX')
  " Colors in tmux
  let &t_8f = "<Esc>[38;2;%lu;%lu;%lum"
  let &t_8b = "<Esc>[48;2;%lu;%lu;%lum"
endif

set termguicolors
set background=dark

set nonumber
set path+=**
set wildmenu
set ignorecase
set smartcase

set nobackup
set nowritebackup
" i dont really want it
" set cmdheight=2
set updatetime=300
set shortmess+=c

" better visible line break
set showbreak=>

" open new split panes to right and bottom
set splitbelow
set splitright

" use only spaces to indent, 2 spaces per level
set expandtab    " replace tabs with spaces
set tabstop=2    " how many columns a tab counts for
set shiftwidth=2 " control how many columns text is indented with

" YOU NOT ALWAYS MIGHT WANT THIS, but
" it helps with this_particular_function_name_convention
" set iskeyword-=_

" Tweaks for browsing
let g:netrw_banner=0       " disable annoying banner
let g:netrw_browse_split=4 " open in prior window
let g:netrw_altv=1         " open splits to the right
let g:netrw_liststyle=3    " tree view
let g:netrw_winsize = 25
" Per default, netrw leaves unmodified buffers open. This autocommand
" deletes netrw's buffer once it's hidden (using ':q', for example)
autocmd FileType netrw setl bufhidden=delete

set clipboard=unnamedplus

syntax on
set backspace=2
set showcmd                 " display incomplete commands
set laststatus=2
set hidden " keep files (buffers) open but dont display them
" set autoread ( i dont like autoread that much )
set hlsearch                " highlight searched text
set incsearch               " do incremental searching
set noswapfile
set ruler                   " show the cursor position all the time
set autoindent
set smarttab
set si "smart indent"
set showtabline=2
set visualbell
set history=2000
set lazyredraw
set signcolumn=yes
set cursorline
set colorcolumn=120

noremap <F3> :set relativenumber!<CR>
noremap <F2> :set number!<CR>

" use hjkl my friend
map <up> <nop>
map <down> <nop>
map <left> <nop>
map <right> <nop>
" annoying on thinkpad
map <PageDown> <Nop>
map <PageUp> <Nop>
map <CapsLock> <Nop>

if !has('gui_running')
  set t_Co=256
endif

"remember the line I was on when I reopen a file
autocmd BufReadPost *
      \ if line("'\"") > 0 && line("'\"") <= line("$") |
      \ exe "normal! g`\"" |
      \ endif

" highlight ExtraWhitespace at end of line, remove them at save buffer ######################
highlight ExtraWhitespace ctermbg=red guibg=red
match ExtraWhitespace /\s\+$/
" autocmd BufWinEnter * match ExtraWhitespace /\s\+$/
" (added: dont do it in CtrlSF cuz ugly )
autocmd InsertEnter * match ExtraWhitespace /\s\+\%#\@<!$/
autocmd InsertLeave * match ExtraWhitespace /\s\+$/
autocmd BufWinLeave * call clearmatches()

" neovim 4.0 has floating wildmenu. I don't really love it.
set wildoptions-=pum

" ok, tab is superior to inconvienient vim defaults when dealing with completion.
inoremap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<Tab>"

" search for visually selected text LITERALLY
vnoremap // y/\V<C-r>=escape(@",'/\')<CR><CR>
" search for visually selected text as regex
" vnoremap // y/<C-R>"<CR>

function! ToggleMouse()
  if &mouse == 'a'
    set mouse=
  else
    set mouse=a
  endif
endfunc

function! SaveAndPrintFilepath()
  let @p=expand("%:p")
  echo @p
endfunc

" leader maps - vanilla
let mapleader = "\<Space>"
map <leader>q :call ToggleMouse()<CR>
nmap <leader>o :call SaveAndPrintFilepath()<CR>
map <leader>c :noh<CR>
nnoremap <leader>w :vertical resize 160<CR>
nnoremap <leader>l :set wrap!<CR>
map <leader>s <C-w><C-w>
" rename variable/fun etc in file
nnoremap <silent><leader>R :%s/\<<c-r><c-w>\>//gI<c-f>$F/i
" list all GLOBAL MARKS
nmap <leader>m :marks QWERTYUIOPASDFGHJKLZXCVBNM<CR>
" vanilla snippets!
" nnoremap <leader>Sr :-1read $HOME/.config/nvim/snippets/symfony-route.yaml<CR>
map <A-]> :vsp <CR>:exec("tag ".expand("<cword>"))<CR>

runtime plugins.vim
