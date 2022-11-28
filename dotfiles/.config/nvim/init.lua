---@diagnostic disable: undefined-global

-- encoding
vim.o.encoding = "utf-8"
vim.o.fileencoding = "utf-8"

-- timeouts
vim.o.ttyfast = true -- we have a fast terminal
vim.o.ttimeout = true --time out for key codes
vim.o.ttimeoutlen = 100 -- wait up to 100ms after Esc for special key
vim.o.lazyredraw = true

-- safety net
vim.o.undofile = true -- store undos on disk
vim.o.updatetime = 300 -- flush swap files to disk on a regular basis

-- search and replace
vim.o.showmatch = true -- sm: flashes matching brackets or parentheses
vim.o.hlsearch = true -- Highlights the areas that you search for.
vim.o.incsearch = true --Searches incrementally as you type.
vim.o.ignorecase = true -- ignore case when searching
vim.o.smartcase = true -- smarter search case
vim.o.wildignorecase = true -- ignore case in file completion
vim.o.wildignore = "" -- remove default ignores
vim.o.wildignore = vim.o.wildignore .. "*.o,*.obj,*.so,*.a,*.dylib,*.pyc,*.hi" -- ignore compiled files
vim.o.wildignore = vim.o.wildignore .. "*.zip,*.gz,*.xz,*.tar,*.rar" -- ignore compressed files
vim.o.wildignore = vim.o.wildignore .. "*/.git/*,*/.hg/*,*/.svn/*" -- ignore SCM files
vim.o.wildignore = vim.o.wildignore .. "*.png,*.jpg,*.jpeg,*.gif" -- ignore image files
vim.o.wildignore = vim.o.wildignore .. "*.pdf,*.dmg" -- ignore binary files
vim.o.wildignore = vim.o.wildignore .. ".*.sw*,*~" -- ignore editor files
vim.o.wildignore = vim.o.wildignore .. ".DS_Store" -- ignore OS files

-- folding
vim.o.foldmethod = "expr"
vim.o.foldexpr = "nvim_treesitter#foldexpr()"
vim.o.nofoldenable = true
vim.o.nosmartindent = true
vim.o.autoindent = true
vim.o.cursorline = true
--vim.o.cuc cul    " highlight the current column the cursor is on

-- spacing
vim.o.backspace = "indent,eol,start"
vim.o.laststatus = 2 -- Shows the current status of the file.
vim.o.expandtab = true -- Replaces a <TAB> with spaces
vim.o.shiftwidth = 2 -- The amount to block indent when using < and >
vim.o.shiftround = true -- Shift to the next round tab stop
vim.o.tabstop = 2 -- 2 space tab
vim.o.softtabstop = 2 -- Causes backspace to delete 2 spaces = converted <TAB>
vim.o.smarttab = true -- Uses shiftwidth instead of tabstop at start of lines

-- numbers in the side
vim.o.nu = true
vim.o.number = true
vim.o.numberwidth = 5

-- copy&paste works with the system too.
-- @see https://vim.fandom.com/wiki/Accessing_the_system_clipboard
vim.o.clipboard = "unnamedplus" -- In case of Linux
-- set clipboard=unnamed " This would be for OSx.

-- when scrolling off-screen do so 3 lines at a time, not 1
vim.o.scrolloff = 3

-- open new split panes to right and bottom, which feels more natural
vim.o.splitbelow = true
vim.o.splitright = true

vim.o.diffopt = vim.o.diffopt .. "vertical"

vim.g.mapleader = ";"
vim.g.maplocalleader = ";"

-- mappings
for _, mapping in ipairs({
  -- leader
  { "n", "<leader>vs", "<cmd>luafile ~/.config/nvim/init.lua<cr>:PackerCompile<cr>" }, -- vim reload
  { "n", "<leader>vu", "<cmd>luafile ~/.config/nvim/init.lua<cr>:PackerSync<cr>" }, -- vim update
  -- save current buffer
  { "n", "<cr>", "<cmd>w<cr>" },
  -- better `j` and `k`
  { "n", "j", "gj" },
  { "v", "j", "gj" },
  { "n", "k", "gk" },
  { "v", "k", "gk" },
  -- copy from the cursor to the end of line using Y (matches D behavior)
  { "n", "Y", "y$" },
  -- keep the cursor in place while joining lines
  { "n", "J", "mZJ`Z" },
  -- reselect visual block after indent
  { "v", "<", "<gv" },
  { "v", ">", ">gv" },
  -- clean screen and reload file
  { "n", "<c-l>", "<cmd>nohl<cr>:redraw<cr>:checktime<cr><c-l>gjgk" },
  -- emulate permanent global marks
  { "n", "<leader>nc", "<cmd>edit ~/.config/nvim/init.lua<cr>" },
  -- Ctrl + r: rename over file
  { "n", "<C-r>nc", "hy:%s/<C-r>h//gc<left><left><left>" },
  -- absolute path (/something/src/foo.txt)
  { "n", "<leader>cF", "let @+=expand(\"%:p\")<CR>" },
  -- relative path
  { "n", "<leader>cf", "let @+=expand(\"%\")<CR>" },
  -- keep the cursor in place while joining lines
  { "n", "J", "mZJ`Z" }
}) do
  vim.api.nvim_set_keymap(mapping[1], mapping[2], mapping[3], { noremap = true, silent = true })
