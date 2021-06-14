-- Editor
vim.opt.mouse = 'a'
vim.opt.clipboard:prepend { 'unnamed', 'unnamedplus' }
vim.opt.foldlevelstart = 99
vim.opt.foldlevel = 99
vim.opt.updatetime = 100
vim.opt.completeopt = 'menuone'

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
vim.cmd 'autocmd VimResized * wincmd ='

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
    buf_set_keymap('n', '<space>r', '<Cmd>lua vim.lsp.buf.rename()<CR>', opts)
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
paq {'nvim-lua/popup.nvim'}
paq {'nvim-lua/plenary.nvim'}
paq {'nvim-telescope/telescope.nvim'}

require('telescope').setup{
  defaults = {
    vimgrep_arguments = {
      'rg',
      '--color=never',
      '--no-heading',
      '--with-filename',
      '--line-number',
      '--column',
      '--smart-case'
    },
    prompt_position = "bottom",
    prompt_prefix = "> ",
    selection_caret = "> ",
    entry_prefix = "  ",
    initial_mode = "insert",
    selection_strategy = "reset",
    sorting_strategy = "descending",
    layout_strategy = "horizontal",
    layout_defaults = {
      horizontal = {
        mirror = false,
      },
      vertical = {
        mirror = false,
      },
    },
    file_sorter =  require'telescope.sorters'.get_fzy_sorter,
    file_ignore_patterns = {'__pycache__/*'},
    generic_sorter =  require'telescope.sorters'.get_generic_fuzzy_sorter,
    shorten_path = true,
    winblend = 0,
    width = 0.75,
    preview_cutoff = 120,
    results_height = 1,
    results_width = 0.8,
    border = {},
    borderchars = { '─', '│', '─', '│', '╭', '╮', '╯', '╰' },
    color_devicons = true,
    use_less = true,
    set_env = { ['COLORTERM'] = 'truecolor' }, -- default = nil,
    file_previewer = require'telescope.previewers'.vim_buffer_cat.new,
    grep_previewer = require'telescope.previewers'.vim_buffer_vimgrep.new,
    qflist_previewer = require'telescope.previewers'.vim_buffer_qflist.new,

    -- Developer configurations: Not meant for general override
    buffer_previewer_maker = require'telescope.previewers'.buffer_previewer_maker
  }
}

vim.api.nvim_set_keymap('n', '<space>ff', ':Telescope find_files<CR>', {noremap = false})
vim.api.nvim_set_keymap('n', '<space>fb', ':Telescope buffers<CR>', {noremap = false})
vim.api.nvim_set_keymap('n', '<space>fg', ':Telescope live_grep<CR>', {noremap = false})

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

vim.opt.background = 'dark'
vim.opt.termguicolors = true
vim.g.doom_one_terminal_colors = 1
vim.g.ayucolor = 'mirage'
vim.cmd 'colorscheme seoul256'
