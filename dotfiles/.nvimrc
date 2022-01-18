set nocompatible              " be iMproved, required
filetype off                  " required

"-------------------
" Leader mappings
"-------------------
let mapleader=";"

" Quickly open/source .nvimrc in new tab
nnoremap <leader>nc :tabedit ~/repositories/dotfiles/dotfiles/.nvimrc<CR>
nnoremap <leader>nr :source ~/.config/nvim/init.vim<CR>

" Buffer switching
map <leader>p :bp<CR>
map <leader>n :bn<CR>

" In case you use :terminal, bring back ESC
:tnoremap <Esc> <C-\><C-n>

" Ctrl + r: rename over file
vnoremap <C-r> "hy:%s/<C-r>h//gc<left><left><left>

" absolute path (/something/src/foo.txt)
nnoremap <leader>cF :let @+=expand("%:p")<CR>

" relative path (src/foo.txt)
nnoremap <leader>cf :let @+=expand("%")<CR>

" :IX commands copies full file to ix.io, and places the URL in the clipboard
command! -range=% IX  <line1>,<line2>w !curl -F 'f:1=<-' ix.io | tr -d '\n' | xclip -i -selection clipboard

" Some easy remaps
nnoremap <Leader>q :q<CR>
nnoremap <Leader>w :w<CR>
nnoremap <Leader>wq :wq<CR>
nnoremap <Leader>qq :qa!<CR>
nnoremap <Leader>b <c-t>
nnoremap gb <c-t>

" maximize the window
nmap <Leader>wm <C-W>_ <C-W>\|

"-------------------------
" General purpose plugins
"-------------------------
" set the runtime path to include Vundle and initialize
call plug#begin('~/.local/share/nvim/plugged')

" Replacement for the included filetype.vim that is sourced on startup.
Plug 'nathom/filetype.nvim'
" Color Themes
" Plug 'crusoexia/vim-monokai' " Color theme
Plug 'arcticicestudio/nord-vim'
" Language support
Plug 'sheerun/vim-polyglot' " Overall language support
" Airline, duh!
Plug 'vim-airline/vim-airline' " Navbar
Plug 'vim-airline/vim-airline-themes' " Colours for Navbar
" let g:airline_powerline_fonts = 1
" let g:airline_theme='nord'

Plug 'tomtom/tcomment_vim' " Commenting & Uncommenting stuff
Plug 'tpope/vim-surround' " quoting/parenthesizing made simple
Plug 'tpope/vim-dispatch' " Asynchronous build and test dispatcher\

" Creating new tabd
Plug 'gcmt/taboo.vim'
map <leader>tn :TabooOpen
map <leader>tr :TabooRename

Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'

" Map it to ctrl+p and leader+s
nnoremap <C-p> :<C-u>FZF<CR>
nnoremap <leader>s :<C-u>FZF<CR>

" Configure fzf so shortcuts match with vim split defaults
let g:fzf_action = {
  \ 'ctrl-t': 'tab split',
  \ 'ctrl-s': 'split',
  \ 'ctrl-v': 'vsplit' }

" --hidden makes ag not skip the hidden files when searching
let $FZF_DEFAULT_COMMAND = 'rg --files --hidden --glob "!.git/"'

" Configure :Ag to exclude file names. Search only contents.
command! -bang -nargs=* Ag call fzf#vim#ag(<q-args>, {'options': '--no-sort --delimiter : --nth 4..'}, <bang>0)
command! -bang -nargs=* AgFuzzy call fzf#vim#ag(<q-args>, {'options': '--delimiter : --nth 4..'}, <bang>0)

" Search file name with preview
nmap <Leader>f :Files<CR>

" Search file contents
nmap <Leader>c :AgFuzzy<CR>

" Search in current file's lines
nmap <Leader>l :BLines<CR>

" Plug 'wesQ3/vim-windowswap'
"
" Plug 'junegunn/goyo.vim'
" g:goyo_width = 150

" Plug 'Shougo/deoplete.nvim' " Dark powered asynchronous completion framework
" let g:deoplete#enable_at_startup = 1

"-------------------
" Vimux
"-------------------
Plug 'benmills/vimux' " Easy interaction with tmux
let g:VimuxUseNearest = 0
map <Leader>te :call VimuxRunCommand("clear; mix test " . bufname("%"))<CR>
map <Leader>tg :call VimuxRunCommand("clear; go test " . expand("%:p:h"))<CR>

map <Leader>vp :VimuxPromptCommand<CR>
map <Leader>vl :VimuxRunLastCommand<CR>
map <Leader>vq :VimuxCloseRunner<CR>

