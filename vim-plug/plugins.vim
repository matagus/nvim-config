" auto-install vim-plug
if empty(glob('~/.config/nvim/autoload/plug.vim'))
  silent !curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  "autocmd VimEnter * PlugInstall
  "autocmd VimEnter * PlugInstall | source $MYVIMRC
endif

call plug#begin('~/.config/nvim/autoload/plugged')

    " Better Syntax Support
    Plug 'sheerun/vim-polyglot'
    " File Explorer
    Plug 'scrooloose/NERDTree'
    " Auto pairs for '(' '[' '{'
    Plug 'jiangmiao/auto-pairs'
    Plug 'dcampos/nvim-snippy'
    Plug 'honza/vim-snippets'
    Plug 'ncm2/ncm2'
    Plug 'roxma/nvim-yarp'
    Plug 'ncm2/ncm2-bufword'
    Plug 'ncm2/ncm2-path'
    Plug 'preservim/nerdcommenter'

    " Color Schemes
    Plug 'EdenEast/nightfox.nvim'
    " https://github.com/RRethy/nvim-base16
    " Night City Theme
    "Plug 'cryptomilk/nightcity.nvim'
    Plug 'nvim-lua/plenary.nvim'
    Plug 'RRethy/nvim-base16'
    Plug 'marko-cerovac/material.nvim'

    Plug 'vyperlang/vim-vyper'

    Plug 'wadackel/vim-dogrun'

    " LSP autocompletition. See https://github.com/hrsh7th/nvim-cmp
    Plug 'neovim/nvim-lspconfig'
	Plug 'hrsh7th/cmp-nvim-lsp'
	Plug 'hrsh7th/cmp-buffer'
	Plug 'hrsh7th/cmp-path'
	Plug 'hrsh7th/cmp-cmdline'
	Plug 'hrsh7th/nvim-cmp'

    " For vsnip users.
	"Plug 'hrsh7th/cmp-vsnip'
	"Plug 'hrsh7th/vim-vsnip'
    "Plug 'hrsh7th/vim-vsnip-integ'
    "Plug 'rafamadriz/friendly-snippets'

    " Rust support
    Plug 'rust-lang/rust.vim'
    Plug 'rust-lang/rustfmt'

    " vim-airline
    Plug 'vim-airline/vim-airline'
    Plug 'vim-airline/vim-airline-themes'

    " trouble.nvim
    Plug 'nvim-tree/nvim-web-devicons'
    Plug 'folke/trouble.nvim'

    " Github Copilot
    "Plug 'github/copilot.vim'

    " Codium
    Plug 'Exafunction/codeium.vim', { 'branch': 'main' }

    " Overseer
    Plug 'stevearc/dressing.nvim'
    Plug 'rcarriga/nvim-notify'
    Plug 'stevearc/overseer.nvim'

    " Aerial
    Plug 'stevearc/aerial.nvim'

    " Barbar Tab Manager
    Plug 'lewis6991/gitsigns.nvim' " OPTIONAL: for git status
    Plug 'nvim-tree/nvim-web-devicons' " OPTIONAL: for file icons
    Plug 'romgrk/barbar.nvim', {'tag': 'v1.9.1'}

    " Oceanic Material Theme
    "Plug 'nvimdev/oceanic-material'

    " treesitter
    Plug 'nvim-treesitter/nvim-treesitter'

    " Telescope
    Plug 'nvim-telescope/telescope.nvim'

    " Zen Mode + Twilight
    Plug 'folke/zen-mode.nvim'
    Plug 'folke/twilight.nvim'

    " DAP: Debug Adapter Protocol for nvim
    Plug 'mfussenegger/nvim-dap'
    Plug 'mfussenegger/nvim-dap-python'

call plug#end()

" enable ncm2 for all buffers
autocmd BufEnter * call ncm2#enable_for_buffer()

au VimEnter * AirlineTheme atomic

" IMPORTANT: :help Ncm2PopupOpen for more information
set completeopt=noinsert,menuone,noselect

