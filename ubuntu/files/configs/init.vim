" vim: ts=2 sw=2 et fdm=marker

" ******************** global settings ******************** {{{
set nocompatible                    " no need in vi compatibility :)
set termencoding=utf-8              " Кодировка текста по умолчанию
syntax on                           " Включить подсветку синтаксиса
filetype on                         " enable file typing
filetype plugin on
filetype indent on
set cursorline                      " cursor line highlight
set number                          " line numbering
set ruler                           " cursor position in statusline
" set showcmd				" Показывать незавершённые команды в статусбаре[by default]
set icon                            " show icon in titlebar if term supports
set tabstop=4                       " Softtabs or die! use 2 spaces for tabs.
set shiftwidth=4                    " Number of spaces to use for each step of (auto)indent.
set expandtab                       " insert tab with right amount of spacing
set shiftround                      " Round indent to multiple of 'shiftwidth'
" set smarttab
set autoindent                      " preserve indent on new line
" set nosmartindent                 " smartindent is deprecated in favor of cindent
set cindent
set fo+=cr                          " Fix <Enter> for comment
" set foldmethod=indent				" Фолдинг по отступам
set showmatch                       " проверка скобок
set incsearch                       " search-as-you-type
set ignorecase                      " search case-insensitive
set hlsearch                        " highlight search results
set noshowmode                      " don't show mode as airline already does
set pastetoggle=<F3>                " <F3> to toggle indentation on paste
set mouse=a                         " enable all-mouse
set mousemodel=popup
set mousehide                       " hide mouse on typing
set ttymouse=sgr                    " xterm2 + 223+ cols
set nofsync                         " выкл. вызов фсинк - хак для екст*
set autochdir                       " авто-переход в каталог текущего файла
set autowrite                       " автосейв при потере фокуса
set makeprg=%:p                     " make запускает текущий файл
set hidden                          " required for LSP plugins
set completeopt=longest,menu,preview    " omni-completion settings
if v:version > 747                  " noinsert is vim >= 7.4.775
  set completeopt=longest,menu,noinsert,preview    " omni-completion settings
endif
set splitbelow                      " make preview window appear at bottom (see also spr)

" Меняем цветовую схему
colorscheme desert                  " most commonly available
try
  colorscheme industry              " try industry if available
catch /^Vim\%((\a\+)\)\=:E185/
endtry
" colorscheme nord
set background=dark                 " tell vim what the background color looks like
" highlight Comment ctermfg=darkgray

" Формат строки состояния
" set statusline=%<%f%h%m%r\ %b\ %{&encoding}\ 0x\ \ %l,%c%V\ %5*%0*%<%f\ %3*%m%1*%r%0*\ %2*%y%4*%w%0*%=[%b\ 0x%B]\ \ %8l,%10([%c%V/%{strlen(getline(line('.')))}]%)\ %P
" set statusline=%<%f%h%m%r\ %{&encoding}\ %3*%m%1*%r%0*\ %2*%y%4*%w%0*%=[%b\ 0x%B]\ \ %8l,%10([%c%V/%{strlen(getline(line('.')))}]%)\ %P
" set statusline=%<%f%h%m%r\ %b\ %{&encoding}\ 0x\ \ %l,%c%V\ %P
set laststatus=2                    " always show statusbar
set sessionoptions=curdir,buffers,tabpages        " Опции сесссий

set spelllang=en_us spell           " enable spellchecks for en_US
set history=3000                    " увеличение истории команд
set nospell

" Let's save undo info!
if !isdirectory($HOME."/.vim/undo-dir")
  call mkdir($HOME."/.vim/undo-dir", "", 0700)
endif
set undodir=~/.vim/undo-dir
set undofile
" write swap files in homedir instead of '.'
if !isdirectory($HOME."/.vim/swap")
  call mkdir($HOME."/.vim/swap", "", 0700)
endif
set directory=~/.vim/swap

if has('nvim')
  set inccommand=nosplit            " preview :s/// change
endif
" **************************************** }}}

" ******************** Hot Keys ******************** {{{
" disable annoying REPLACE mode
imap <Insert> <Nop>
" bind CTRL-S to save in all modes
nmap <C-S> :up<CR>
imap <C-S> <Esc>:up<CR>i
vmap <C-S> <Esc>:up<cr>gv

