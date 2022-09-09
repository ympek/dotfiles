" persistent undo
" not really a plugin, but hardcoded path, so move it to vanilla when this is
" fixed
if !isdirectory($HOME."/.config/nvim/undodir")
  call mkdir($HOME."/.config/nvim/undodir", "p")
endif

set undodir=~/.config/nvim/undodir
set undofile
set undolevels=99999 "maximum number of changes that can be undone
set undoreload=10000 "maximum number lines to save for undo on a buffer reload

" if I have plugins, then mode is in my statusline
set noshowmode

" PLUGINS
call plug#begin()
" base/fav/superUseful
" Plug 'itchyny/lightline.vim'
Plug 'tpope/vim-fugitive'
Plug 'ap/vim-buftabline'
Plug 'vim-utils/vim-interruptless'
Plug 'kshenoy/vim-signature'
Plug 'google/vim-searchindex'
Plug 'dyng/ctrlsf.vim'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
Plug 'tpope/vim-commentary'
Plug 'justinmk/vim-dirvish'
" Plug 'vim-scripts/taglist.vim'
Plug 'tpope/vim-surround'
" Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'RRethy/vim-illuminate'

" c/cpp
Plug 'octol/vim-cpp-enhanced-highlight'
Plug 'vim-scripts/a.vim'
Plug 'lyuts/vim-rtags'

Plug 'kyazdani42/nvim-web-devicons' " for file icons
Plug 'kyazdani42/nvim-tree.lua'

" web
" Plug 'sheerun/vim-polyglot'
Plug 'alvan/vim-closetag'
Plug 'othree/html5.vim'
" Plug 'pangloss/vim-javascript'
Plug 'mxw/vim-jsx'
Plug 'chrisbra/Colorizer'

" colorschemes:
Plug 'ympek/happy_hacking.vim'
Plug 'ympek/iceberg.vim'
Plug 'ympek/melange'
Plug 'FrenzyExists/aquarium-vim'

Plug 'liuchengxu/vista.vim'
Plug 'tweekmonster/startuptime.vim'
" dont mess up my layout
Plug 'orlp/vim-bunlink'

