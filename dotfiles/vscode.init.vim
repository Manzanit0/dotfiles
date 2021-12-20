"-------------------
" Leader mappings
"-------------------
let mapleader=";"

"-------------------
" VS Code Native Commands
" @see https://marketplace.visualstudio.com/items?itemName=asvetliakov.vscode-neovim
"-------------------
if exists('g:vscode')
  " Core editor actions
  nnoremap - <Cmd>call VSCodeNotify('workbench.view.explorer')<CR>
  nnoremap <Leader>c <Cmd>call VSCodeNotify('workbench.action.findInFiles')<CR>
  nnoremap <Leader>s <Cmd>call VSCodeNotify('workbench.action.quickOpen')<CR>
  nnoremap <Leader>d <Cmd>call VSCodeNotify('workbench.action.showCommands')<CR>
  nnoremap <Leader>f <Cmd>call VSCodeNotify('actions.find')<CR>
  nnoremap <Leader>r <Cmd>call VSCodeNotify('editor.action.startFindReplaceAction')<CR>
  nnoremap <Leader>b <Cmd>call VSCodeNotify('workbench.action.toggleSidebarVisibility')<CR>
  nnoremap <Leader>w <Cmd>call VSCodeNotify('workbench.action.files.save')<CR>
  nnoremap <Leader>cf <Cmd>call VSCodeNotify('copyRelativeFilePath')<CR> " Depends on FileUtils extension

  " Code navigation
  nnoremap gy <Cmd>call VSCodeNotify('editor.action.revealDefinition')<CR>
  nnoremap gu <Cmd>call VSCodeNotify('editor.action.goToImplementation')<CR>
  nnoremap go <Cmd>call VSCodeNotify('editor.action.goToReferences')<CR>
  nnoremap gk <Cmd>call VSCodeNotify('editor.action.showHover')<CR>
  nnoremap gb <Cmd>call VSCodeNotify('workbench.action.navigateBack')<CR>


  " Code actions
  nnoremap fi <Cmd>call VSCodeNotify('editor.action.quickFix')<CR>
  nnoremap fs <Cmd>call VSCodeNotify('editor.action.insertSnippet')<CR>
  nnoremap ff <Cmd>call VSCodeNotify('editor.action.formatDocument')<CR>
  nnoremap fr <Cmd>call VSCodeNotify('editor.action.startFindReplaceAction')<CR>
  nnoremap qf <Cmd>call VSCodeNotify('keyboard-quickfix.openQuickFix')<CR>

  " Git helpers
  nnoremap <Leader>gg <Cmd>call VSCodeNotify('workbench.view.scm')<CR>

  " To make folds work
  nnoremap zM :call VSCodeNotify('editor.foldAll')<CR>
  nnoremap zR :call VSCodeNotify('editor.unfoldAll')<CR>
  nnoremap zc :call VSCodeNotify('editor.fold')<CR>
  nnoremap zC :call VSCodeNotify('editor.foldRecursively')<CR>
  nnoremap zo :call VSCodeNotify('editor.unfold')<CR>
  nnoremap zO :call VSCodeNotify('editor.unfoldRecursively')<CR>
  nnoremap za :call VSCodeNotify('editor.toggleFold')<CR>
  nnoremap j :call VSCodeCall('cursorDown')<CR>
  nnoremap k :call VSCodeCall('cursorUp')<CR>
endif

"-------------------
" General config
"-------------------
set ttimeout        " time out for key codes
set ttimeoutlen=100 " wait up to 100ms after Esc for special key

" Use <C-L> to clear the highlighting of :set hlsearch.
if maparg('<C-L>', 'n') ==# ''
  nnoremap <silent> <C-L> :nohlsearch<C-R>=has('diff')?'<Bar>diffupdate':''<CR><CR><C-L>
endif

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

set encoding=UTF-8
