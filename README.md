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
- Python host: configured to use `/Users/matiasmendez/.pyenv/versions/neovim3/bin/python` (install `pynvim` into that environment)
- Python LSPs (paths customized in config):
  - pylsp: `/Users/matiasmendez/.pyenv/versions/pylsp/bin/pylsp`
  - ruff: `/Users/matiasmendez/.pyenv/versions/pylsp/bin/ruff`
  - Adjust these paths in `vim-plug/plugins.vim` if your setup differs.
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
- `K` → hover docs
- `gd` → go to definition
- `gD` → go to declaration
- `gi` → go to implementation
- `go` → go to type definition
- `gr` → references
- `gs` → signature help
- `F2` → rename symbol
- `F4` (normal/visual) → code action / range code action
- `gl` → show diagnostic under cursor
- `[d` / `]d` → previous / next diagnostic

Diagnostics helpers
- `,dl` → diagnostics to location list
- `,dq` → diagnostics to quickfix list
- `,do` → float diagnostic

Trouble list (diagnostics/todos/refs)
- `,xx` → open Trouble
- `,xw` → workspace diagnostics
- `,xd` → document diagnostics
- `,xq` → quickfix
- `,xl` → location list
- `gR` → LSP references in Trouble

## Completion & snippets
- Completion via nvim-cmp with LSP source
- Snippets via `nvim-snippy` (plus `vim-snippets` collection)
- Keys while completing: `Ctrl-b`/`Ctrl-f` to scroll docs, `Ctrl-Space` to trigger, `Ctrl-e` to abort, `Enter` to confirm

Note: `ncm2` is also enabled globally; if you prefer a single engine, consider disabling one of them.

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

