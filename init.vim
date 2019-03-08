set nocompatible              " be iMproved, required
filetype off                  " required

imap jk <Esc>
imap kj <Esc>
nnoremap ; :
" mixed feelings about this maps, I invented them and they work 4 me but
" remapping c-z? c'mon...
nnoremap <c-x> :bnext<CR>
nnoremap <c-z> :bprevious<CR>

set path+=**
set wildmenu                " display all matching files when we tab complete
set ignorecase
set smartcase

" open new split panes to right and bottom, which feels more natural than Vimâ€™s default
set splitbelow
set splitright

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
set history=2000
set lazyredraw

noremap <F3> :set relativenumber!<CR>

" NOTE: wyglada na to ze to wycina tez scrolla, tzn
" scrollowanie uzywalo up/downetc pod spodem.
" mouse=a zeby scrollowac teraz.
map <up> <nop>
map <Down> <nop>
map <left> <nop>
map <right> <nop>

map <A-]> :vsp <CR>:exec("tag ".expand("<cword>"))<CR>

" PLUGINS
call plug#begin()
" base
Plug 'itchyny/lightline.vim'
Plug 'tpope/vim-fugitive'
Plug 'ap/vim-buftabline'
Plug 'vim-utils/vim-interruptless'
" this is rather heavy plugin, comment this out
" Plug 'sheerun/vim-polyglot'
Plug 'osyo-manga/vim-brightest'
Plug 'cloudhead/neovim-fuzzy'
Plug 'tpope/vim-commentary'
Plug 'mbbill/undotree'
" Plug 'ludovicchabant/vim-gutentags'
Plug 'kshenoy/vim-signature'

Plug 'dyng/ctrlsf.vim'
Plug 'w0rp/ale'
" for learning vim
" Plug 'unblevable/quick-scope'
" Plug 'takac/vim-hardtime'

" I can live without this one, I suppose. It's on way out.
Plug 'jeetsukumaran/vim-buffergator'

" testing new stuff
" really fun, but heavy, I guess/.
Plug 'vim-scripts/taglist.vim'
Plug 'tpope/vim-surround'

" filesystem
" i dont use this one, TODO check if useful
" after some juggling it's kinda OK, sometimes sluggish but....
Plug 'justinmk/vim-dirvish'

" c/cpp
Plug 'octol/vim-cpp-enhanced-highlight'
Plug 'vim-scripts/a.vim'

" webdev
" Plug 'StanAngeloff/php.vim'
" Plug 'qbbr/vim-symfony'
" Plug 'nelsyeung/twig.vim'
" colorschemes:
Plug 'ympek/happy_hacking.vim'
Plug 'fcpg/vim-fahrenheit'
Plug 'beikome/cosme.vim'

Plug 'tweekmonster/startuptime.vim'
call plug#end()

" regarding quick-scope plugin:
augroup qs_colors
  autocmd!
  autocmd ColorScheme * highlight QuickScopePrimary ctermfg=155 cterm=underline
  autocmd ColorScheme * highlight QuickScopeSecondary ctermfg=81 cterm=underline
augroup END

" look and feel
silent! colorscheme happy_hacking

function! LightlineFilename()
  let root = fnamemodify(get(b:, 'git_dir'), ':h')
  let path = expand('%:p')
  if path[:len(root)-1] ==# root
    return path[len(root)+1:]
  endif
  return expand('%')
endfunction

let g:lightline = {
      \ 'colorscheme': 'fahrenheit',
      \ 'active': {
      \   'left': [ [ 'mode', 'paste' ],
      \             [ 'gitbranch', 'readonly', 'filename', 'modified', 'hello' ] ]
      \ },
      \ 'component': {
      \   'hello': 'gl&hf'
      \ },
      \ 'component_function': {
      \   'gitbranch': 'FugitiveStatusline',
      \   'filename': 'LightlineFilename',
      \ },
      \ }
