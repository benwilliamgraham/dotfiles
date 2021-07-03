-- Plugins
require 'paq' {
    -- Plugin manager
    'savq/paq-nvim';

    -- Treesitter
    'nvim-treesitter/nvim-treesitter';

    -- Completion
    'shougo/deoplete-lsp';
    {'shougo/deoplete.nvim', run = vim.fn['remote#host#UpdateRemotePlugins']};

    -- LSP
    'neovim/nvim-lspconfig';
    'ojroques/nvim-lspfuzzy';

    -- Fuzzy finder
    'nvim-lua/popup.nvim';
    'nvim-lua/plenary.nvim';
    'nvim-telescope/telescope.nvim';

    -- Tree
    'kyazdani42/nvim-web-devicons';
    'kyazdani42/nvim-tree.lua';

    -- Status line
    'hoob3rt/lualine.nvim';

    -- Git
    'tpope/vim-fugitive';
    'airblade/vim-gitgutter';

    -- Themes
    'romgrk/doom-one.vim';
    'lifepillar/vim-solarized8';
    'morhetz/gruvbox';
    'ayu-theme/ayu-vim';
    'junegunn/seoul256.vim';
    'tomasiser/vim-code-dark';
}

-- Editor
vim.opt.mouse = 'a'
vim.opt.clipboard:prepend { 'unnamed', 'unnamedplus' }
vim.opt.foldlevelstart = 99
vim.opt.foldlevel = 99
vim.opt.updatetime = 100
vim.opt.completeopt = 'menuone'
vim.cmd 'autocmd FileType TelescopePrompt call deoplete#custom#buffer_option(\'auto_complete\', v:false)'
vim.opt.expandtab = true
vim.opt.shiftwidth = 4
vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.autoindent = true
vim.opt.relativenumber = true
vim.opt.number = true
vim.opt.linebreak = true
vim.opt.colorcolumn = '80'
vim.opt.hidden = true
vim.api.nvim_set_keymap('i', 'jk', '<Esc>', {noremap = false})
vim.api.nvim_set_keymap('t', 'jk', '<C-\\><C-n>', {noremap = false})
vim.cmd 'autocmd VimResized * wincmd ='

-- Treesitter
require 'nvim-treesitter.configs'.setup {
    ensure_installed = 'all',
    highlight = {enable = true},
}

vim.opt.foldmethod='expr'
vim.opt.foldexpr='nvim_treesitter#foldexpr()'

-- Completion
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
local lsp = require 'lspconfig'
local lspfuzzy = require 'lspfuzzy'

vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
    vim.lsp.diagnostic.on_publish_diagnostics, {
        virtual_text = false,
    }
)

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
    prompt_prefix = "> ",
    selection_caret = "> ",
    entry_prefix = "  ",
    initial_mode = "insert",
    selection_strategy = "reset",
    sorting_strategy = "descending",
    layout_strategy = "horizontal",
    layout_config = {
      horizontal = {
        mirror = false,
      },
      vertical = {
        mirror = false,
      },
    },
    file_sorter =  require'telescope.sorters'.get_fuzzy_file,
    file_ignore_patterns = {'__pycache__'},
    generic_sorter =  require'telescope.sorters'.get_generic_fuzzy_sorter,
    shorten_path = true,
    winblend = 0,
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

-- Tree
vim.api.nvim_set_keymap('n', '<space>tt', ':NvimTreeToggle<CR>', {noremap = false})

vim.g.nvim_tree_ignore = { '.git', '.mypy_cache', '__pycache__', "node_modules" }

vim.g.nvim_tree_icons = {
  default = '',
  symlink = '',
  git = {
    unstaged = "✗",
    staged = "✓",
    unmerged = "",
    renamed = "➜",
    untracked = "★",
    deleted = "",
    ignored = "◌"
  },
  folder = {
  arrow_open = "",
  arrow_closed = "",
  default = "",
  open = "",
  empty = "",
  empty_open = "",
  symlink = "",
  symlink_open = "",
  },
  lsp = {
    hint = "",
    info = "",
    warning = "",
    error = "",
  }
}

-- Status line
require('lualine').setup {
  options = { theme = 'codedark' },
}

-- Git
vim.api.nvim_set_keymap('n', '<space>gn', '<Plug>(GitGutterNextHunk)', {noremap = false})
vim.api.nvim_set_keymap('n', '<space>gp', '<Plug>(GitGutterPrevHunk)', {noremap = false})

-- Themes
vim.opt.background = 'dark'
vim.opt.termguicolors = true
vim.g.doom_one_terminal_colors = 1
vim.g.ayucolor = 'mirage'
vim.cmd 'colorscheme codedark'