" Заставляем shift-insert работать как в Xterm
map <S-Insert> <MiddleMouse>

" более привычные Page Up/Down, когда курсор остаётся в той же строке,
" (а не переносится в верх/низ экрана, как при стандартном PgUp/PgDown)
" Поскольку по умолчанию прокрутка по C-Y/D происходит на полэкрана,
" привязка делается к двойному нажатию этих комбинаций.
nmap <PageUp> <C-U><C-U>
imap <PageUp> <C-O><C-U><C-O><C-U>

nmap <PageDown> <C-D><C-D>
imap <PageDown> <C-O><C-D><C-O><C-D>

" interactive replace current word in buffer
nnoremap <Leader><C-h> :%s/\<<C-r><C-w>\>//gc<Left><Left><Left>
vnoremap <Leader><C-h> y :%s/\<<C-r>"\>//gc<Left><Left><Left>

" FZF mappings
" Mapping selecting mappings
nmap <leader><tab> <plug>(fzf-maps-n)
xmap <leader><tab> <plug>(fzf-maps-x)
omap <leader><tab> <plug>(fzf-maps-o)
" Insert mode completion
imap <c-x><c-k> <plug>(fzf-complete-word)
imap <c-x><c-f> <plug>(fzf-complete-path)
imap <c-x><c-j> <plug>(fzf-complete-file-ag)
imap <c-x><c-l> <plug>(fzf-complete-line)
" fzf-vim shortcuts
nnoremap <Leader><C-b> :Buffers<CR>
nnoremap <C-g>g :Ag<CR>
nnoremap <C-g>l :Lines<CR>
nnoremap <Leader><Leader> :Commands<CR>

if has("nvim")
  map  <silent>  <S-Insert>  "+p
  imap <silent>  <S-Insert>  <Esc>"+pa
  cmap <S-Insert>  <C-r>+
  vmap <silent>  <C-Insert>  "+y
  vmap <silent>  <S-Delete>  "+d
endif

" **************************************** }}}


" ******************** fix python on windows ******************* {{{
if has('win32')
  set shell=powershell shellpipe=\| shellredir=> shellxquote=
  set shellcmdflag=-NoLogo\ -NoProfile\ -ExecutionPolicy\ RemoteSigned\ -Command
  let g:python_host_prog = 'C:\python27\python.exe'
  let g:python2_host_prog = 'C:\python27\python.exe'
  let g:python3_host_prog = 'C:\Users\r00t\AppData\Local\Programs\Python\Python37\python.exe'
endif
" **************************************** }}}


" ******************** Plug-Vim ******************** {{{
" Install vim-plug if we don't already have it
if has('win32')
  if empty(glob('~/appdata/local/nvim/autoload/plug.vim'))
    silent !md ~/AppData/Local/nvim/autoload
    silent !(New-Object Net.WebClient).DownloadFile('https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim', $ExecutionContext.SessionState.Path.GetUnresolvedProviderPathFromPSPath("~/AppData/Local/nvim/autoload1/plug.vim"))
  endif
  call plug#begin('~/appdata/local/nvim/plugged')
else
  if empty(glob('~/.vim/autoload/plug.vim'))
    silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
  endif
  call plug#begin('~/.vim/plugged')
endif

" tpope plugin library
Plug 'tpope/vim-sensible'           " a universal set of defaults that (hopefully) everyone can agree on
Plug 'tpope/vim-git', { 'for': 'git' }    " syntax, indent, and filetype plugin files for git, gitcommit, gitconfig, gitrebase, and gitsendemail
Plug 'tpope/vim-fugitive'           " git awesomeness
Plug 'tpope/vim-surround'           " easily delete, change and add parentheses, brackets, quotes, XML tags, and more
Plug 'tpope/vim-eunuch'             " Vim sugar for the UNIX shell commands that need it the most
Plug 'tpope/vim-repeat'             " allow (non-native) plugins to use the . command
" Plug 'tpope/vim-projectionist'
Plug 'tpope/vim-unimpaired'         " vim unimpaired fixes daily annoyances with lot of [<map> and ]<map> paired hotkeys
Plug 'tpope/vim-abolish'            " abolish.vim: easily search for, substitute, and abbreviate multiple variants of a word
" Plug 'tpope/vim-rsi'                " Support emacs keybindings in insert mode
" Plug 'tpope/vim-fireplace', { 'for': 'clojure' }    " Clojure REPL in Vim
Plug 'tpope/vim-obsession'          " save vim sessions
Plug 'tpope/vim-commentary'         " Comment out code easily with gc hotkey
" Plug 'tpope/vim-vinegar'            " enhances netrw to make project drawer
" Plug 'tpope/vim-ragtag'    " RagTag: Auto-close html tags + mappings for template scripting languages
Plug 'tpope/vim-jdaddy', { 'for': 'json' }    " JSON manipulation
Plug 'tpope/vim-scriptease'         " vim plugin for writing vim plugins