" testing new stuff
Plug 'liuchengxu/vim-clap', { 'do': { -> clap#installer#force_download() } }
Plug 'marcushwz/nvim-workbench'
Plug 'glts/vim-magnum'
Plug 'glts/vim-radical'
Plug 'voldikss/vim-floaterm'
Plug 'folke/trouble.nvim'
Plug 'nvim-lualine/lualine.nvim'

Plug 'fatih/vim-go'

" completion
Plug 'neovim/nvim-lspconfig'
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'hrsh7th/cmp-buffer'
Plug 'hrsh7th/cmp-path'
Plug 'hrsh7th/cmp-cmdline'
Plug 'hrsh7th/nvim-cmp'
Plug 'L3MON4D3/LuaSnip'
Plug 'saadparwaiz1/cmp_luasnip'

call plug#end()

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

silent! colorscheme melange

" function! LightlineFilename()
"   let root = fnamemodify(get(b:, 'git_dir'), ':h')
"   let path = expand('%:p')
"   if path[:len(root)-1] ==# root
"     return path[len(root)+1:]
"   endif
"   return expand('%')
" endfunction

" fun! ShowFuncName()
"   return getline(search("^[^ \t#/]\\{2}.*[^:]\s*$", 'bWn'))
" endfun
" let g:lightline = {
"       \ 'colorscheme': 'iceberg',
"       \ 'active': {
"         \   'left': [ [ 'mode', 'paste' ],
"         \             [ 'gitbranch', 'readonly', 'filename', 'modified', 'hello', 'cocstatus' ] ],
"         \
"         \   'right': [ [ 'lineinfo' ],
"         \              [ 'method', 'funcname' ] ],
"         \ },
"         \ 'component': {
"           \   'hello': 'jedziesz'
"           \ },
"           \ 'component_function': {
"             \   'gitbranch': 'FugitiveStatusline',
"             \   'filename': 'LightlineFilename',
"             \   'cocstatus': 'coc#status',
"             \   'funcname': 'ShowFuncName',
"             \   'method': 'NearestMethodOrFunction'
"             \ },
"             \ }

" hi CursorLine cterm=NONE ctermbg=234
hi SignatureMarkText ctermfg=162

" or GitFiles
nnoremap <C-p> :GitFiles<CR>

" fix annoying vim-commentary /* */
autocmd FileType c,hpp,cpp,cs,java,php setlocal commentstring=//\ %s

" do plikow linkera se zrobilem
autocmd BufRead *.lcf set syntax=ld



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
" let g:ctrlsf_extra_backend_args = {
"       \ 'ag': '-p ~/.my_ignore -U'
"       \ }


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

" leader maps - plugin-based
nmap <leader>a :A<CR>
" tag list - testing new plugin
let Tlist_GainFocus_On_ToggleOpen = 1
let Tlist_WinWidth = 56
nmap <leader>k :Tlist<CR>

nnoremap <leader>t :FloatermNew<CR>
nnoremap <leader>` :FloatermToggle<CR>

map <leader>h :silent! 0Glog -10<CR>:bot copen<CR>0f.3w
" git show hash under cursor :))
map <leader>gs "gyiw:FloatermNew! git show <C-r>g<CR>
" git file history
map <leader>gh :FloatermNew! git log --follow -M -p <C-r>%<CR>
" git blame (fugitive.vim)
map <leader>gb :Git blame<CR>
" uhhh
map <leader>bd :bp\|bd!<CR>
" leader maps for closing buffers
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

" nmap <leader>dc :LspDeclaration<CR>
" nmap <leader>df <Plug>(coc-definition)
" nmap <leader>n <Plug>(coc-references)
" nn <silent>K :call CocActionAsync('doHover')<cr>

" map <leader>s :CocList symbols<CR>

" webdev again
let g:html_indent_script1 = "inc"
let g:html_indent_style1 = "inc"

let g:alternateSearchPath = 'sfr:../source,sfr:../src,sfr:../include,sfr:../inc,sfr:../Include,sfr:../Source'

" Below are my personal key mappings
" <Plug>ToggleProjectWorkbench let you toggle project specific workbench
nmap <leader>\ <Plug>ToggleProjectWorkbench

" <Plug>WorkbenchToggleCheckbox allows you to add/toggle the checkbox
" - testing -> - [ ] testing
" - [ ] testing -> - [x] testing
" - [x] testing -> - [ ] testing
nmap <leader><CR> <Plug>WorkbenchToggleCheckbox
let g:workbench_storage_path = "/home/ympek/notes/"

" im not convinced yet but...
" nnoremap <silent> <leader>p  :<C-u>CocList -A --normal yank<cr>

" django stuff... for completion with pyright... notice it does not say .git
" now...
" autocmd FileType python let b:coc_root_patterns = ['.env', 'venv', '.venv', 'manage.py']

lua << EOF
require("nvim-tree").setup()
require('lualine').setup {
  options = { theme = 'jellybeans' }
}

EOF

nnoremap <leader>f :NvimTreeToggle<CR>
" nnoremap <leader>f :NvimTreeRefresh<CR>
" nnoremap <leader>n :NvimTreeFindFile<CR>
" NvimTreeOpen and NvimTreeClose are also available if you need them

let g:rtagsRcCmd = 'rtags-rc'
" a list of groups can be found at `:help nvim_tree_highlight`
" highlight NvimTreeFolderIcon guibg=blue
" Register ccls C++ lanuage server.
if executable('ccls')
   au User lsp_setup call lsp#register_server({
      \ 'name': 'ccls',
      \ 'cmd': {server_info->['ccls']},
      \ 'root_uri': {server_info->lsp#utils#path_to_uri(lsp#utils#find_nearest_parent_file_directory(lsp#utils#get_buffer_path(), 'compile_commands.json'))},
      \ 'initialization_options': {'cache': {'directory': expand('~/.cache/ccls') }},
      \ 'allowlist': ['c', 'h', 'hpp', 'cpp', 'objc', 'objcpp', 'cc'],
      \ })
endif

imap <c-space> <Plug>(asyncomplete_force_refresh)

" https://github.com/neoclide/coc-css
" For scss files, you may need use:
autocmd FileType scss setl iskeyword+=@-@
"autocmd BufRead *.hbs set syntax=html

" some update to coc.nvim yhhh
" inoremap <silent><expr> <CR> coc#pum#visible() ? coc#pum#confirm() : "\<C-y>"
" inoremap <silent><expr> <Tab> coc#pum#visible() ? coc#pum#next(1) : "\<Tab>"
" inoremap <silent><expr> <S-Tab> coc#pum#visible() ? coc#pum#prev(1) : "\<S-Tab>"

" inoremap <silent><expr> <CR> coc#pum#visible() ? coc#pum#confirm() : "\<CR>"
" inoremap <silent><expr> <Esc> coc#pum#visible() ? coc#pum#cancel() : "\<Esc>"
"
runtime completion.vim