"-------------------
" Directory management
"-------------------
Plug 'justinmk/vim-dirvish'
Plug 'kristijanhusak/vim-dirvish-git'
Plug 'tpope/vim-eunuch'
let g:dirvish_mode = ':sort ,^.*[\/],'
map <C-\> :Dirvish<CR>
" TODO https://github.com/fsharpasharp/vim-dirvinist

"-------------------
" Git
"-------------------
Plug 'rbong/vim-flog'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-rhubarb'
set diffopt+=vertical

" fugitive shortcuts
" Working with maps: https://github.com/tpope/vim-fugitive/blob/master/doc/fugitive.txt#L252
nmap <Leader>gs :Git<CR>
nmap <Leader>gc :Git commit<CR>
nmap <Leader>gp :Git shove<CR>
nmap <Leader>gb :Git blame<CR>
nmap <Leader>gl :Git log<CR>
nmap <Leader>gll :Gllog<CR>
nmap <Leader>gx :GBrowse<CR>

" Write to the current file's path and stage the results.
nmap <Leader>gw :Gwrite<CR>

" Not removing yet, but testing out gitsigns.nvim
" Plug 'airblade/vim-gitgutter' " Shows a git diff in the gutter
" let g:gitgutter_enabled = 0
" let g:gitgutter_highlight_lines = 0
" let g:gitgutter_realtime = 1
" let g:gitgutter_eager = 1
" set updatetime=100
"
" " Navigate git hunks
" nmap ]h <Plug>(GitGutterNextHunk)
" nmap [h <Plug>(GitGutterPrevHunk)

Plug 'lewis6991/gitsigns.nvim'
nmap <Leader>gl :Gitsigns toggle_linehl<CR>

"-------------------
" Random pluging to make stuff load faster
" -----------------
Plug 'lewis6991/impatient.nvim'

"-------------------
" Built-in LSP
" -----------------
Plug 'neovim/nvim-lspconfig'
Plug 'hrsh7th/nvim-compe'
Plug 'hrsh7th/vim-vsnip'
Plug 'hrsh7th/vim-vsnip-integ'

"-------------------
" Telescope
" -----------------
Plug 'nvim-lua/popup.nvim'
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'

" Find files using Telescope command-line sugar.
nnoremap <leader>ff <cmd>Telescope find_files<cr>
nnoremap <leader>fg <cmd>Telescope live_grep<cr>
nnoremap <leader>fb <cmd>Telescope buffers<cr>
nnoremap <leader>fh <cmd>Telescope help_tags<cr>

"-------------------
" Treesitter
" -----------------
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}

"-------------------
" Elixir
"-------------------
" Plug 'elixir-editors/vim-elixir' " Syntax highlighting and indentation.
imap fpp \|><space>

"-------------------
" PHP
"-------------------
Plug 'stephpy/vim-php-cs-fixer'
let g:php_cs_fixer_path = "~/.composer/vendor/bin/php-cs-fixer"
autocmd BufWritePost *.php silent! call PhpCsFixerFixFile()
nnoremap <silent><leader>pcf :call PhpCsFixerFixFile()<CR>

" All of your Plugins must be added before the following line
call plug#end()

lua << EOF
require('gitsigns').setup {
  signcolumn = true,  -- Toggle with `:Gitsigns toggle_signs`
  numhl      = true, -- Toggle with `:Gitsigns toggle_numhl`
  linehl     = false, -- Toggle with `:Gitsigns toggle_linehl`
  word_diff  = false, -- Toggle with `:Gitsigns toggle_word_diff`
}

local lspconfig = require("lspconfig")

-- Neovim doesn't support snippets out of the box, so we need to mutate the
-- capabilities we send to the language server to let them know we want snippets.
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = true

-- Setup our autocompletion. These configuration options are the default ones
-- copied out of the documentation.
require "compe".setup {
  enabled = true,
  autocomplete = true,
  debug = false,
  min_length = 1,
  preselect = "disabled",
  throttle_time = 80,
  source_timeout = 200,
  incomplete_delay = 400,
  max_abbr_width = 100,
  max_kind_width = 100,
  max_menu_width = 100,
  documentation = true,
  source = {
    path = true,
    buffer = true,
    calc = true,
    vsnip = true,
    nvim_lsp = true,
    nvim_lua = true,
    spell = true,
    tags = true,
    treesitter = true
  }
}

