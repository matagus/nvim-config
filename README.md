# Neovim Configuration — What You Can Do

This Neovim setup focuses on fast navigation, great ergonomics, and solid language tooling for Python and Rust. Below is a quick, practical overview of what this configuration enables and how to use it.

## At a glance
- Project/file navigation
  - NERDTree sidebar for browsing files
  - Telescope for fuzzy finding files, buffers, symbols, and help
- Language tooling (LSP)
  - Go to definition/implementation, hover docs, rename, code actions
  - Diagnostics with quick navigation and a dedicated Trouble list
- Editing comfort
  - Completion (nvim-cmp), snippets (snippy), autopairs
  - Commenting via NERDCommenter
  - Treesitter highlighting for many languages
- Python & Rust
  - Python LSP (pylsp) and linting/formatting via Ruff LSP
  - Run current Python file with F5
  - Rust: rustfmt on save and rust-analyzer
- UI/UX
  - Statusline via vim-airline
  - Buffer/tab management with barbar
  - Symbols outline (Aerial)
  - Devicons, multiple themes (Nightfox default), Zen Mode/Twilight
- Tooling
  - nvim-dap + nvim-dap-python (debugging; minimal config present)
  - Overseer task runner (with a user Django test template referenced)

## Prerequisites
- Neovim (0.8+ recommended)
- Python host: This configuration needs to know where your Python environment is. Set the following environment variable in your shell's configuration file (e.g. `.zshrc`):
  ```sh
  export NVIM_PYTHON_HOST_DIR="$HOME/.pyenv/versions/neovim3"
  ```
- Python LSPs: The following LSP servers are used. Make sure they are installed and in your path.
  ```sh
  export NVIM_LSP_BIN_DIR="$HOME/.pyenv/versions/pylsp/bin"
  ```
- For Rust: `rust-analyzer` and `rustfmt`

## Installation
1. Open Neovim: `nvim`
2. Install plugins: run `:PlugInstall`
3. Restart Neovim

Optional: For Treesitter parsers, use `:TSUpdate`.

## Leader key
- Leader is set to comma: `,`

## File tree (NERDTree)
- Auto-opens on start when no files are passed
- `,n` → focus NERDTree
- `Ctrl-n` → open NERDTree
- `Ctrl-t` → toggle NERDTree
- `Ctrl-f` → find current file in tree

## Fuzzy find (Telescope)
- `,ff` → find files
- `,fg` → live grep
- `,fb` → buffers
- `,fh` → help tags
- `,ft` → Treesitter symbols
- `,fs` → LSP document symbols
- `,fk` → keymaps
- `,fa` → Aerial symbols (Telescope extension)

## LSP essentials
(Active when an LSP attaches in a buffer)

### Navigation
- `K` → **Hover documentation** - Display detailed information about the symbol under cursor (types, docstrings, signatures)
- `gd` → **Go to definition** - Jump to where the symbol is defined
- `gD` → **Go to declaration** - Jump to the declaration (useful in languages like C where declaration differs from definition)
- `gi` → **Go to implementation** - List and jump to all implementations of an interface/abstract method
- `go` → **Go to type definition** - Jump to the definition of the type of the symbol
- `gr` → **Find references** - List all references to the symbol under cursor across the project
- `gs` → **Signature help** - Show function signature and parameter information

