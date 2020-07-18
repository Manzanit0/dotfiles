set nocompatible              " be iMproved, required
filetype off                  " required

"-------------------
" Leader mappings
"-------------------
let mapleader=" "

" Quickly open/source .nvimrc in new tab
nnoremap <leader>nc :tabedit ~/repositories/dotfiles/dotfiles/.nvimrc<CR>
nnoremap <leader>nr :source ~/.config/nvim/init.vim<CR>

" Buffer switching
map <leader>p :bp<CR>
map <leader>n :bn<CR>

" Clear search results
nmap <Leader><CR> :nohlsearch<cr>

" Ctrl + r: rename over file
vnoremap <C-r> "hy:%s/<C-r>h//gc<left><left><left>

"-------------------------
" Copied from nietaki-files
"-------------------------

" maximize the window
nmap <Leader>wm <C-W>_ <C-W>\|

" distribute the windows equally
nnoremap <Leader>w= <C-W>=

" save all open buffers
nnoremap <Leader>ps :wa<CR>

" refresh the currently edited file from disk
nnoremap <Leader>fR :e!<CR>

" https://vi.stackexchange.com/questions/458/how-can-i-reload-all-buffers-at-once
nnoremap <Leader>fr :checktime<CR>

" quit
nnoremap <Leader>qq :qa<CR>

" --hidden makes ag not skip the hidden files when searching
let $FZF_DEFAULT_COMMAND = 'ag --hidden -g ""'

" Configure :Ag to exclude file names. Search only contents.
command! -bang -nargs=* Ag call fzf#vim#ag(<q-args>, {'options': '--no-sort --delimiter : --nth 4..'}, <bang>0)
command! -bang -nargs=* AgFuzzy call fzf#vim#ag(<q-args>, {'options': '--delimiter : --nth 4..'}, <bang>0)

" Search file name with preview
nmap <Leader>f/ :Files<CR>

" Search file contents
nmap <Leader>c/ :AgFuzzy<CR>

" Search in current file's lines
nmap <Leader>l/ :BLines<CR>

" recent buffer history
nnoremap <Leader>bh :CtrlPMRUFiles<CR>

" absolute path (/something/src/foo.txt)
nnoremap <leader>cF :let @+=expand("%:p")<CR>

" relative path (src/foo.txt)
nnoremap <leader>cf :let @+=expand("%")<CR>

" fugitive shortcuts
" Working with maps: https://github.com/tpope/vim-fugitive/blob/master/doc/fugitive.txt#L252
nmap <Leader>gs :Gstatus<CR>
nmap <Leader>gc :Gcommit<CR>
" nmap <Leader>gp :Git shove<CR>
nmap <Leader>gb :Gblame<CR>

let g:flog_default_arguments = { 'max_count': 1000 }
nmap <Leader>gl :Flog<CR>
nmap <Leader>gL :Flogsplit<CR>

"-------------------------
"
" General purpose plugins
"-------------------------
" set the runtime path to include Vundle and initialize
call plug#begin('~/.local/share/nvim/plugged')

Plug 'crusoexia/vim-monokai' " Color theme
Plug 'sheerun/vim-polyglot' " Overall language support
Plug 'vim-airline/vim-airline' " Navbar
Plug 'vim-airline/vim-airline-themes' " Colours for Navbar
Plug 'tomtom/tcomment_vim' " Commenting & Uncommenting stuff
Plug 'kien/ctrlp.vim' " Fuzzy finder for files, etc.
let g:ctrlp_user_command = 'ag %s -l --nocolor --hidden -g ""' " requires ag installed!

Plug 'tpope/vim-surround' " quoting/parenthesizing made simple
Plug 'tpope/vim-dispatch' " Asynchronous build and test dispatcher\

Plug 'sbdchd/neoformat'

Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
Plug 'wesQ3/vim-windowswap'

Plug 'junegunn/goyo.vim'
Plug 'Shougo/deoplete.nvim' " Dark powered asynchronous completion framework
let g:deoplete#enable_at_startup = 1

