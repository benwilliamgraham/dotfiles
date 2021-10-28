-- Plugins
require 'paq' {
    -- Plugin manager
    'savq/paq-nvim';

    -- Treesitter
    'nvim-treesitter/nvim-treesitter';

    -- Completion
    'hrsh7th/nvim-cmp';
    'hrsh7th/cmp-nvim-lsp';
    'hrsh7th/cmp-buffer';

    -- LSP
    'neovim/nvim-lspconfig';

    -- Copilot
    'github/copilot.vim';

    -- Fuzzy finder
    'nvim-lua/plenary.nvim';
    'nvim-lua/popup.nvim';
    'nvim-telescope/telescope.nvim';

    -- Tree
    'kyazdani42/nvim-web-devicons';
    'kyazdani42/nvim-tree.lua';

    -- Git
    'tpope/vim-fugitive';
    'airblade/vim-gitgutter';

    -- Themes
    'rktjmp/lush.nvim';
    'romgrk/doom-one.vim';
    'morhetz/gruvbox';
    'ayu-theme/ayu-vim';
    'junegunn/seoul256.vim';
    'tomasiser/vim-code-dark';
    'lourenci/github-colors';
    'glepnir/zephyr-nvim';
    'theniceboy/nvim-deus';
    'savq/melange';
    'shaunsingh/nord.nvim';
    'ishan9299/nvim-solarized-lua';
    'metalelf0/jellybeans-nvim';
    'marko-cerovac/material.nvim';
    'ishan9299/modus-theme-vim';
    'sainnhe/sonokai';
    'adisen99/codeschool.nvim';
    'elianiva/icy.nvim';
}

-- Editor
vim.opt.mouse = 'a'
vim.opt.clipboard:prepend { 'unnamed', 'unnamedplus' }
vim.opt.foldlevelstart = 99
vim.opt.foldlevel = 99
vim.opt.updatetime = 100
vim.opt.completeopt = 'menu,menuone,noselect'
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
vim.api.nvim_set_keymap('t', '<Esc>', '<C-\\><C-n>', { noremap=false })
vim.cmd 'autocmd VimResized * wincmd ='
vim.cmd 'au BufRead,BufNew *.ll set filetype=llvm'

-- Treesitter
require 'nvim-treesitter.configs'.setup {
    ensure_installed = 'all',
    highlight = {enable = true},
}

vim.opt.foldmethod='expr'
vim.opt.foldexpr='nvim_treesitter#foldexpr()'

-- Completion
local cmp = require 'cmp'
cmp.setup {
  mapping = {
    ['<C-p>'] = cmp.mapping.select_prev_item(),
    ['<S-Tab>'] = cmp.mapping.select_prev_item(),
    ['<C-n>'] = cmp.mapping.select_next_item(),
    ['<Tab>'] = cmp.mapping.select_next_item(),
    ['<C-d>'] = cmp.mapping.scroll_docs(-4),
    ['<C-f>'] = cmp.mapping.scroll_docs(4),
    ['<C-Space>'] = cmp.mapping.complete(),
    ['<C-e>'] = cmp.mapping.close(),
    ['<CR>'] = cmp.mapping.confirm {
      behavior = cmp.ConfirmBehavior.Replace,
      select = true,
    },
  },
  sources = {
    { name = 'nvim_lsp' },
    { name = 'buffer' },
  },
}

-- LSP
local lsp = require 'lspconfig'

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
    buf_set_keymap('n', '<space>gD', '<Cmd>lua vim.lsp.buf.declaration()<CR>', opts)
    buf_set_keymap('n', '<space>gd', '<Cmd>lua vim.lsp.buf.definition()<CR>', opts)
    buf_set_keymap('n', '<space>gr', '<Cmd>lua vim.lsp.buf.references()<CR>', opts)
    buf_set_keymap('n', '<space>h', '<Cmd>lua vim.lsp.buf.hover()<CR>', opts)
    buf_set_keymap('n', '<space>r', '<Cmd>lua vim.lsp.buf.rename()<CR>', opts)
    buf_set_keymap('n', '<space>n', '<Cmd>lua vim.lsp.diagnostic.goto_next()<CR>', opts)
    buf_set_keymap('n', '<space>p', '<Cmd>lua vim.lsp.diagnostic.goto_prev()<CR>', opts)
end

lsp.pylsp.setup {
    on_attach = on_attach,
    settings = {
        pylsp = {
            plugins = {
                pylint = {enabled = true},
                pydocstyle = {enabled = true},
		        pylsp_mypy = {enabled = true, live_mode = false},
            }
        }
    },
    flags = {
        debounce_text_changes = 150,
    }
}
lsp.clangd.setup {
    on_attach = on_attach,
    flags = {
        debounce_text_changes = 150,
    }
}

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
    file_sorter = require'telescope.sorters'.get_fuzzy_file,
    file_ignore_patterns = {'__pycache__'},
    generic_sorter = require'telescope.sorters'.get_generic_fuzzy_sorter,
    winblend = 0,
    border = {},
    borderchars = { '─', '│', '─', '│', '╭', '╮', '╯', '╰' },
    color_devicons = true,
    use_less = true,
    path_display = {},
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

-- Git
vim.api.nvim_set_keymap('n', '<space>gn', '<Plug>(GitGutterNextHunk)', {noremap = false})
vim.api.nvim_set_keymap('n', '<space>gp', '<Plug>(GitGutterPrevHunk)', {noremap = false})

-- Themes
vim.opt.background = 'dark'
vim.opt.termguicolors = true
vim.g.doom_one_terminal_colors = 1
vim.g.ayucolor = 'mirage'
vim.g.material_style = "darker"
vim.g.codeschool_contrast_dark = "soft"
vim.cmd 'colorscheme zenburn'
