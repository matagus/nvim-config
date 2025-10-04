let g:python3_host_prog = $NVIM_PYTHON_HOST_DIR . '/bin/python'
let g:polyglot_disabled = ['markdown']

syntax on                       "syntax highlighting, see :help syntax
filetype plugin indent on       "file type detection, see :help filetype
set number                      "display line number
set relativenumber              "display relative line numbers
set path+=**                    "improves searching, see :help path
set noswapfile                  "disable use of swap files
set wildmenu                    "completion menu
set backspace=indent,eol,start  "ensure proper backspace functionality
set undodir=~/.cache/nvim/undo  "undo ability will persist after exiting file
set undofile                    "see :help undodir and :help undofile
set incsearch                   "see results while search is being typed, see :help incsearch
set smartindent                 "auto indent on new lines, see :help smartindent
set ic                          "ignore case when searching
set colorcolumn=120             "display color when line reaches pep8 standards
set textwidth=120               "set text width to 120 columns
set expandtab                   "expanding tab to spaces
set tabstop=4                   "setting tab to 4 columns
set shiftwidth=4                "setting tab to 4 columns
set softtabstop=4               "setting tab to 4 columns
set showmatch                   "display matching bracket or parenthesis
set hlsearch incsearch          "highlight all pervious search pattern with incsearch

source $HOME/.config/nvim/vim-plug/plugins.vim

" Map the leader key to a comma.
let mapleader = ','


" Find files using Telescope command-line sugar.
nnoremap <leader>ff <cmd>Telescope find_files<cr>
nnoremap <leader>fg <cmd>Telescope live_grep<cr>
nnoremap <leader>fb <cmd>Telescope buffers<cr>
nnoremap <leader>fh <cmd>Telescope help_tags<cr>
nnoremap <leader>ft <cmd>Telescope treesitter<cr>
nnoremap <leader>fs <cmd>Telescope lsp_document_symbols<cr>
nnoremap <leader>fk <cmd>Telescope keymaps<cr>
nnoremap <leader>fz <cmd>lua require("material.functions").find_style()<cr>
nnoremap <leader>fa <cmd>lua require("telescope").extensions.aerial.aerial()<cr>

nnoremap <leader>dl <cmd>lua vim.diagnostic.setloclist()<cr>
nnoremap <leader>dq <cmd>lua vim.diagnostic.setqflist()<cr>
nnoremap <leader>do <cmd>lua vim.diagnostic.open_float()<cr>


" Keybind Ctrl+l to clear search
nnoremap <C-l> :nohl<CR><C-l>:echo "Search Cleared"<CR>

" When python filetype is detected, F5 can be used to execute script
autocmd FileType python nnoremap <buffer> <F5> :w<cr>:exec '!clear'<cr>:exec '!python3' shellescape(expand('%:p'), 1)<cr>

" Ref: https://github.com/EdenEast/nightfox.nvim
colorscheme nightfox
" --
" Ref: https://github.com/RRethy/nvim-base16
" colorscheme base16-ashes
" colorscheme base16-chalk
" colorscheme base16-da-one-ocean
" colorscheme base16-gruvbox-material-dark-hard
" colorscheme base16-harmonic-dark
" colorscheme base16-kanagawa
" colorscheme nightcity
set background=dark
"colorscheme oceanic_material
"colorscheme material


" Github Copilot key mappings
" imap <expr> <C-j> copilot#Previous() ? '<Plug>(copilot-previous)'' : '<C-j>'
" imap <expr> <C-k> copilot#Next() ? '<Plug>(copilot-next)'' : '<C-k>'
" imap <expr> <C-.> copilot#Suggest() ? '<Plug>(copilot-suggest)'' : '<C-.>'

" Codeium key mappings
imap <script><silent><nowait><expr> <Tab> codeium#Accept()
imap <S-Right> <Cmd>call codeium#CycleCompletions(1)<CR>
imap <S-Left> <Cmd>call codeium#CycleCompletions(-1)<CR>
imap <S-x> <Cmd>call codeium#Clear()<CR>
imap <S-g> <Cmd>call codeium#Complete()<CR>

" Rust
autocmd FileType rust let g:rustfmt_autosave = 1

" nerdcommenter
" Create default mappings
let g:NERDCreateDefaultMappings = 1
" Add spaces after comment delimiters by default
let g:NERDSpaceDelims = 1
" Use compact syntax for prettified multi-line comments
let g:NERDCompactSexyComs = 1
" Align line-wise comment delimiters flush left instead of following code indentation
let g:NERDDefaultAlign = 'left'
" Set a language to use its alternate delimiters by default
let g:NERDAltDelims_python = 1
" Add your own custom formats or override the defaults
let g:NERDCustomDelimiters = { 'c': { 'left': '/**','right': '*/' } }
" Allow commenting and inverting empty lines (useful when commenting a region)
let g:NERDCommentEmptyLines = 1
" Enable trimming of trailing whitespace when uncommenting
let g:NERDTrimTrailingWhitespace = 1
" Enable NERDCommenterToggle to check all selected lines is commented or not
let g:NERDToggleCheckAllLines = 1

" " Set Airline Theme to deus
let g:airline_theme = 'deus'

nnoremap <leader>xx <cmd>Trouble<cr>
nnoremap <leader>xw <cmd>Trouble workspace_diagnostics<cr>
nnoremap <leader>xd <cmd>Trouble document_diagnostics<cr>
nnoremap <leader>xq <cmd>Trouble quickfix<cr>
nnoremap <leader>xl <cmd>Trouble loclist<cr>
nnoremap gR <cmd>Trouble lsp_references<cr>

" Remove trailing whitespaces on save
autocmd BufWritePre * :%s/\s\+$//e
