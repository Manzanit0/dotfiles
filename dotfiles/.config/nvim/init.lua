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
vim.g.nosmartindent = true
vim.o.autoindent = true
vim.o.cursorline = true

-- TODO: need to look how to set this... apparently it's not vim.o.nofoldenable.
vim.cmd [[ set nofoldenable ]]

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

-- vim.o.diffopt = vim.o.diffopt .. "vertical"

vim.g.mapleader = ";"
vim.g.maplocalleader = ";"

-- tpope/vim-unimpaired uses '[' and ']', however, they're not too comfortable on my
-- layout. '<' and '>' are much better.
vim.cmd [[
  nmap < [
  nmap > ]
  omap < [
  omap > ]
  xmap < [
  xmap > ]
]]

-- In case you use :terminal, bring back ESC.
vim.cmd [[ tnoremap <Esc> <C-\><C-n> ]]

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
  { "n", "J", "mZJ`Z" },
  { "n", "<leader>qq", ":qa!<CR>" },
}) do
  vim.keymap.set(mapping[1], mapping[2], mapping[3], { noremap = true, silent = true })
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

local ensure_packer = function()
  local fn = vim.fn
  local install_path = fn.stdpath('data') .. '/site/pack/packer/start/packer.nvim'
  if fn.empty(fn.glob(install_path)) > 0 then
    fn.system({ 'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path })
    vim.cmd [[packadd packer.nvim]]
    return true
  end
  return false
end

local packer_bootstrap = ensure_packer()

require("packer").startup(function(use)
  use('wbthomason/packer.nvim', { opt = true })

  -- theme
  use({ "projekt0n/github-nvim-theme",
    config = function()
      vim.o.termguicolors = true
      require('github-theme').setup({
        theme_style = "dark",
      })
    end
  })

  -- speed up loading Lua modules in Neovim to improve startup time
  use({ "lewis6991/impatient.nvim",
    config = function()
      require("impatient")
    end
  })

  -- speed up Vim by updating folds only when called-for
  use({ "Konfekt/FastFold",
    config = function()
      vim.g.fastfold_savehook = 1
      vim.g.fastfold_fold_command_suffixes = { 'x', 'X', 'a', 'A', 'o', 'O', 'c', 'C' }
      vim.g.fastfold_fold_movement_commands = { ']z', '[z', 'zj', 'zk' }
    end
  })

  use({ "vim-test/vim-test",
    config = function()
      vim.keymap.set("n", "<leader>te", "<cmd>TestNearest<CR>", { noremap = true, silent = true })
      vim.keymap.set("n", "<leader>Te", "<cmd>TestFile<CR>", { noremap = true, silent = true })
    end
  })

  use({ "numToStr/Comment.nvim",
    config = function()
      require('Comment').setup()
    end
  })

  -- change parentheses and what not with more ease
  use("tpope/vim-surround")

  -- navigate quickfix and location lists easier
  use("tpope/vim-unimpaired")

  -- floating terminal
  use({ "s1n7ax/nvim-terminal",
    config = function()
      vim.o.hidden = true -- this is needed to be set to reuse terminal between toggles
      require('nvim-terminal').setup({
        toggle_keymap = '<C-_>',
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

      vim.keymap.set("n", "<leader>o", "<cmd>Neotree focus<cr>", { noremap = true, silent = true })
      vim.keymap.set("n", "<leader>e", "<cmd>Neotree toggle<cr>", { noremap = true, silent = true })
      vim.keymap.set("n", "-", "<cmd>Neotree reveal<cr>", { noremap = true, silent = true })
      vim.keymap.set("n", "\\", "<cmd>Neotree toggle current reveal_force_cwd<cr>", { noremap = true, silent = true })

      require("neo-tree").setup({
        close_if_last_window = true,
        window = {
          position = "right",
        },
        filesystem = {
          hijack_netrw_behavior = "open_default",
          filtered_items = {
            visible = true,
            hide_dotfiles = false,
            hide_gitignored = false,
          },
          window = {
            mappings = {
              ["h"] = "toggle_hidden",
            }
          },
        }
      })
    end
  })

  -- icons for all
  use("nvim-tree/nvim-web-devicons")

  use({ "nvim-telescope/telescope.nvim",
    tag = '0.1.0',
    requires = { { 'nvim-lua/plenary.nvim' } },
    config = function()
      local builtin = require('telescope.builtin')
      vim.keymap.set("n", "<leader>ff", builtin.find_files, {})
      vim.keymap.set("n", "<leader>fg", builtin.live_grep, {})
      vim.keymap.set("n", "<leader>fb", builtin.buffers, {})
      vim.keymap.set("n", "<leader>fh", builtin.help_tags, {})

      local trouble = require("trouble.providers.telescope")
      local telescope = require("telescope")
      telescope.setup {
        defaults = {
          mappings = {
            i = { ["<c-t>"] = trouble.open_with_trouble },
            n = { ["<c-t>"] = trouble.open_with_trouble },
          },
        },
      }
    end
  })

  -- pretty diagnostics
  use({ "folke/trouble.nvim",
    requires = "kyazdani42/nvim-web-devicons",
    config = function()
      require("trouble").setup {}

      vim.keymap.set("n", "<leader>xx", "<cmd>TroubleToggle<cr>", { noremap = true, silent = true })
      vim.keymap.set("n", "<leader>xw", "<cmd>TroubleToggle workspace_diagnostics<cr>", { noremap = true, silent = true })
      vim.keymap.set("n", "<leader>xd", "<cmd>TroubleToggle document_diagnostics<cr>", { noremap = true, silent = true })
      vim.keymap.set("n", "<leader>xq", "<cmd>TroubleToggle quickfix<cr>", { noremap = true, silent = true })
      vim.keymap.set("n", "<leader>xl", "<cmd>TroubleToggle loclist<cr>", { noremap = true, silent = true })
      vim.keymap.set("n", "gR", "<cmd>TroubleToggle lsp_references<cr>", { silent = true, noremap = true })
    end
  })

  -- a tree like view for symbols in Neovim
  use({ "simrat39/symbols-outline.nvim",
    config = function()
      require("symbols-outline").setup()
      vim.keymap.set("n", "<leader>m", "<cmd>SymbolsOutline<cr>", { noremap = true, silent = true })
    end
  })

  -- git wrapper
  use({ "tpope/vim-fugitive",
    config = function()
      vim.keymap.set("n", "<Leader>gs", "<cmd>Git<cr>", { noremap = true, silent = true })
      vim.keymap.set("n", "<leader>gpu", "<cmd>Git push<cr>", { desc = "Git push" })
    end
  })

  -- git integration for buffers
  use({ "lewis6991/gitsigns.nvim",
    config = function()
      require('gitsigns').setup({
        on_attach = function(bufnr)
          local function map(mode, lhs, rhs, opts)
            opts = vim.tbl_extend('force', { noremap = true, silent = true }, opts or {})
            vim.api.nvim_buf_set_keymap(bufnr, mode, lhs, rhs, opts)
          end

          -- Navigation
          map('n', ']n', "&diff ? ']c' : '<cmd>Gitsigns next_hunk<CR>'", { expr = true })
          map('n', '[n', "&diff ? '[c' : '<cmd>Gitsigns prev_hunk<CR>'", { expr = true })
        end
      })
    end
  })

  -- ui for nvim-lsp progress
  use({ "j-hui/fidget.nvim",
    config = function()
      require "fidget".setup()
    end
  })

  use({ "nvim-treesitter/nvim-treesitter",
    config = function()
      require "nvim-treesitter.configs".setup {
        ensure_installed = {
          "lua",
          "bash",
          "yaml", "json",
          "go", "gomod", "gowork",
          "dockerfile", "hcl",
          "elixir",
          "javascript", "typescript"
        },
        highlight = { enable = true },
        indent = { enable = true }
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
          ["<enter>"] = cmp.mapping(cmp.mapping.confirm({ select = true }), { "i" }),
          ["<C-n>"] = cmp.mapping(cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Insert }), { "i" }),
          ["<C-p>"] = cmp.mapping(cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Insert }), { "i" }),
          ["<C-j>"] = cmp.mapping(cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Insert }), { "i" }),
          ["<C-k>"] = cmp.mapping(cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Insert }), { "i" }),
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

      -- diagnostics
      vim.keymap.set('n', '<F8>', vim.diagnostic.goto_next, { noremap = true, silent = true })

      -- FIXME: the Shift+F8 isn't quite working. Too bad I don't use it much.
      vim.keymap.set('n', '<S-F8>', vim.diagnostic.goto_prev, { noremap = true, silent = true })

      -- Note: By leveraging the quickfix list instead of location, we get
      -- project wide diagnostics instead of bufferwise.
      vim.keymap.set('n', '<space>q', vim.diagnostic.setqflist, { noremap = true, silent = true })

      local on_attach = function(client, bufnr)
        local opts = { silent = true, buffer = bufnr }

        -- code actions
        vim.keymap.set("n", "ff", vim.lsp.buf.format, opts)
        vim.keymap.set('n', 'fo', vim.lsp.buf.code_action, opts)
        vim.keymap.set('n', '<F2>', vim.lsp.buf.rename, opts)

        -- code navigation
        vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
        vim.keymap.set("n", "gk", vim.lsp.buf.hover, opts)
        vim.keymap.set("n", "gs", require 'telescope.builtin'.lsp_document_symbols, opts)
        -- vim.keymap.set("n", "gW", "<cmd>lua require'telescope.builtin'.lsp_workspace_symbols{}<cr>", opts)

        -- references code navigation (quickfix list)
        vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)
        vim.keymap.set("n", "gD", vim.lsp.buf.implementation, opts)

        -- references code navigation (Telescope)
        vim.keymap.set("n", "<leader>gr", require 'telescope.builtin'.lsp_references, opts)
        vim.keymap.set('n', "<leader>gD", require 'telescope.builtin'.lsp_implementations, opts)

        vim.api.nvim_buf_set_option(bufnr, "omnifunc", "v:lua.vim.lsp.omnifunc")
      end

      for _, lsp in pairs({
        "gopls",
        "golangci_lint_ls",
        "tsserver",
        "ocamlls",
        "terraformls",
        "sumneko_lua",
      }) do
        require("lspconfig")[lsp].setup({
          capabilities = capabilities,
          flags = flags,
          handlers = handlers,
          on_attach = on_attach,
        })
      end

      -- Need to manually install?
      -- curl -fLO https://github.com/elixir-lsp/elixir-ls/releases/latest/download/elixir-ls.zip
      -- unzip elixir-ls.zip -d ~/.elixir-ls
      -- chmod +x ~/.elixir-ls/language_server.sh
      require('lspconfig').elixirls.setup({
        cmd = { "/Users/manzanit0/.elixir-ls/language_server.sh" };
        capabilities = capabilities,
        flags = flags,
        handlers = handlers,
        on_attach = on_attach,
      })

      require("mason").setup()
      require("mason-lspconfig").setup({ automatic_installation = true })

      vim.api.nvim_create_autocmd("CursorHold", {
        buffer = bufnr,
        callback = function()
          local float_opts = {
            focusable = false,
            close_events = { "BufLeave", "CursorMoved", "InsertEnter", "FocusLost" },
            border = "rounded",
            source = "always", -- show source in diagnostic popup window
            prefix = " ",
          }

          if not vim.b.diagnostics_pos then
            vim.b.diagnostics_pos = { nil, nil }
          end

          local cursor_pos = vim.api.nvim_win_get_cursor(0)
          if (cursor_pos[1] ~= vim.b.diagnostics_pos[1] or cursor_pos[2] ~= vim.b.diagnostics_pos[2])
              and #vim.diagnostic.get() > 0
          then
            vim.diagnostic.open_float(nil, float_opts)
          end

          vim.b.diagnostics_pos = cursor_pos
        end,
      })
    end,
  })

  -- Organize Go imports on save.
  local function org_imports()
    local clients = vim.lsp.buf_get_clients()
    for _, client in pairs(clients) do

      local params = vim.lsp.util.make_range_params(nil, client.offset_encoding)
      params.context = { only = { "source.organizeImports" } }

      local result = vim.lsp.buf_request_sync(0, "textDocument/codeAction", params, 5000)
      for _, res in pairs(result or {}) do
        for _, r in pairs(res.result or {}) do
          if r.edit then
            vim.lsp.util.apply_workspace_edit(r.edit, client.offset_encoding)
          else
            vim.lsp.buf.execute_command(r.command)
          end
        end
      end
    end

    -- after organising imports, format.
    vim.lsp.buf.format()
  end

  vim.api.nvim_create_autocmd("BufWritePre", {
    pattern = { "*.lua", "*.ex", "*.exs" },
    callback = vim.lsp.buf.format,
  })

  vim.api.nvim_create_autocmd("BufWritePre", {
    pattern = { "*.go" },
    callback = org_imports,
  })

  -- Improves UI boxes, such as the LSP rename.
  use({ 'stevearc/dressing.nvim' })

  -- This plugin is nice, but it redefines every LSP mapping... which makes it not very convenient.
  -- use({ "mhanberg/elixir.nvim", requires = { "nvim-lua/plenary.nvim" } })

  -- TODO: do we want this as opposed to vim-fugitive?
  -- use({ 'TimUntersberger/neogit', requires = 'nvim-lua/plenary.nvim' })

  -- TODO
  -- To register mappings
  -- use({ 'mrjones2014/legendary.nvim', config = function()
  --   require('legendary').setup({
  --     keymaps = {
  --       { '<leader>ff', ':Telescope find_files', description = 'Find files' },
  --       { '<leader>fg', ':Telescope live_grep', description = 'Find files' },
  --       { 'ff', 'N/a', description = 'LSP: Format Buffer' },
  --       { '<F2>', 'N/a', description = 'LSP: Rename' },
  --       { 'gd', 'N/a', description = 'LSP: Go to definition' },
  --       { 'gk', 'N/a', description = 'LSP: Show hover' },
  --     },
  --   })
  -- end })

  -- TODO: 'junegunn/fzf.vim'... instead of telescope?
  -- TODO: snippets: hrsh7th/vim-vsnip, or check astrovim

  -- Automatically set up your configuration after cloning packer.nvim
  -- Put this at the end after all plugins
  if packer_bootstrap then
    require('packer').sync()
  end
end)
