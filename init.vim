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

set nonumber
set path+=**
set wildmenu
set ignorecase
set smartcase

" it's in my statusline!
set noshowmode

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

set clipboard=unnamed

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

let g:vimwiki_list = [{'path':'~/.vimwiki/wiki', 'path_html':'~/public_html/vimwiki/'}]

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
Plug 'justinmk/vim-dirvish'
Plug 'vim-scripts/taglist.vim'
Plug 'tpope/vim-surround'
Plug 'neoclide/coc.nvim', { 'do': 'yarn install' }

" c/cpp
Plug 'octol/vim-cpp-enhanced-highlight'
Plug 'vim-scripts/a.vim'

" web
" Plug 'sheerun/vim-polyglot'
Plug 'alvan/vim-closetag'
Plug 'othree/html5.vim'
" Plug 'pangloss/vim-javascript'
Plug 'mxw/vim-jsx'
Plug 'chrisbra/Colorizer'

" colorschemes:
Plug 'ympek/happy_hacking.vim'
Plug 'fcpg/vim-fahrenheit'
Plug 'cocopon/iceberg.vim'

Plug 'liuchengxu/vista.vim'
Plug 'tweekmonster/startuptime.vim'
" dont mess up my layout
Plug 'orlp/vim-bunlink'

" testing new stuff
Plug 'marcushwz/nvim-workbench'
Plug 'glts/vim-magnum'
Plug 'glts/vim-radical'
" Plug 'bfredl/nvim-miniyank'

call plug#end()

map <A-]> :vsp <CR>:exec("tag ".expand("<cword>"))<CR>

function! NearestMethodOrFunction() abort
  return get(b:, 'vista_nearest_method_or_function', '')
endfunction

" By default vista.vim never run if you don't call it explicitly.
"
" If you want to show the nearest function in your statusline automatically,
" you can add the following line to your vimrc
autocmd VimEnter * call vista#RunForNearestMethodOrFunction()

let g:buftabline_indicators=1

let g:closetag_filenames = '*.html,*.xhtml,*.phtml,*.php,*.html.twig,*.twig'

" silent! colorscheme happy_hacking
silent! colorscheme iceberg

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
      \ 'colorscheme': 'iceberg',
      \ 'active': {
      \   'left': [ [ 'mode', 'paste' ],
      \             [ 'gitbranch', 'readonly', 'filename', 'modified', 'hello', 'cocstatus' ] ],
      \
      \   'right': [ [ 'lineinfo' ],
      \              [ 'method' ] ],
      \ },
      \ 'component': {
      \   'hello': 'jedziesz'
      \ },
      \ 'component_function': {
      \   'gitbranch': 'FugitiveStatusline',
      \   'filename': 'LightlineFilename',
      \   'cocstatus': 'coc#status',
      \   'funcname': 'ShowFuncName',
      \   'method': 'NearestMethodOrFunction'
      \ },
      \ }
set cursorline
hi CursorLine cterm=NONE ctermbg=234
set colorcolumn=120
hi BufTabLineCurrent ctermfg=204
hi BufTabLineActive ctermfg=217
hi SignatureMarkText ctermfg=162
hi BrightestHl cterm=NONE ctermbg=239

" or GitFiles
nnoremap <C-p> :Files<CR>

let g:brightest#highlight = {
      \	"group"    : "BrightestHl",
      \}

if !has('gui_running')
  set t_Co=256
endif

" fix annoying vim-commentary /* */
autocmd FileType c,hpp,cpp,cs,java,php setlocal commentstring=//\ %s

" do plikow linkera se zrobilem
autocmd BufRead *.lcf set syntax=ld

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
nnoremap <leader>w :vertical resize 160<CR>
nnoremap <leader>l :set wrap!<CR>
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
" leader maps for closing buffers 
nnoremap <silent> <leader>x :Bunlink<CR>
nnoremap <silent> <leader>X :Bunlink!<CR>

" kinda messes up in fuzzyfinding.... bcuz it's termbuffer.
" to be fixed.
tnoremap qq <C-\><C-n>:bd!<CR>
tnoremap jk <C-\><C-n>
tnoremap kj <C-\><C-n>

" stop fugitive from polluting my buffer list
autocmd BufReadPost fugitive://* set bufhidden=delete
" same for workbench?/todolist
autocmd BufReadPost workbench.md set bufhidden=delete

nmap <leader>d <Plug>(coc-definition)
nmap <leader>n <Plug>(coc-references)
nn <silent> K :call CocActionAsync('doHover')<cr>

" webdev again
let g:html_indent_script1 = "inc"
let g:html_indent_style1 = "inc"

" ok, tab is superior to inconvienient vim defaults when dealing with completion.
inoremap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<Tab>"

let g:alternateSearchPath = 'sfr:../source,sfr:../src,sfr:../include,sfr:../inc,sfr:../Include,sfr:../Source'

" neovim 4.0 has floating wildmenu. I don't really love it.
set wildoptions-=pum

" Below are my personal key mappings
" <Plug>ToggleProjectWorkbench let you toggle project specific workbench
nmap <leader>\ <Plug>ToggleProjectWorkbench

" <Plug>WorkbenchToggleCheckbox allows you to add/toggle the checkbox
" - testing -> - [ ] testing
" - [ ] testing -> - [x] testing
" - [x] testing -> - [ ] testing
nmap <leader><CR> <Plug>WorkbenchToggleCheckbox
let g:workbench_storage_path = "/home/ympek/notes"

" im not convinced yet but...
nnoremap <silent> <leader>p  :<C-u>CocList -A --normal yank<cr>
