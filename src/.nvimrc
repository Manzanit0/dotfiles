set nocompatible              " be iMproved, required
filetype off                  " required

"-------------------
" Leader mappings
"-------------------
let mapleader="s"

" Buffer switching
map <leader>p :bp<CR> " ,p previous buffer
map <leader>n :bn<CR> " ,n next buffer
nmap <Leader><CR> :nohlsearch<cr>
noremap <Leader>rx :!ruby %<CR>
noremap <Leader>re :!ruby %·

" Quickly open .nvimrc in new tab
nnoremap <leader>v :tabedit ~/.nvimrc<CR>

" Quickly source .vimrc
nnoremap <leader>r :source $MYVIMRC<CR>

"-------------------------
" General purpose plugins
"-------------------------
" set the runtime path to include Vundle and initialize
set rtp+=~/.config/nvim/bundle/Vundle.vim
call vundle#begin()

" let Vundle manage Vundle, REQUIRED
Plugin 'VundleVim/Vundle.vim'

Plugin 'crusoexia/vim-monokai' " Color theme
Plugin 'sheerun/vim-polyglot' " Overall language support
Plugin 'vim-airline/vim-airline' " Navbar
Plugin 'vim-airline/vim-airline-themes' " Colours for Navbar
Plugin 'tomtom/tcomment_vim' " Commenting & Uncommenting stuff
Plugin 'kien/ctrlp.vim' " Fuzzy finder for files, etc.
Plugin 'tpope/vim-surround' " quoting/parenthesizing made simple
Plugin 'tpope/vim-dispatch' " Asynchronous build and test dispatcher

"-------------------
" Deoplete
"-------------------
Plugin 'Shougo/deoplete.nvim' " Dark powered asynchronous completion framework
let g:deoplete#enable_at_startup = 1

"-------------------
" Vimux
"-------------------
Plugin 'benmills/vimux' " Easy interaction with tmux
map <Leader>rb :call VimuxRunCommand("clear; rspec " . bufname("%"))<CR>
map <Leader>rc :call VimuxRunCommand("clear; lein test ")<CR>
map <Leader>vp :VimuxPromptCommand<CR>
map <Leader>vl :VimuxRunLastCommand<CR>
map <Leader>vq :VimuxCloseRunner<CR>

"-------------------
" NerdTree
"-------------------
Plugin 'scrooloose/nerdtree' " File explorer
" Map NerdTree toggle
nmap <F6> :NERDTreeToggle<CR>
nmap <leader>= :NERDTreeToggle<CR>

" Shuts vim if NerdTree is the last window left
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

" Starts NERDTree at the start.
autocmd vimenter * NERDTree
let NERDTreeShowHidden=1

"-------------------
" Git
"-------------------
Plugin 'tpope/vim-fugitive' " Git tools
set diffopt+=vertical

Plugin 'airblade/vim-gitgutter' " Shows a git diff in the gutter
let g:gitgutter_enabled = 1
let g:gitgutter_highlight_lines = 0
let g:gitgutter_realtime = 1
let g:gitgutter_eager = 1
set updatetime=100

"-------------------
" Markdown
"-------------------
Plugin 'suan/vim-instant-markdown'

"-------------------
" Ruby
"-------------------
Plugin 'vim-ruby/vim-ruby' " Syntax highlighting for Ruby.
Plugin 'tpope/vim-endwise' " Adds closing tags for Ruby
let ruby_fold = 1
let ruby_spellcheck_strings = 1

"-------------------
" Elixir
"-------------------
Plugin 'elixir-editors/vim-elixir' " Syntax highlighting and indentation.
Plugin 'slashmili/alchemist.vim' " Gotodef, autocomplete and tooling.
let g:alchemist_tag_map = '<C-]>'
let g:alchemist_tag_stack_map = '<C-[>'

"-------------------
" Go
" -----------------
Plugin 'fatih/vim-go'
Plugin 'nsf/gocode', {'rtp': 'nvim/'}

