set nocompatible              " be iMproved, required
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.config/nvim/bundle/Vundle.vim
call vundle#begin()

" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'
Plugin 'crusoexia/vim-monokai' " Color theme
Plugin 'sheerun/vim-polyglot' " Overall language support
Plugin 'scrooloose/nerdtree' " File explorer
Plugin 'vim-airline/vim-airline' " Navbar
Plugin 'vim-airline/vim-airline-themes' " Colours for Navbar
Plugin 'benmills/vimux' " Easy interaction with tmux
Plugin 'tomtom/tcomment_vim' " Commenting & Uncommenting stuff
Plugin 'kien/ctrlp.vim' " Fuzzy finder for files, etc.
Plugin 'junegunn/fzf.vim' " Along with the_silver_searcher => search stuff. TODO
Plugin 'tpope/vim-surround' " quoting/parenthesizing made simple
Plugin 'tpope/vim-dispatch' " Asynchronous build and test dispatcher

Plugin 'tpope/vim-fugitive' " Git tools
set diffopt+=vertical

Plugin 'airblade/vim-gitgutter' " Shows a git diff in the gutter
let g:gitgutter_enabled = 1
let g:gitgutter_highlight_lines = 0
let g:gitgutter_realtime = 1
let g:gitgutter_eager = 1
set updatetime=100

Plugin 'Shougo/deoplete.nvim' " Dark powered asynchronous completion framework
let g:deoplete#enable_at_startup = 1

" Markdown
Plugin 'suan/vim-instant-markdown'

" Ruby
Plugin 'vim-ruby/vim-ruby' " Syntax highlighting for Ruby.
Plugin 'tpope/vim-endwise' " Adds closing tags for Ruby

" Elixir
Plugin 'elixir-editors/vim-elixir' " Syntax highlighting and indentation.
Plugin 'slashmili/alchemist.vim' " Gotodef, autocomplete and tooling.
let g:alchemist_tag_map = '<C-]>'
let g:alchemist_tag_stack_map = '<C-[>'

" Clojure
Plugin 'guns/vim-clojure-static' " Meikel Brandmeyer's excellent Clojure runtime files.
Plugin 'guns/vim-clojure-highlight' "Extend builtin syntax highlighting to referred and aliased vars in Clojure buffers
autocmd BufRead *.clj try | silent! Require | catch /^Fireplace/ | endtry " Evaluate Clojure buffers on load
Plugin 'kien/rainbow_parentheses.vim' " Better Rainbow Parentheses
Plugin 'tpope/vim-fireplace' " Clojure REPL support.
"Plugin 'tpope/vim-salve' " Static Vim support for Leiningen and Boot.

" Javascript/HTML/CSS
Plugin 'pangloss/vim-javascript'
Plugin 'mxw/vim-jsx'
Plugin 'elzr/vim-json'
Plugin 'othree/html5.vim'
Plugin 'hail2u/vim-css3-syntax'
Plugin 'cakebaker/scss-syntax.vim'

" PHP/Twig
Plugin 'lumiliet/vim-twig'

" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required

" Map NerdTree toggle to F6
nmap <F6> :NERDTreeToggle<CR>
" Shuts vim if NerdTree is the last window left
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
" Starts NERDTree at the start.
autocmd vimenter * NERDTree
let NERDTreeShowHidden=1

syntax on
colorscheme monokai

" Show trailing whitespace and spaces before a tab:
:highlight ExtraWhitespace ctermbg=red guibg=red
:autocmd Syntax * syn match ExtraWhitespace /\s\+$\| \+\ze\\t/

" vim-ruby configuration
:let ruby_fold = 1
:let ruby_spellcheck_strings = 1

set foldmethod=syntax
set nofoldenable " Files don't start folded
set nu
set backspace=indent,eol,start
set tabstop=2
set nosmartindent
set autoindent
set cursorline " highlight the current line the cursor is on
set cuc cul    " highlight the current column the cursor is on

set laststatus=2 " Shows the current status of the file.
set expandtab
set shiftwidth=2
set softtabstop=2

" Numbers
set number
set numberwidth=5

" Searching
set hlsearch " Highlights the areas that you search for.
set incsearch " Searches incrementally as you type.
set ignorecase
set smartcase " If you start writing in camel case, it will assume that you want camelcased. Otherwise it will be case insensative.

"sm: flashes matching brackets or parentheses
set showmatch

" Softtabs, 2 spaces
set tabstop=2
set shiftwidth=2
set shiftround
set expandtab
set smarttab

set clipboard=unnamed " Copy&Paste works with the system too.

" Display extra whitespace
set list listchars=tab:»·,trail:·,nbsp:·

" When scrolling off-screen do so 3 lines at a time, not 1
set scrolloff=3

" Open new split panes to right and bottom, which feels more natural
set splitbelow
set splitright

" My leader key
let mapleader=","

" Buffer switching
map <leader>p :bp<CR> " ,p previous buffer
map <leader>n :bn<CR> " ,n next buffer
nmap <Leader><CR> :nohlsearch<cr>
noremap <Leader>rx :!ruby %<CR>
noremap <Leader>re :!ruby %·

" (Vimux plugin) Run a command in a tmux panel
map <Leader>rb :call VimuxRunCommand("clear; rspec " . bufname("%"))<CR>
map <Leader>rc :call VimuxRunCommand("clear; lein test ")<CR>
map <Leader>vp :VimuxPromptCommand<CR>
map <Leader>vl :VimuxRunLastCommand<CR>
map <Leader>vq :VimuxCloseRunner<CR>

" don't complain on some obvious fat-fingers
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