set cursorline
hi CursorLine cterm=NONE ctermbg=234
set colorcolumn=120
hi BufTabLineCurrent ctermfg=047
hi BufTabLineActive ctermfg=023

nnoremap <C-p> :FuzzyOpen<CR>

if !has('gui_running')
  set t_Co=256
endif

" do plikow linkera se zrobilem
autocmd BufRead *.lcf set syntax=ld

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
" autocmd BufWinEnter * match ExtraWhitespace /\s\+$/
" (added: dont do it in CtrlSF cuz ugly )
autocmd InsertEnter * match ExtraWhitespace /\s\+\%#\@<!$/
autocmd InsertLeave * match ExtraWhitespace /\s\+$/
autocmd BufWinLeave * call clearmatches()

" remove unwanted whitespace from file
nnoremap <leader>t :%s/\s\+$//e<CR>

nmap     <C-F>f <Plug>CtrlSFPrompt
vmap     <C-F>f <Plug>CtrlSFVwordPath
vmap     <C-F>F <Plug>CtrlSFVwordExec
nmap     <C-F>n <Plug>CtrlSFCwordPath
nmap     <C-F>p <Plug>CtrlSFPwordPath
nnoremap <C-F>o :CtrlSFOpen<CR>
nnoremap <C-F>t :CtrlSFToggle<CR>
inoremap <C-F>t <Esc>:CtrlSFToggle<CR>

let g:ctrlsf_auto_close = {
    \ "normal" : 0,
    \ "compact": 0
    \}

let g:ctrlsf_auto_focus = {
    \ "at": "start"
    \ }

" use my own ignore file instead of our repo's gitignore.
let g:ctrlsf_extra_backend_args = {
    \ 'ag': '-p ~/.my_ignore -U'
    \ }

" persistent undo
if !isdirectory($HOME."/.config/nvim/undodir")
    call mkdir($HOME."/.config/nvim/undodir", "p")
endif

set undodir=~/.config/nvim/undodir
set undofile
set undolevels=99999 "maximum number of changes that can be undone
set undoreload=10000 "maximum number lines to save for undo on a buffer reload

" search for visually selected text LITERALLY
vnoremap // y/\V<C-r>=escape(@",'/\')<CR><CR>
" search for visually selected text as regex
" vnoremap // y/<C-R>"<CR>

" vim-buffergator uses <leader>b to BuffergatorOpen, i would like use it for
" toggle.
nnoremap <leader>b :BuffergatorToggle<CR>
let g:buffergator_sort_regime='mru'
let g:buffergator_autoupdate=1

" remove insert mode maps which a.vim adds (i dont like them)
autocmd VimEnter * iunmap <Leader>ihn
autocmd VimEnter * iunmap <Leader>ih
autocmd VimEnter * iunmap <Leader>is

" hitting it too much when using CtrlSF so unmap this
noremap <C-F> <Nop>

let g:cpp_experimental_template_highlight = 1

" leader maps
let mapleader = "\<Space>"
map <leader>o :echo expand("%:p") <CR>
nnoremap <leader>w :vertical resize 100<CR>
map <leader>s <C-w><C-w>
map <leader>c :noh <CR>
nnoremap <leader>g *<C-O>:%s///gn<CR>

" rename variable/fun etc in file
nnoremap <silent><leader>R :%s/\<<c-r><c-w>\>//gI<c-f>$F/i

nmap <leader>a :A<CR>

" time to tweak marks usage
" list all GLOBAL MARKS
nmap <leader>m :marks QWERTYUIOPASDFGHJKLZXCVBNM<CR>

" tag list - testing new plugin
let Tlist_GainFocus_On_ToggleOpen = 1
let Tlist_WinWidth = 56
nmap <leader>k :Tlist<CR>

" vanilla snippets!
" nnoremap <leader>Sr :-1read $HOME/.config/nvim/snippets/symfony-route.yaml<CR>

function! ToggleMouse()
  if &mouse == 'a'
    set mouse=
  else
    set mouse=a
  endif
endfunc

map <leader>q :call ToggleMouse()<CR>