if isdirectory($HOME."/proj/")
  Plug 'SirVer/ultisnips', has('python3') ? {} : { 'on': [] }| Plug 'honza/vim-snippets'    " snips engine. and snippet library
  Plug 'mhinz/vim-startify'           " fancy vim start page
  Plug 'mbbill/undotree'              " The ultimate undo history visualizer for VIM
  Plug 'pangloss/vim-javascript', { 'for': 'javascript' }    " syntax highlighting and improved indentation for js
  Plug 'leafgarland/typescript-vim'   " TypeScript
  Plug 'hail2u/vim-css3-syntax'       " up to date CSS3 syntax highlighting
  Plug 'elzr/vim-json', { 'for': 'json' }    " highlighting of keywords vs values, JSON-specific (non-JS) warnings, quote concealing
  Plug 'plasticboy/vim-markdown', { 'for': 'markdown' }
  " Plug 'pearofducks/ansible-vim'      " ansible vim plugin
  " Plug 'ekalinin/Dockerfile.vim', {'for' : 'Dockerfile'}    " Docker
  " Plug 'exu/pgsql.vim'                " postgres sql highlighting
  Plug 'posva/vim-vue', { 'for': 'vue' }     " syntax highlighting for vue components
  " Plug 'leafOfTree/vim-vue-plugin', { 'for': 'vue' }    " syntax and indent plugin for .vue files
  " Plug 'rhysd/vim-wasm', { 'for': 'wasm' }    " WebAssembly syntax
  " Plug 'dag/vim-fish', { 'for': 'fish' }
  " Plug 'hashivim/vim-terraform'       " terraform syntax
  " Plug 'raimon49/requirements.txt.vim', {'for': 'requirements'}
  " Plug 'mxw/vim-jsx'
  " Plug 'kchmck/vim-coffee-script'
  " Plug 'cakebaker/scss-syntax.vim', { 'for': 'scss' }
  " Plug 'qrps/lilypond-vim', { 'for': 'lilypond' }
  " Plug 'ambv/black', { 'for': 'python' }
  Plug 'mattn/emmet-vim'              " Emmet: generates html tags, autocomplete css
  " Plug 'autozimu/LanguageClient-neovim', { 'branch': 'next', 'do': 'bash install.sh', }
  " Plug 'vscode-langservers/vscode-css-languageserver-bin'		" css language server
  Plug 'dense-analysis/ale'           " staticly check code and highlight errors
endif
" Plug 'itchyny/lightline.vim', has('nvim') ? {} : { 'on': [] }    " lightweight airline/powerline alternative
Plug 'itchyny/lightline.vim'        " lightweight airline/powerline alternative
" Plug 'lambdalisue/gina.vim'         " async git controls
Plug 'airblade/vim-gitgutter'       " Visual git gutter
Plug 'preservim/nerdcommenter'      " powerful vim commenter
" Plug 'preservim/nerdtree', { 'on': 'NERDTreeToggle' }    " tree explorer for vim
" Plug 'Xuyuanp/nerdtree-git-plugin'
Plug 'chr4/nginx.vim'               " syntax and validation for nginx.conf
Plug 'junegunn/fzf'                 " fzf greatness (fuzzy finding)
Plug 'junegunn/fzf.vim'
Plug 'machakann/vim-highlightedyank' " visual hint what you've yaked