"-------------------
" Vimux
"-------------------
Plug 'benmills/vimux' " Easy interaction with tmux
map <Leader>q :call VimuxRunCommand("clear; mix test " . bufname("%"))<CR>

map <Leader>vp :VimuxPromptCommand<CR>
map <Leader>vl :VimuxRunLastCommand<CR>
map <Leader>vq :VimuxCloseRunner<CR>

"-------------------
" NerdTree
"-------------------
Plug 'scrooloose/nerdtree' " File explorer

" close nerdtree when you open a file
let NERDTreeQuitOnOpen = 1

" delete the buffer when you delete a file
let NERDTreeAutoDeleteBuffer = 1
map <C-\> :NERDTreeToggle<CR>

" opens the current file in nerdtree
map <C-o> :NERDTreeFind<CR>

" Shuts vim if NerdTree is the last window left
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

" Starts NERDTree at the start.
autocmd vimenter * NERDTree
let NERDTreeShowHidden=1

"-------------------
" Git
"-------------------
Plug 'rbong/vim-flog'
Plug 'tpope/vim-fugitive' " Git tools
set diffopt+=vertical

Plug 'airblade/vim-gitgutter' " Shows a git diff in the gutter
let g:gitgutter_enabled = 1
let g:gitgutter_highlight_lines = 0
let g:gitgutter_realtime = 1
let g:gitgutter_eager = 1
set updatetime=100

"-------------------
" Markdown
"-------------------
Plug 'suan/vim-instant-markdown'

"-------------------
" Ruby
"-------------------
Plug 'vim-ruby/vim-ruby' " Syntax highlighting for Ruby.
Plug 'tpope/vim-endwise' " Adds closing tags for Ruby
let ruby_fold = 1
let ruby_spellcheck_strings = 1

"-------------------
" ALE
" -----------------
Plug 'dense-analysis/ale'
  let g:ale_fix_on_save = 1
  let g:ale_lint_on_save = 1
  let g:ale_lint_on_insert_leave = 0
  let g:ale_lint_on_text_changed = 0
  let g:ale_linters_explicit = 1
  let g:ale_go_gofmt_options = '-s'
  let g:ale_lsp_show_message_severity = 'warning'
  let g:ale_sign_error = 'E'
  let g:ale_sign_warning = 'W'
  let g:ale_sign_info = 'I'
  let g:ale_set_highlights = 0
  let g:ale_completion_enabled = 0 "Must be disabled so deoplete works
  set omnifunc=ale#completion#OmniFunc
  set completeopt=menu,menuone

  let g:ale_fixers = {
        \   'go': ['goimports', 'gofmt'],
        \   '*': ['remove_trailing_lines', 'trim_whitespace'],
        \ }
  let g:ale_linters = {
        \   'go': ['gopls', 'golangci-lint'],
        \   'elixir': ['elixir-ls'],
        \ }
  let g:ale_type_map = {
        \   'golangci-lint': {'ES': 'WS', 'E': 'W'},
        \ }

augroup ale_mappings
  " Some basic ALE navigating
  au FileType go,elixir nnoremap <silent> <buffer> <C-]> :ALEGoToDefinition<CR>
  au FileType go,elixir nnoremap <silent> <buffer> K :ALEHover<CR>
  au FileType go,elixir nmap <F2> :ALEFindReferences<CR>

  " Navigate errors with ctrl+j and ctrl+k
  au FileType go,elixir nmap <silent> <C-k> <Plug>(ale_previous_wrap)
  au FileType go,elixir nmap <silent> <C-j> <Plug>(ale_next_wrap)
augroup END

"-------------------
" Go
" -----------------
let g:ale_go_gofmt_options = '-s'

"-------------------
" Elixir
"-------------------
Plug 'elixir-editors/vim-elixir' " Syntax highlighting and indentation.

" Required, tell ALE where to find Elixir LS
let g:ale_elixir_elixir_ls_release = expand("/home/manzanit0/repositories/elixir-ls/rel")

" Optional, you can disable Dialyzer with this setting
let g:ale_elixir_elixir_ls_config = {'elixirLS': {'dialyzerEnabled': v:false}}