### Refactoring
- `F2` → **Rename symbol** - Intelligently rename the symbol under cursor and all its references across the project
  - Works for functions, methods, variables, classes, etc.
  - Respects scope (won't rename unrelated symbols with the same name)
  - Shows preview of changes before applying

### Code Actions
- `F4` (normal mode) → **Code action** - Show available code actions at cursor position
  - Auto-fix imports
  - Apply suggested fixes for diagnostics
  - Refactor code
  - Organize imports
- `F4` (visual mode) → **Range code action** - Apply code actions to selected range

### Diagnostics Navigation
- `gl` → **Show diagnostic** - Display diagnostic message for the current line in a floating window
- `[d` → **Previous diagnostic** - Jump to the previous diagnostic in the buffer
- `]d` → **Next diagnostic** - Jump to the next diagnostic in the buffer

### Diagnostics Management
- `,dl` → **Diagnostics to location list** - Load all diagnostics into the location list for easy navigation
- `,dq` → **Diagnostics to quickfix** - Load all diagnostics into the quickfix list
- `,do` → **Float diagnostic** - Open floating window with diagnostic details

### Trouble list (diagnostics/todos/refs)
- `,xx` → **Open Trouble** - Open the Trouble panel with workspace diagnostics
- `,xw` → **Workspace diagnostics** - Show all diagnostics across the workspace
- `,xd` → **Document diagnostics** - Show diagnostics for current file only
- `,xq` → **Quickfix** - Show quickfix list in Trouble
- `,xl` → **Location list** - Show location list in Trouble
- `gR` → **LSP references** - Show all references in Trouble panel (better UI than `gr`)

### Configured LSP servers
This configuration includes the following LSP servers:

**Python:**
- **pylsp** (Python LSP Server) - Provides completion, hover, definitions, references, and basic diagnostics
- **ruff** (Ruff LSP) - Fast Python linter and formatter with auto-fix capabilities
  - Provides: fast linting, import sorting, code formatting suggestions

**Rust:**
- **rust-analyzer** - Full-featured Rust LSP
  - Provides: completion, go-to-definition, type hints, refactoring, macro expansion
  - Works with Cargo projects
  - Auto-formatting via `rustfmt` on save

All LSP features (navigation, refactoring, diagnostics, code actions) work automatically when you open a file that has an LSP server configured.

## Completion & snippets
- Completion via nvim-cmp with LSP source
- Snippets via `nvim-snippy` (plus `vim-snippets` collection)
- Keys while completing: `Ctrl-b`/`Ctrl-f` to scroll docs, `Ctrl-Space` to trigger, `Ctrl-e` to abort, `Enter` to confirm

Note: `ncm2` is also enabled globally; if you prefer a single engine, consider disabling one of them.

## AI Assistance (Codeium)
AI-powered code completions via Codeium

-  `Tab` → Accept the current suggestion
-  `Shift-Right` → Next suggestion
-  `Shift-Left` → Previous suggestion
-  `Shift-x` → Clear the current suggestion
-  `Shift-g` → Manually trigger Codeium completion"
- `:Codeium Enable` → enable Codeium globally
- `:Codeium Disable` → disable Codeium globally
- `:Codeium Toggle` → toggle Codeium globally
- `:Codeium Auth` → authenticate with Codeium

## Symbols outline (Aerial)
- `,a` → toggle Aerial panel
- `,b` → open Aerial navigation
- In a buffer with Aerial attached: `{` / `}` → previous / next symbol

## Buffers & tabs (barbar)
- `Ctrl-M-Left` / `Ctrl-M-Right` → previous / next buffer
- `Alt-<` / `Alt->` → move buffer left / right
- `Alt-1..9` → go to buffer 1..9
- `Alt-0` → last buffer
- `Alt-p` → pin buffer
- `Ctrl-c` → close buffer
- `Ctrl-p` → buffer pick mode
- Sorting: `Space bb` (by number), `Space bd` (by directory), `Space bl` (by language), `Space bw` (by window)

## Python & Rust niceties
- Python: `F5` in a Python file to save and run the current file with `python3`
- Ruff LSP + pylsp configured (adjust paths if needed)
- Rust: `rustfmt` on save; `rust-analyzer` configured

## Editing helpers
- NERDCommenter default mappings enabled (e.g., toggle comment on selection/line). See `:help NERDCommenter` for full map.
- Auto-pairs for brackets/braces/quotes
- Remove trailing whitespace on save
- Clear search highlight: `Ctrl-l`

## UI & themes
- Statusline: vim-airline (theme applied on startup)
- Colorscheme: Nightfox by default (others installed: base16, material, dogrun, etc.)
- Devicons enabled
- Zen writing: `:ZenMode` and `:Twilight` available

## Debugging & tasks
- Debugging: nvim-dap and nvim-dap-python installed (lightweight defaults). You may need to configure Python adapter path.
- Tasks: Overseer is set up with builtin templates and a `user.django_test` template reference.

## Plugin list (high level)
- Core/editor: vim-polyglot, auto-pairs, nvim-snippy, vim-snippets
- Completion: nvim-cmp (+ cmp-nvim-lsp, buffer, path, cmdline)
- LSP: nvim-lspconfig
- Python: pylsp, ruff LSP
- Rust: rust.vim, rustfmt, rust-analyzer
- UI: vim-airline, web-devicons, nightfox/material/base16 themes
- Navigation: NERDTree, Telescope, Aerial, barbar
- Diagnostics: trouble.nvim
- Treesitter: nvim-treesitter
- Extras: zen-mode, twilight, nvim-notify, dressing, overseer, nvim-dap, nvim-dap-python, codeium

## Customization pointers
- Leader key: change in `init.vim` (currently `,`)
- Colorscheme: change in `init.vim` (`colorscheme nightfox`)
- Python host and LSP paths: see the top of `init.vim` and the LSP section inside `vim-plug/plugins.vim`
- Telescope/Aerial/NERDTree and other keymaps: see their mappings in `init.vim`

If you need help with any command, use `:help <topic>` (e.g., `:help telescope`, `:help lsp`, `:help trouble`).