end

-- " Toggle if in OSx
-- " let g:python2_host_prog = '/usr/bin/python'
-- " let g:python3_host_prog = '/usr/bin/python3'

-- " set list listchars=tab:»·,trail:·,nbsp:· " Display extra whitespace

-- " Show trailing whitespace and spaces before a tab:
-- highlight ExtraWhitespace ctermbg=red guibg=red
-- autocmd Syntax * syn match ExtraWhitespace /\s\+$\| \+\ze\\t/


-- " Highlights with a small shadow all code surpassing 80 characters.
-- highlight OverLength ctermbg=red ctermfg=white guibg=#592929
-- match OverLength /\%81v.\+/

-- " In case you use :terminal, bring back ESC
-- :tnoremap <Esc> <C-\><C-n>
require("packer").startup(function(use)
  -- theme
  use({ 'projekt0n/github-nvim-theme',
    config = function()
      vim.o.termguicolors = true
      require('github-theme').setup({
        theme_style = "dark",
      })
    end
  })

  -- speed up loading Lua modules in Neovim to improve startup time
  use('lewis6991/impatient.nvim')

  -- speed up Vim by updating folds only when called-for
  use({ "Konfekt/FastFold",
    config = function()
      vim.g.fastfold_savehook = 1
      vim.g.fastfold_fold_command_suffixes = { 'x', 'X', 'a', 'A', 'o', 'O', 'c', 'C' }
      vim.g.fastfold_fold_movement_commands = { ']z', '[z', 'zj', 'zk' }
    end
  })

  use({ 'vim-test/vim-test',
    config = function()
      vim.api.nvim_set_keymap("n", "<leader>te", "TestNearest<CR>", { noremap = true, silent = true })
      vim.api.nvim_set_keymap("n", "<leader>Te", "TestFile<CR>", { noremap = true, silent = true })
    end
  })

  use({ 'numToStr/Comment.nvim',
    config = function()
      require('Comment').setup()
    end
  })

  -- change parentheses and what not with more ease
  use('tpope/vim-surround')

  -- floating terminal
  use({ 's1n7ax/nvim-terminal',
    config = function()
      vim.o.hidden = true -- this is needed to be set to reuse terminal between toggles
      require('nvim-terminal').setup({
        toggle_keymap = '<leader>tt',
        increase_height_keymap = '<leader>t=',
        decrease_height_keymap = '<leader>t-',
        window_height_change_amount = 25,
      })
    end
  })

  use({ "nvim-neo-tree/neo-tree.nvim",
    branch = "v2.x",
    requires = {
      "nvim-lua/plenary.nvim",
      "nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
      "MunifTanjim/nui.nvim",
    },
    config = function()
      -- Unless you are still migrating, remove the deprecated commands from v1.x
      vim.cmd([[ let g:neo_tree_remove_legacy_commands = 1 ]])
      vim.api.nvim_set_keymap("n", "<leader>o", "<cmd>Neotree focus<cr>", { noremap = true, silent = true })
      vim.api.nvim_set_keymap("n", "<leader>e", "<cmd>Neotree toggle<cr>", { noremap = true, silent = true })
      vim.api.nvim_set_keymap("n", "-", "<cmd>Neotree reveal<cr>", { noremap = true, silent = true })
    end
  })

  -- icons for all
  use('nvim-tree/nvim-web-devicons')

  use({ 'nvim-telescope/telescope.nvim',
    tag = '0.1.0',
    requires = { { 'nvim-lua/plenary.nvim' } },
    config = function()
      local builtin = require('telescope.builtin')
      vim.keymap.set('n', '<leader>ff', builtin.find_files, {})
      vim.keymap.set('n', '<leader>fg', builtin.live_grep, {})
      vim.keymap.set('n', '<leader>fb', builtin.buffers, {})
      vim.keymap.set('n', '<leader>fh', builtin.help_tags, {})
    end
  })

  -- pretty diagnostics
  use({ "folke/trouble.nvim",
    requires = "kyazdani42/nvim-web-devicons",
    config = function()
      require("trouble").setup {}

      vim.api.nvim_set_keymap("n", "<leader>xx", "<cmd>TroubleToggle<cr>")
      vim.api.nvim_set_keymap("n", "<leader>xw", "<cmd>TroubleToggle workspace_diagnostics<cr>")
      vim.api.nvim_set_keymap("n", "<leader>xd", "<cmd>TroubleToggle document_diagnostics<cr>")
      vim.api.nvim_set_keymap("n", "<leader>xq", "<cmd>TroubleToggle quickfix<cr>")
      vim.api.nvim_set_keymap("n", "<leader>xl", "<cmd>TroubleToggle loclist<cr>")
    end
  })

  -- a tree like view for symbols in Neovim
  use({ 'simrat39/symbols-outline.nvim',
    config = function()
      require("symbols-outline").setup()
      vim.api.nvim_set_keymap("n", "<leader>m", "<cmd>SymbolsOutline<cr>")
    end
  })

  -- git wrapper
  use({ 'tpope/vim-fugitive',
    config = function()
      vim.api.nvim_set_keymap("n", "<Leader>gs", "<CMD>Git<CR>")
    end
  })

  -- git integration for buffers
  use({ 'lewis6991/gitsigns.nvim',
    config = function()
      require('gitsigns').setup()
    end
  })

  -- ui for nvim-lsp progress
  use({ 'j-hui/fidget.nvim',
    config = function()
      require "fidget".setup()
    end
  })

  use({ 'nvim-treesitter/nvim-treesitter',
    config = function()
      require 'nvim-treesitter.configs'.setup {
        ensure_installed = { "lua", "go", "elixir", "javascript", "typescript" },
      }
    end
  })

  use({ "neovim/nvim-lspconfig", -- neovim lsp config plugin
    requires = {
      "hrsh7th/nvim-cmp", -- completion plugin
      "hrsh7th/vim-vsnip", -- snippet plugin
      -- completion source plugins
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-cmdline",
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-nvim-lsp-signature-help",
      "hrsh7th/cmp-path",
      "hrsh7th/cmp-vsnip",
      -- lsp
      "williamboman/mason-lspconfig.nvim",
      "williamboman/mason.nvim",
    },
    config = function()
      local cmp = require("cmp")

      cmp.setup({
        completion = { completeopt = "menu,menuone,noinsert" },
        experimental = { ghost_text = true },
        preselect = cmp.PreselectMode.None,
        window = { documentation = cmp.config.window.bordered() },

        snippet = {
          expand = function(args)
            vim.fn["vsnip#anonymous"](args.body)
          end,
        },

        mapping = {
          ["<tab>"] = cmp.mapping(cmp.mapping.confirm({ select = true }), { "i" }),
          ["<C-n>"] = cmp.mapping(
            cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Insert }),
            { "i" }
          ),
          ["<C-p>"] = cmp.mapping(
            cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Insert }),
            { "i" }
          ),
          ["<C-d>"] = cmp.mapping(cmp.mapping.scroll_docs(4), { "i" }),
          ["<C-u>"] = cmp.mapping(cmp.mapping.scroll_docs(-4), { "i" }),
        },

        sources = cmp.config.sources({
          { name = "nvim_lsp" },
          { name = "nvim_lsp_signature_help" },
        }, {
          { name = "path" },
        }, {
          { name = "buffer" },
        }),
      })

      local capabilities = require("cmp_nvim_lsp").default_capabilities()

      local flags = { debounce_text_changes = 150 }

      local handlers = {
        ["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, { border = "rounded" }),
      }

      local on_attach = function(client, bufnr)
        local opts = { noremap = true, silent = true }
        vim.api.nvim_buf_set_option(bufnr, "omnifunc", "v:lua.vim.lsp.omnifunc")

        local function map(...)
          vim.api.nvim_buf_set_keymap(bufnr, ...)
        end

        local map_opts = { noremap = true, silent = true }

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

      for _, lsp in pairs({
        "gopls",
        "svelte",
        "tsserver",
      }) do
        require("lspconfig")[lsp].setup({
          capabilities = capabilities,
          flags = flags,
          handlers = handlers,
          on_attach = on_attach,
        })
      end

      require("mason").setup()
      require("mason-lspconfig").setup({ automatic_installation = true })
    end,
  })

  -- TODO: do we want this as opposed to vim-fugitive?
  -- use({ 'TimUntersberger/neogit', requires = 'nvim-lua/plenary.nvim' })

  -- TODO
  -- To register mappings
  -- use({ 'mrjones2014/legendary.nvim' })
  -- To improve UI boxes
  -- use({ 'stevearc/dressing.nvim' })

  -- TODO: 'junegunn/fzf.vim'... instead of telescope?
  -- TODO: snippets: hrsh7th/vim-vsnip, or check astrovim
end)