" Plug 'tweekmonster/startuptime.vim'    " profiling vim startup
" Plug 'Rykka/riv.vim'
" Plug 'Rykka/InstantRst'
" Plug 'terryma/vim-multiple-cursors' " horrible idea?
" Plug 'nathanaelkane/vim-indent-guides' " a bit wrong colors
" Plug 'mtth/scratch.vim'             " Scratch buffers
Plug 'yggdroot/indentline'          " display thin vertical lines at each indentation level
Plug 'easymotion/vim-easymotion'    " a much simpler way to use some motions in vim
" Plug 'raghur/vim-ghost', {'do': ':GhostInstall'}    " live editing web with browser plugin
" Plug 'jaxbot/browserlink.vim'       " live browser editing(html/css/js)

" Plug 'neoclide/coc.nvim', {'branch': 'release'}    " ConquerorOfCompletion is intellisense engine for Vim/Neovim

" legacy vim compatibility
Plug 'roxma/nvim-yarp', v:version >= 800 && !has('nvim') ? {} : { 'on': [], 'for': [] }
Plug 'roxma/vim-hug-neovim-rpc', v:version >= 800 && !has('nvim') ? {} : { 'on': [], 'for': [] }
Plug 'equalsraf/neovim-gui-shim'
Plug 'mileszs/ack.vim'		            " Ack/Ag vim integration
Plug 'jremmen/vim-ripgrep'		        " RipGrep - grep is dead. All hail the new king RipGrep.
Plug 'ryanoasis/vim-devicons'         " File icons in vim --- keep at the bottom, below airline, nerdtree and startify

" color schemas
" Plug 'mhartington/oceanic-next'
" Plug 'tomasr/molokai'
" Plug 'fmoralesc/molokayo'
" Plug 'chriskempson/base16-vim'
" Plug 'romainl/flattened'
" Plug 'morhetz/gruvbox'
" Plug 'joshdick/onedark.vim'
" Plug 'rakr/vim-one'
call plug#end()
" **************************************** }}}

" ******************** SirVer/ultisnips ******************** {{{
let g:UltiSnipsEditSplit="vertical"
" let g:UltiSnipsExpandTrigger="<Leader><tab>"
" let g:UltiSnipsListSnippets="<C-j>"
" quick search snippets with FZF
imap <C-j> <esc>:Snippets<CR>
" **************************************** }}}

" ******************** elzr/vim-json ******************** {{{
let g:vim_json_syntax_conceal = 0   " do not hide quotation marks in json
" **************************************** }}}

" ******************** itchyny/lightline.vim ******************** {{{
let g:lightline = {
  \	'colorscheme': 'powerline',
  \	'active': {
  \	  'left': [['mode', 'paste' ], ['readonly', 'filename', 'modified']],
  \	  'right': [['ale#statusline#Count'],['lineinfo'], ['percent'], ['fileformat'], ['fileencoding']]
  \	}
  \}
" **************************************** }}}

" ******************** autozimu/LanguageClient-neovim ******************** {{{
" let g:LanguageClient_serverCommands = {
" 	\	'python':	['pyls'],
" 	\	'bash':		['bash'],
"   \ 'html':   ['html-languageserver', '--stdio'],
"   \ 'javascript': ['javascript-typescript-stdio'],
"   \ 'typescript': ['javascript-typescript-stdio'],
"   \ 'css':    ['css-languageserver --stdio'],
"   \ 'vue':    ['vls']
"   \ }
" let g:LanguageClient_rootMarkers = {
"   \ 'javascript': ['jsconfig.json'],
"   \ 'typescript': ['tsconfig.json'],
"   \ }
" nnoremap <silent> K :call LanguageClient#textDocument_hover()<CR>
" nnoremap <silent> gd :call LanguageClient#textDocument_definition()<CR>
" nnoremap <silent> <F2> :call LanguageClient#textDocument_rename()<CR>
" **************************************** }}}

" ******************** dense-analysis/ale ******************** {{{
" let g:ale_sign_warning = '▲'
" let g:ale_sign_error = '✗'
let g:ale_completion_enabled = 1
let g:ale_list_vertical = 1
" set completeopt=menu,menuone,preview,noselect,noinsert
let g:ale_fixers = {
	\	'python':['black'],
	\	'html': ['tidy'],
	\	'javascript': ['tsserver'],
  \ 'vue':    ['vls']
	\}
