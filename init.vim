set nocompatible              " be iMproved, required
filetype off                  " required

"set completeopt=menu,menuone,preview,noselect,noinsert

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

" better visible line break
set showbreak=>

" open new split panes to right and bottom, which feels more natural than VimÃ¢â‚¬â„¢s default
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
" base/fav/superUseful
Plug 'itchyny/lightline.vim'
Plug 'tpope/vim-fugitive'
Plug 'ap/vim-buftabline'
Plug 'vim-utils/vim-interruptless'
Plug 'osyo-manga/vim-brightest'
Plug 'kshenoy/vim-signature'
Plug 'google/vim-searchindex'
Plug 'dyng/ctrlsf.vim'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
Plug 'tpope/vim-commentary'
Plug 'takac/vim-hardtime'
Plug 'justinmk/vim-dirvish'
Plug 'vim-scripts/taglist.vim'
Plug 'tpope/vim-surround'
Plug 'neoclide/coc.nvim', { 'do': 'yarn install' }

" c/cpp
Plug 'octol/vim-cpp-enhanced-highlight'
Plug 'vim-scripts/a.vim'

if $YMPEK_HOME
  Plug 'sheerun/vim-polyglot'
  Plug 'alvan/vim-closetag'
  Plug 'othree/html5.vim'
  Plug 'pangloss/vim-javascript'
  Plug 'mxw/vim-jsx'
  Plug 'ympek/gruvbox'
else
  Plug 'lyuts/vim-rtags'
endif

" colorschemes:
Plug 'ympek/happy_hacking.vim'
Plug 'fcpg/vim-fahrenheit'

Plug 'tweekmonster/startuptime.vim'

call plug#end()

let g:buftabline_indicators=1

" look and feel
if $YMPEK_HOME
  set termguicolors
  let g:gruvbox_contrast_dark='hard'
  let g:gruvbox_sign_column='bg0'
  let g:gruvbox_bold=0
  silent! colorscheme gruvbox
else
  silent! colorscheme happy_hacking
  let g:hardtime_default_on = 1
endif

function! LightlineFilename()
  let root = fnamemodify(get(b:, 'git_dir'), ':h')
  let path = expand('%:p')
  if path[:len(root)-1] ==# root
    return path[len(root)+1:]
  endif
  return expand('%')
endfunction

fun! ShowFuncName()
  return getline(search("^[^ \t#/]\\{2}.*[^:]\s*$", 'bWn'))
endfun
let g:lightline = {
      \ 'colorscheme': 'fahrenheit',
      \ 'active': {
      \   'left': [ [ 'mode', 'paste' ],
      \             [ 'gitbranch', 'readonly', 'filename', 'modified', 'hello', 'cocstatus' ] ],
      \
      \   'right': [ [ 'lineinfo' ],
      \              [ 'funcname' ] ],
      \ },
      \ 'component': {
      \   'hello': 'gl&hf'
      \ },
      \ 'component_function': {
      \   'gitbranch': 'FugitiveStatusline',
      \   'filename': 'LightlineFilename',
      \   'cocstatus': 'coc#status',
      \   'funcname': 'ShowFuncName'
      \ },
      \ }
set cursorline
hi CursorLine cterm=NONE ctermbg=234
set colorcolumn=120
hi BufTabLineCurrent ctermfg=047
hi BufTabLineActive ctermfg=023

nnoremap <C-p> :Files<CR>

if !has('gui_running')
  set t_Co=256
endif

" fix annoying vim-commentary /* */
autocmd FileType c,hpp,cpp,cs,java setlocal commentstring=//\ %s

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
" nnoremap <leader>b :BuffergatorToggle<CR>
" let g:buffergator_sort_regime='mru'
" let g:buffergator_autoupdate=1

" remove insert mode maps which a.vim adds (i dont like them)
autocmd VimEnter * iunmap <Leader>ihn
autocmd VimEnter * iunmap <Leader>ih
autocmd VimEnter * iunmap <Leader>is

" hitting it too much when using CtrlSF so unmap this
noremap <C-F> <Nop>

let g:cpp_experimental_template_highlight = 1

" leader maps
let mapleader = "\<Space>"
nmap <leader>a :A<CR>
map <leader>c :noh <CR>
nmap <leader>o :echo expand("%:p") <CR>
nnoremap <leader>w :vertical resize 100<CR>
map <leader>s <C-w><C-w>
nnoremap <leader>g *<C-O>:%s///gn<CR>

" rename variable/fun etc in file
nnoremap <silent><leader>R :%s/\<<c-r><c-w>\>//gI<c-f>$F/i

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
map <leader>h :silent! 0Glog -10<CR>:bot copen<CR>0f.3w
" git show hash under cursor :))
map <leader>gs "gyiw:Git show <C-r>g<CR>
" uhhh
map <leader>bd :bp\|bd!<CR>

" kinda messes up in fuzzyfinding.... bcuz it's termbuffer.
" to be fixed.
tnoremap qq <C-\><C-n>:bd!<CR>
tnoremap jk <C-\><C-n>
tnoremap kj <C-\><C-n>

" stop fugitive from polluting my buffer list
autocmd BufReadPost fugitive://* set bufhidden=delete

" let g:ale_linters = {
" \   'cpp': ['ccls'],
" \}

nmap <leader>d <Plug>(coc-definition)
nmap <leader>n <Plug>(coc-references)
nn <silent> K :call CocActionAsync('doHover')<cr>

" webdev again
let g:html_indent_script1 = "inc" 
let g:html_indent_style1 = "inc" 

" annoying on thinkpad
map <PageDown> <Nop>
map <PageUp> <Nop>
map <CapsLock> <Nop>

" ok, tab is superior to inconvienient vim defaults when dealing with completion.
inoremap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<Tab>"