let g:go_highlight_build_constraints = 1
let g:go_highlight_extra_types = 1
let g:go_highlight_fields = 1
let g:go_highlight_functions = 1
let g:go_highlight_methods = 1
let g:go_highlight_operators = 1
let g:go_highlight_structs = 1
let g:go_highlight_types = 1
let g:go_auto_sameids = 1 " Highlights all references of the variable under the cursor
let g:go_fmt_command = "goimports"
let g:go_auto_type_info = 1 " Shows type information in the statusbar

au FileType go set noexpandtab " Go standard is tabs.
au FileType go set shiftwidth=4
au FileType go set softtabstop=4
au FileType go set tabstop=4
au FileType go set nolist " Go uses tabs and the fmt autoformatter.

" Goes to the alternate test (:GoAlternate)
au Filetype go nmap <leader>ga <Plug>(go-alternate-edit)
au Filetype go nmap <leader>gah <Plug>(go-alternate-split)
au Filetype go nmap <leader>gav <Plug>(go-alternate-vertical)
au FileType go nmap <F10> :GoTest -short<cr>
au FileType go nmap <F9> :GoCoverageToggle -short<cr>
au FileType go nmap <F12> <Plug>(go-def)

au FileType go nmap <Leader>1 :GoTest -short<CR>
au FileType go nmap <Leader>2 :GoCoverageToggle -short<cr>

"-------------------
" Clojure
"-------------------
Plugin 'guns/vim-clojure-static' " Meikel Brandmeyer's excellent Clojure runtime files.
Plugin 'guns/vim-clojure-highlight' "Extend builtin syntax highlighting to referred and aliased vars in Clojure buffers
autocmd BufRead *.clj try | silent! Require | catch /^Fireplace/ | endtry " Evaluate Clojure buffers on load

Plugin 'kien/rainbow_parentheses.vim' " Better Rainbow Parentheses
Plugin 'tpope/vim-fireplace' " Clojure REPL support.
"Plugin 'tpope/vim-salve' " Static Vim support for Leiningen and Boot.

"-------------------
" Javascript/HTML/CSS
"-------------------
Plugin 'pangloss/vim-javascript'
Plugin 'mxw/vim-jsx'
Plugin 'elzr/vim-json'
Plugin 'othree/html5.vim'
Plugin 'hail2u/vim-css3-syntax'
Plugin 'cakebaker/scss-syntax.vim'

"-------------------
" PHP/Twig
"-------------------
Plugin 'lumiliet/vim-twig'

" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required

"-------------------
" General config
"-------------------
set ttimeout        " time out for key codes
set ttimeoutlen=0 " wait up to 100ms after Esc for special key

let g:python2_host_prog = '/usr/local/bin/python'
let g:python3_host_prog = '/usr/local/bin/python3'

set list listchars=tab:»·,trail:·,nbsp:· " Display extra whitespace

" Show trailing whitespace and spaces before a tab:
highlight ExtraWhitespace ctermbg=red guibg=red
autocmd Syntax * syn match ExtraWhitespace /\s\+$\| \+\ze\\t/

set foldmethod=syntax
set nofoldenable " Files don't start folded
set backspace=indent,eol,start
set nosmartindent
set autoindent
set cursorline " highlight the current line the cursor is on
set cuc cul    " highlight the current column the cursor is on

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
set clipboard=unnamed " Copy&Paste works with the system too.

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

" Don't complain on some obvious fat-fingers
nmap :W :w
nmap :W! :w!
nmap :Q :q
nmap :Q! :q!
nmap :Qa :qa
nmap :Wq! :wq!
nmap :WQ! :wq!

" Don't be a noob, join the no arrows key movement
inoremap  <Up>     <NOP>
inoremap  <Down>   <NOP>
inoremap  <Left>   <NOP>
inoremap  <Right>  <NOP>
noremap   <Up>     <NOP>
noremap   <Down>   <NOP>
noremap   <Left>   <NOP>
noremap   <Right>  <NOP>