let g:ale_linters = {
	\	'python': ['pyls'],
	\	'html':   ['htmlhint'],
	\ 'javascript': ['tsserver'],
	\	'sh':     ['language_server'],
  \ 'vue':    ['vls']
	\}
let g:ale_sign_column_always = 1    " always show column with ALE signs
let g:airline#extensions#ale#enabled = 1    " send ALE status to airline
let g:ale_set_balloons = 1          " if vim supports, do mouse over hovers
let g:ale_hover_to_preview = 1      " try to use baloon_show() for preview
nmap <silent> ]w :ALENextWrap<CR>
nmap <silent> [w :ALEPreviousWrap<CR>
nnoremap <silent> K :ALEHover<CR>
" nnoremap <silent> gd :call LanguageClient#textDocument_definition()<CR>
" nnoremap <silent> <F2> :call LanguageClient#textDocument_rename()<CR>
nmap <silent> <Leader>f <Plug>(ale_fix)
augroup VimDiff
  autocmd!
  autocmd VimEnter,FilterWritePre * if &diff | ALEDisable | endif
augroup END
" **************************************** }}}

" ******************** preservim/nerdcommenter ******************** {{{
" Add spaces after comment delimiters by default
let g:NERDSpaceDelims = 1
" Use compact syntax for prettified multi-line comments
let g:NERDCompactSexyComs = 1
" " Align line-wise comment delimiters flush left instead of following code indentation
let g:NERDDefaultAlign = 'left'
" " Set a language to use its alternate delimiters by default
" let g:NERDAltDelims_java = 1
" " Add your own custom formats or override the defaults
" let g:NERDCustomDelimiters = { 'c': { 'left': '/**','right': '*/' } }
" Allow commenting and inverting empty lines (useful when commenting a region)
let g:NERDCommentEmptyLines = 1
" Enable trimming of trailing whitespace when uncommenting
let g:NERDTrimTrailingWhitespace = 1
" " Enable NERDCommenterToggle to check all selected lines is commented or not
" let g:NERDToggleCheckAllLines = 1
let g:NERDDisableTabsInBlockComm = 1
" **************************************** }}}

" ******************** junegunn/fzf colors ******************** {{{
let g:fzf_colors =
\ { 'fg':      ['fg', 'Normal'],
  \ 'bg':      ['bg', 'Normal'],
  \ 'hl':      ['fg', 'Comment'],
  \ 'fg+':     ['fg', 'CursorLine', 'CursorColumn', 'Normal'],
  \ 'bg+':     ['bg', 'CursorLine', 'CursorColumn'],
  \ 'hl+':     ['fg', 'Statement'],
  \ 'info':    ['fg', 'PreProc'],
  \ 'border':  ['fg', 'Ignore'],
  \ 'prompt':  ['fg', 'Conditional'],
  \ 'pointer': ['fg', 'Exception'],
  \ 'marker':  ['fg', 'Keyword'],
  \ 'spinner': ['fg', 'Label'],
  \ 'header': ['fg', 'Comment'] }
" enable preview in :Files
let g:fzf_files_options =
  \ '--preview "(pygmentize {} || cat {}) 2>/dev/null | head -'.&lines.'"'
" **************************************** }}}
" Enable omni completion.
" autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
" autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
" autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
autocmd FileType python setlocal omnifunc=python3complete#Complete
" autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags
set omnifunc=syntaxcomplete#Complete

" vimgrep
if executable('ag')
  let g:ackprg = 'ag --vimgrep'
endif

" cursor shapes (gui only)
" set guicursor=n-v-c:block,i-ci-ve:ver25,r-cr:hor20,o:hor50
"   \,a:blinkwait700-blinkoff400-blinkon250-Cursor/lCursor
"   \,sm:block-blinkwait175-blinkoff150-blinkon175

" interactive replace current word in buffer
nnoremap <Leader><C-h> :%s/\<<C-r><C-w>\>//gc<Left><Left><Left>
vnoremap <Leader><C-h> y :%s/\<<C-r>"\>//gc<Left><Left><Left>

" posva/vim-vue:
let g:vue_pre_processors = []