"-------------------
" Javascript/HTML/CSS
"-------------------
Plug 'pangloss/vim-javascript'
Plug 'mxw/vim-jsx'
Plug 'elzr/vim-json'
Plug 'othree/html5.vim'
Plug 'hail2u/vim-css3-syntax'
Plug 'cakebaker/scss-syntax.vim'


" All of your Plugins must be added before the following line
call plug#end()

" This has to be called after plug#end
call deoplete#custom#option('sources', { 'go': ['ale'], 'elixir': ['ale']})

"-------------------
" General config
"-------------------
set ttimeout        " time out for key codes
set ttimeoutlen=100 " wait up to 100ms after Esc for special key

" Use <C-L> to clear the highlighting of :set hlsearch.
if maparg('<C-L>', 'n') ==# ''
  nnoremap <silent> <C-L> :nohlsearch<C-R>=has('diff')?'<Bar>diffupdate':''<CR><CR><C-L>
endif

" Toggle if in OSx
" let g:python2_host_prog = '/usr/local/bin/python'
" let g:python3_host_prog = '/usr/local/bin/python3'

" set list listchars=tab:»·,trail:·,nbsp:· " Display extra whitespace

" Show trailing whitespace and spaces before a tab:
highlight ExtraWhitespace ctermbg=red guibg=red
autocmd Syntax * syn match ExtraWhitespace /\s\+$\| \+\ze\\t/

set foldmethod=syntax
set nofoldenable " Files don't start folded
set nosmartindent
set autoindent
set cursorline " highlight the current line the cursor is on
set cuc cul    " highlight the current column the cursor is on

set backspace=indent,eol,start
" set backspace=2   " fix backspace (on some OS/terminals)
set laststatus=2  " Shows the current status of the file.
set expandtab     " Replaces a <TAB> with spaces
set shiftwidth=2  " The amount to block indent when using < and >
set shiftround    " Shift to the next round tab stop
set tabstop=2     " 2 space tab
set softtabstop=2 " Causes backspace to delete 2 spaces = converted <TAB>
set smarttab      " Uses shiftwidth instead of tabstop at start of lines

" Numbers in the side
set nu
set number
set numberwidth=5

" Searching
set hlsearch   " Highlights the areas that you search for.
set incsearch  " Searches incrementally as you type.
set ignorecase " Case Insensitivity Pattern Matching
set smartcase  " Overrides ignorecase if pattern contains upcase

set showmatch "sm: flashes matching brackets or parentheses

" Copy&Paste works with the system too.
" See: https://vim.fandom.com/wiki/Accessing_the_system_clipboard
set clipboard=unnamedplus " In case of Linux
" set clipboard=unnamed " This would be for OSx.


" When scrolling off-screen do so 3 lines at a time, not 1
set scrolloff=3

" Open new split panes to right and bottom, which feels more natural
set splitbelow
set splitright

" Highlights with a small shadow all code surpassing 80 characters.
highlight OverLength ctermbg=red ctermfg=white guibg=#592929
match OverLength /\%81v.\+/

"-------------------
" Colors
"-------------------
syntax on
colorscheme monokai

if (has("nvim"))
  "For Neovim 0.1.3 and 0.1.4 < https://github.com/neovim/neovim/pull/2198 >
  let $NVIM_TUI_ENABLE_TRUE_COLOR=1
endif

"For Neovim > 0.1.5 and Vim > patch 7.4.1799 < https://github.com/vim/vim/commit/61be73bb0f965a895bfb064ea3e55476ac175162 >
"Based on Vim patch 7.4.1770 (`guicolors` option) < https://github.com/vim/vim/commit/8a633e3427b47286869aa4b96f2bfc1fe65b25cd >
" < https://github.com/neovim/neovim/wiki/Following-HEAD#20160511 >
if (has("termguicolors"))
  set termguicolors
endif

"-------------------
" Other remappings
"-------------------
" https://vim.fandom.com/wiki/Avoid_the_escape_key
imap jj <Esc>