-- A callback that will get called when a buffer connects to the language server.
-- Here we create any key maps that we want to have on that buffer.
local on_attach = function(_, bufnr)
  local function map(...)
    vim.api.nvim_buf_set_keymap(bufnr, ...)
  end

  local map_opts = {noremap = true, silent = true}

  map("n", "ff", "<cmd>lua vim.lsp.buf.formatting()<cr>", map_opts)
  map("n", "fi", "<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<cr>", map_opts)
  map("n", "fo", "<cmd>lua require'telescope.builtin'.lsp_code_actions{}<cr>", map_opts)

  map('n', '<space>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>', map_opts)
  map("n", "gy", "<cmd>lua vim.lsp.buf.definition()<cr>", map_opts)
  map("n", "gk", "<cmd>lua vim.lsp.buf.hover()<cr>", map_opts)
  map("n", "gD", "<cmd>lua vim.lsp.buf.implementation()<cr>", map_opts)
  map("n", "1gD", "<cmd>lua vim.lsp.buf.type_definition()<cr>", map_opts)
  map('n', '<F2>', '<cmd>lua vim.lsp.buf.rename()<CR>', map_opts)
  map("n", "go", "<cmd>lua require'telescope.builtin'.lsp_references{}<cr>", map_opts)
  map('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', map_opts)
  map("n", "g0", "<cmd>lua require'telescope.builtin'.lsp_document_symbols{}<cr>", map_opts)
  map("n", "gW", "<cmd>lua require'telescope.builtin'.lsp_workspace_symbols{}<cr>", map_opts)

  map('n', '[d', '<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>', map_opts)
  map('n', ']d', '<cmd>lua vim.lsp.diagnostic.goto_next()<CR>', map_opts)
  map('n', '<space>q', '<cmd>lua vim.lsp.diagnostic.set_loclist()<CR>', map_opts)
end

lspconfig.elixirls.setup({
  cmd = {vim.fn.expand("~/.elixir-ls/release/language_server.sh")},
  capabilities = capabilities,
  on_attach = on_attach,
  settings = {
    elixirLS = {
      dialyzerEnabled = false,
      fetchDeps = false
    }
  }
})

lspconfig.gopls.setup {
    cmd = {"gopls", "serve"},
    on_attach = on_attach,
    settings = {
      gopls = {
        analyses = {
          unusedparams = true,
        },
        staticcheck = true,
      },
    },
  }


lspconfig.phpactor.setup {
  on_attach = on_attach,
}

lspconfig.tsserver.setup{
  on_attach = on_attach,
}

-- Need to toggle comment on this one/tsserver when working on a Deno project.
-- Better solution pending.
-- https://github.com/neovim/nvim-lspconfig/wiki/Project-local-settings
-- https://www.reddit.com/r/neovim/comments/pnl2zs/how_do_you_stop_lsp_clients/
--lspconfig.denols.setup{
--  on_attach = on_attach,
--}

-- https://github.com/lighttiger2505/sqls
lspconfig.sqls.setup{
  on_attach = on_attach,
}
EOF

" Configure the tree sitter
lua <<EOF
require("nvim-treesitter.configs").setup {
  highlight = {enable = true},
  indent = {enable = true}
}
EOF

" This has to be called after plug#end
" call deoplete#custom#option('sources', { 'go': ['ale'], 'typescript': ['ale']})

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
" let g:python2_host_prog = '/usr/bin/python'
" let g:python3_host_prog = '/usr/bin/python3'

" set list listchars=tab:»·,trail:·,nbsp:· " Display extra whitespace

" Show trailing whitespace and spaces before a tab:
highlight ExtraWhitespace ctermbg=red guibg=red
autocmd Syntax * syn match ExtraWhitespace /\s\+$\| \+\ze\\t/

" copy from the cursor to the end of line using Y (matches D behavior)
nnoremap <silent> Y y$

" keep the cursor in place while joining lines
nnoremap <silent> J mZJ`Z

" performance
set lazyredraw " only redraw when needed
if exists('&ttyfast') | set ttyfast | endif " we have a fast terminal

set foldmethod=expr
set foldexpr=nvim_treesitter#foldexpr()
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

set wildignorecase " ignore case in file completion
set wildignore= " remove default ignores
set wildignore+=*.o,*.obj,*.so,*.a,*.dylib,*.pyc,*.hi " ignore compiled files
set wildignore+=*.zip,*.gz,*.xz,*.tar,*.rar " ignore compressed files
set wildignore+=*/.git/*,*/.hg/*,*/.svn/* " ignore SCM files
set wildignore+=*.png,*.jpg,*.jpeg,*.gif " ignore image files
set wildignore+=*.pdf,*.dmg " ignore binary files
set wildignore+=.*.sw*,*~ " ignore editor files
set wildignore+=.DS_Store " ignore OS files
set wildmenu " better command line completion menu
set wildmode=full " ensure better completion

"-------------------
" Colors
"-------------------
syntax on
" colorscheme monokai
colorscheme nord

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

set encoding=UTF-8

"-------------------
" Other remappings
"-------------------
" https://vim.fandom.com/wiki/Avoid_the_escape_key
imap jj <Esc>