lua <<EOF
  vim.opt.termguicolors = true

  -- Set up nvim-cmp.
  local cmp = require'cmp'

  cmp.setup({
    snippet = {
      -- REQUIRED - you must specify a snippet engine
      expand = function(args)
        vim.fn["vsnip#anonymous"](args.body) -- For `vsnip` users.
        -- require('luasnip').lsp_expand(args.body) -- For `luasnip` users.
        require('snippy').expand_snippet(args.body) -- For `snippy` users.
        -- vim.fn["UltiSnips#Anon"](args.body) -- For `ultisnips` users.
        -- vim.snippet.expand(args.body) -- For native neovim snippets (Neovim v0.10+)
      end,
    },
    window = {
      completion = cmp.config.window.bordered(),
      documentation = cmp.config.window.bordered(),
    },
    mapping = cmp.mapping.preset.insert({
      ['<C-b>'] = cmp.mapping.scroll_docs(-4),
      ['<C-f>'] = cmp.mapping.scroll_docs(4),
      ['<C-Space>'] = cmp.mapping.complete(),
      ['<C-e>'] = cmp.mapping.abort(),
      ['<CR>'] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
    }),
    sources = cmp.config.sources({
      { name = 'nvim_lsp' },
      { name = 'vsnip' }, -- For vsnip users.
      -- { name = 'luasnip' }, -- For luasnip users.
      -- { name = 'ultisnips' }, -- For ultisnips users.
      { name = 'snippy' }, -- For snippy users.
    }, {
      { name = 'buffer' },
    })
  })

  -- Set up LSP with new vim.lsp.config API
  local capabilities = require('cmp_nvim_lsp').default_capabilities()

  -- Configure `ruff-lsp`.
  -- See: https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md#ruff_lsp
  -- For the default config, along with instructions on how to customize the settings
  vim.lsp.config.ruff = {
cmd = { os.getenv("NVIM_LSP_BIN_DIR") .. "/ruff-lsp" },
    filetypes = { 'python' },
    root_markers = { 'pyproject.toml', 'requirements.txt', 'README.md', '.git' },
    capabilities = capabilities,
    on_attach = on_attach,
    init_options = {
      settings = {
        -- Any extra CLI arguments for `ruff` go here.
        args = {},
      }
    },
  }

  -- Pylyzer setup
  -- require('lspconfig').pylyzer.setup {
  --   on_attach = on_attach,
  --   init_options = {
  --     settings = {
  --       args = {},
  --       python = {
  --         checkOnType = false,
  --         diagnostics = true,
  --         inlayHints = true,
  --         smartCompletion = true
  --       }
  --     }
  --   },
  --   cmd = { os.getenv("NVIM_LSP_BIN_DIR") .. "/pylyzer", "--server" }
  -- }

  vim.lsp.config.pylsp = {
cmd = { os.getenv("NVIM_LSP_BIN_DIR") .. "/pylsp" },
    filetypes = { 'python' },
    root_markers = { 'pyproject.toml', 'requirements.txt', 'setup.py', '.git' },
    capabilities = capabilities,
  }

  vim.lsp.config.rust_analyzer = {
    cmd = { 'rust-analyzer' },
    filetypes = { 'rust' },
    root_markers = { 'Cargo.toml' },
    capabilities = capabilities,
    on_attach = on_attach,
    flags = lsp_flags,
    -- Server-specific settings...
    settings = {
      ["rust-analyzer"] = {}
    }
  }

  -- Enable LSP servers
  vim.lsp.enable('ruff')
  vim.lsp.enable('pylsp')
  vim.lsp.enable('rust_analyzer')
  --> https://github.com/python-lsp/python-lsp-server

  -- extracted from https://vonheikemen.github.io/devlog/tools/setup-nvim-lspconfig-plus-nvim-cmp/
  vim.api.nvim_create_autocmd('LspAttach', {
    desc = 'LSP actions',
    callback = function()
      local bufmap = function(mode, lhs, rhs)
        local opts = {buffer = true}
        vim.keymap.set(mode, lhs, rhs, opts)
      end

      -- Displays hover information about the symbol under the cursor
      bufmap('n', 'K', '<cmd>lua vim.lsp.buf.hover()<cr>')

      -- Jump to the definition
      bufmap('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<cr>')

      -- Jump to declaration
      bufmap('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<cr>')

      -- Lists all the implementations for the symbol under the cursor
      bufmap('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<cr>')

      -- Jumps to the definition of the type symbol
      bufmap('n', 'go', '<cmd>lua vim.lsp.buf.type_definition()<cr>')

      -- Lists all the references
      bufmap('n', 'gr', '<cmd>lua vim.lsp.buf.references()<cr>')

      -- Displays a function's signature information
      bufmap('n', 'gs', '<cmd>lua vim.lsp.buf.signature_help()<cr>')

      -- Renames all references to the symbol under the cursor
      bufmap('n', '<F2>', '<cmd>lua vim.lsp.buf.rename()<cr>')

      -- Selects a code action available at the current cursor position
      bufmap('n', '<F4>', '<cmd>lua vim.lsp.buf.code_action()<cr>')
      bufmap('x', '<F4>', '<cmd>lua vim.lsp.buf.code_action()<cr>')

      -- Show diagnostics in a floating window
      bufmap('n', 'gl', '<cmd>lua vim.diagnostic.open_float()<cr>')

      -- Move to the previous diagnostic
      bufmap('n', '[d', '<cmd>lua vim.diagnostic.goto_prev()<cr>')

      -- Move to the next diagnostic
      bufmap('n', ']d', '<cmd>lua vim.diagnostic.goto_next()<cr>')
    end
  })

  require("trouble").setup {
	position = "right", -- position of the list can be: bottom, top, left, right
	height = 10, -- height of the trouble list when position is top or bottom
	width = 75, -- width of the list when position is left or right
	icons = true, -- use devicons for filenames
	mode = "workspace_diagnostics", -- "workspace_diagnostics", "document_diagnostics", "quickfix", "lsp_references", "loclist"
	fold_open = "-", -- icon used for open folds
	fold_closed = "+", -- icon used for closed folds
	group = true, -- group results by file
	padding = true, -- add an extra new line on top of the list
	action_keys = { -- key mappings for actions in the trouble list
		-- map to {} to remove a mapping, for example:
		-- close = {},
		close = "q", -- close the list
		cancel = "<esc>", -- cancel the preview and get back to your last window / buffer / cursor
		refresh = "r", -- manually refresh
		jump = {"<cr>", "<tab>"}, -- jump to the diagnostic or open / close folds
		open_split = { "<c-x>" }, -- open buffer in new split
		open_vsplit = { "<c-v>" }, -- open buffer in new vsplit
		open_tab = { "<c-t>" }, -- open buffer in new tab
		jump_close = {"o"}, -- jump to the diagnostic and close the list
		toggle_mode = "m", -- toggle between "workspace" and "document" diagnostics mode
		toggle_preview = "P", -- toggle auto_preview
		hover = "K", -- opens a small popup with the full multiline message
		preview = "p", -- preview the diagnostic location
		close_folds = {"zM", "zm"}, -- close all folds
		open_folds = {"zR", "zr"}, -- open all folds
		toggle_fold = {"zA", "za"}, -- toggle fold of current file
		previous = "k", -- previous item
		next = "j" -- next item
	},
	indent_lines = true, -- add an indent guide below the fold icons
	auto_open = false, -- automatically open the list when you have diagnostics
	auto_close = false, -- automatically close the list when you have no diagnostics
	auto_preview = true, -- automatically preview the location of the diagnostic. <esc> to close preview and go back to last window
	auto_fold = true, -- automatically fold a file trouble list at creation
	auto_jump = {"lsp_definitions"}, -- for the given modes, automatically jump if there is only a single result
	signs = {
		-- icons / text used for a diagnostic
		error = "",
		warning = "",
		hint = "",
		information = "",
		other = "﫠"
	},
	use_diagnostic_signs = true -- enabling this will use the signs defined in your lsp client
  }

  require('overseer').setup({
    templates = { "builtin", "user.django_test" },
  })

  require('aerial').setup({
  -- Priority list of preferred backends for aerial.
  -- This can be a filetype map (see :help aerial-filetype-map)
  backends = { "treesitter", "lsp", "markdown", "asciidoc", "man" },

  layout = {
    -- These control the width of the aerial window.
    -- They can be integers or a float between 0 and 1 (e.g. 0.4 for 40%)
    -- min_width and max_width can be a list of mixed types.
    -- max_width = {40, 0.2} means "the lesser of 40 columns or 20% of total"
    max_width = { 40, 0.2 },
    width = nil,
    min_width = 30,

    -- key-value pairs of window-local options for aerial window (e.g. winhl)
    win_opts = {},

    -- Determines the default direction to open the aerial window. The 'prefer'
    -- options will open the window in the other direction *if* there is a
    -- different buffer in the way of the preferred direction
    -- Enum: prefer_right, prefer_left, right, left, float
    default_direction = "prefer_right",

    -- Determines where the aerial window will be opened
    --   edge   - open aerial at the far right/left of the editor
    --   window - open aerial to the right/left of the current window
    placement = "window",

    -- When the symbols change, resize the aerial window (within min/max constraints) to fit
    resize_to_content = true,

    -- Preserve window size equality with (:help CTRL-W_=)
    preserve_equality = false,
  },

    -- optionally use on_attach to set keymaps when aerial has attached to a buffer
    on_attach = function(bufnr)
      -- Jump forwards/backwards with '{' and '}'
      vim.keymap.set('n', '{', '<cmd>AerialPrev<CR>', {buffer = bufnr})
      vim.keymap.set('n', '}', '<cmd>AerialNext<CR>', {buffer = bufnr})
    end



  })
  -- You probably also want to set a keymap to toggle aerial
  vim.keymap.set('n', '<leader>a', '<cmd>AerialToggle!<CR>')
  vim.keymap.set('n', '<leader>b', '<cmd>AerialNavOpen<CR>')

  local map = vim.api.nvim_set_keymap
  local opts = { noremap = true, silent = true }
  max_width = { 40, 0.2 },

  -- Move to previous/next
  map('n', '<C-M-Left>', '<Cmd>BufferPrevious<CR>', opts)
  map('n', '<C-M-Right>', '<Cmd>BufferNext<CR>', opts)
  -- Re-order to previous/next
  map('n', '<A-<>', '<Cmd>BufferMovePrevious<CR>', opts)
  map('n', '<A->>', '<Cmd>BufferMoveNext<CR>', opts)
  -- Goto buffer in position...
  map('n', '<A-1>', '<Cmd>BufferGoto 1<CR>', opts)
  map('n', '<A-2>', '<Cmd>BufferGoto 2<CR>', opts)
  map('n', '<A-3>', '<Cmd>BufferGoto 3<CR>', opts)
  map('n', '<A-4>', '<Cmd>BufferGoto 4<CR>', opts)
  map('n', '<A-5>', '<Cmd>BufferGoto 5<CR>', opts)
  map('n', '<A-6>', '<Cmd>BufferGoto 6<CR>', opts)
  map('n', '<A-7>', '<Cmd>BufferGoto 7<CR>', opts)
  map('n', '<A-8>', '<Cmd>BufferGoto 8<CR>', opts)
  map('n', '<A-9>', '<Cmd>BufferGoto 9<CR>', opts)
  map('n', '<A-0>', '<Cmd>BufferLast<CR>', opts)
  -- Pin/unpin buffer
  map('n', '<A-p>', '<Cmd>BufferPin<CR>', opts)
  -- Close buffer:
  map('n', '<C-c>', '<Cmd>BufferClose<CR>', opts)
  -- Wipeout buffer
  --                 :BufferWipeout
  -- Close commands
  --                 :BufferCloseAllButCurrent
  --                 :BufferCloseAllButPinned
  --                 :BufferCloseAllButCurrentOrPinned
  --                 :BufferCloseBuffersLeft
  --                 :BufferCloseBuffersRight
  -- Magic buffer-picking mode
  map('n', '<C-p>', '<Cmd>BufferPick<CR>', opts)
  -- Sort automatically by...
  map('n', '<Space>bb', '<Cmd>BufferOrderByBufferNumber<CR>', opts)
  map('n', '<Space>bd', '<Cmd>BufferOrderByDirectory<CR>', opts)
  map('n', '<Space>bl', '<Cmd>BufferOrderByLanguage<CR>', opts)
  map('n', '<Space>bw', '<Cmd>BufferOrderByWindowNumber<CR>', opts)

  require'nvim-treesitter.configs'.setup {
    -- A list of parser names, or "all" (the five listed parsers should always be installed)
    ensure_installed = { "c", "lua", "vim", "vimdoc", "query", "python", "rust", "javascript" },

    -- Install parsers synchronously (only applied to `ensure_installed`)
    sync_install = false,

    -- Automatically install missing parsers when entering buffer
    -- Recommendation: set to false if you don't have `tree-sitter` CLI installed locally
    auto_install = true,

    -- List of parsers to ignore installing (or "all")
    ignore_install = { "all" },

    ---- If you need to change the installation directory of the parsers (see -> Advanced Setup)
    -- parser_install_dir = "/some/path/to/store/parsers", -- Remember to run vim.opt.runtimepath:append("/some/path/to/store/parsers")!

    highlight = {
      enable = true,

      -- NOTE: these are the names of the parsers and not the filetype. (for example if you want to
      -- disable highlighting for the `tex` filetype, you need to include `latex` in this list as this is
      -- the name of the parser)
      -- list of language that will be disabled
      disable = { "c", "java" },
      -- Or use a function for more flexibility, e.g. to disable slow treesitter highlight for large files
      disable = function(lang, buf)
          local max_filesize = 100 * 1024 -- 100 KB
          local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
          if ok and stats and stats.size > max_filesize then
              return true
          end
      end,

      -- Setting this to true will run `:h syntax` and tree-sitter at the same time.
      -- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
      -- Using this option may slow down your editor, and you may see some duplicate highlights.
      -- Instead of true it can also be a list of languages
      additional_vim_regex_highlighting = false,
    },
  }

EOF
