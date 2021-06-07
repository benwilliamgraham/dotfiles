-- Editor
vim.opt.mouse = 'a'
vim.opt.clipboard:prepend { 'unnamed', 'unnamedplus' }
vim.opt.completeopt:remove { 'preview' }
vim.opt.foldlevelstart = 99
vim.opt.foldlevel = 99
vim.opt.updatetime = 100

vim.opt.expandtab = true
vim.opt.shiftwidth = 4
vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.autoindent = true

vim.opt.relativenumber = true
vim.opt.number = true
vim.opt.linebreak = true
vim.opt.colorcolumn = '80'

vim.api.nvim_set_keymap('i', 'jk', '<Esc>', {noremap = false})
vim.api.nvim_set_keymap('t', 'jk', '<C-\\><C-n>', {noremap = false})

-- Plugin manager
vim.cmd 'packadd paq-nvim'
local paq = require('paq-nvim').paq
paq {'savq/paq-nvim', opt = true}

-- Treesitter
paq {'nvim-treesitter/nvim-treesitter'}
require 'nvim-treesitter.configs'.setup {
    ensure_installed = 'maintained',
    highlight = {enable = true},
}

vim.opt.foldmethod='expr'
vim.opt.foldexpr='nvim_treesitter#foldexpr()'

-- Completion
paq {'shougo/deoplete-lsp'}
paq {'shougo/deoplete.nvim', run = vim.fn['remote#host#UpdateRemotePlugins']}

vim.g["deoplete#enable_at_startup"] = true
vim.api.nvim_set_keymap(
    'i',
    '<S-Tab>',
    'pumvisible() ? "\\<C-p>" : "\\<Tab>"',
    {noremap = false, expr = true}
)
vim.api.nvim_set_keymap(
    'i',
    '<Tab>',
    'pumvisible() ? "\\<C-n>" : "\\<Tab>"',
    {noremap = false, expr = true}
)

-- LSP
paq {'neovim/nvim-lspconfig'}
paq {'ojroques/nvim-lspfuzzy'}
local lsp = require 'lspconfig'
local lspfuzzy = require 'lspfuzzy'

local on_attach = function(client, bufnr)
    local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
    local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end

    buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')

    vim.api.nvim_command 'autocmd BufWritePre <buffer> lua vim.lsp.buf.formatting_sync()'

    local opts = { noremap=true, silent=true }
    buf_set_keymap('n', 'gD', '<Cmd>lua vim.lsp.buf.declaration()<CR>', opts)
    buf_set_keymap('n', 'gd', '<Cmd>lua vim.lsp.buf.definition()<CR>', opts)
    buf_set_keymap('n', 'gr', '<Cmd>lua vim.lsp.buf.references()<CR>', opts)
    buf_set_keymap('n', '<space>h', '<Cmd>lua vim.lsp.buf.hover()<CR>', opts)
    buf_set_keymap('n', '<space>r', '<Cmd>lua vim.lsp.buf.replace()<CR>', opts)
    buf_set_keymap('n', '<space>n', '<Cmd>lua vim.lsp.diagnostic.goto_next()<CR>', opts)
    buf_set_keymap('n', '<space>p', '<Cmd>lua vim.lsp.diagnostic.goto_prev()<CR>', opts)
end

lsp.pyls.setup {
    on_attach = on_attach,
    settings = {
        pyls = {
            plugins = {
                pylint = {enabled = true},
                pydocstyle = {enabled = true},
                yapf = {enabled = true},
		pyls_mypy = {enabled = true, live_mode = false},
            }
        }
    }
}
lsp.clangd.setup { on_attach = on_attach }

lspfuzzy.setup {}

-- Fuzzy finder
paq {'junegunn/fzf', run = vim.fn['fzf#install']}
paq {'junegunn/fzf.vim'}

vim.api.nvim_set_keymap('n', '<C-p>', ':Files<CR>', {noremap = false})
vim.api.nvim_set_keymap('n', '<C-q>', ':GFiles<CR>', {noremap = false})
vim.api.nvim_set_keymap('n', '<C-b>', ':Buffers<CR>', {noremap = false})
vim.api.nvim_set_keymap('n', '<C-_>', ':Rg<CR>', {noremap = false})

-- Git
paq {'tpope/vim-fugitive'}
paq {'airblade/vim-gitgutter'}

vim.api.nvim_set_keymap('n', '<space>gn', '<Plug>(GitGutterNextHunk)', {noremap = false})
vim.api.nvim_set_keymap('n', '<space>gp', '<Plug>(GitGutterPrevHunk)', {noremap = false})

-- Themes
paq {'romgrk/doom-one.vim'}
paq {'lifepillar/vim-solarized8'}
paq {'morhetz/gruvbox'}
paq {'ayu-theme/ayu-vim'}
paq {'arcticicestudio/nord-vim'}
paq {'rafi/awesome-vim-colorschemes'}

vim.o.background = 'dark'
vim.o.termguicolors = true
vim.g.doom_one_terminal_colors = 1
vim.g.ayucolor = 'mirage'
vim.cmd 'colorscheme solarized8'
