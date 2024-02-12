-- My preferences
-- disable netrw at the very start of your init.lua (strongly advised)
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- Search is case sensitive only if pattern has upper case letters
vim.opt.ignorecase = true
vim.opt.smartcase = true
-- keep results of last search highlighted
vim.opt.hlsearch = true
-- wrap long lines
vim.opt.wrap = true
vim.opt.linebreak = true  -- don't split words
-- Always expand tabs to spaces
vim.opt.expandtab = true
vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.textwidth = 120
-- Set the leader character to ,
vim.g.mapleader = ','
-- Use full color range available
vim.opt.termguicolors = true
vim.opt.mouse = ""
vim.opt.cursorline = false -- Show the cursor line
vim.opt.signcolumn = "yes" -- Show the sign column so we don't get 'jumps'
vim.opt.showtabline = 2  -- always show tabs?
vim.opt.completeopt = { "menuone", "noselect" } -- for cmp
vim.opt.conceallevel = 0  -- to make `` visible in markdown files
vim.opt.smartindent = true
vim.opt.splitbelow = true
vim.opt.splitright = true
vim.opt.timeoutlen = 300  -- time to wait for a maped sequence
vim.opt.undofile = true  -- enable persistent undo
vim.opt.scrolloff = 5
vim.opt.wildmode = { "longest" , "list" , "full" }  -- Control behavior of 'tab' in the command area
vim.opt.wildmenu = true                             -- first tab completes, second tab brings up palette


-- Packer
local ensure_packer = function()
  local fn = vim.fn
  local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
  if fn.empty(fn.glob(install_path)) > 0 then
    fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
    vim.cmd [[packadd packer.nvim]]
    return true
  end
  return false
end

local packer_bootstrap = ensure_packer()

require('packer').startup(function(use)
  use 'wbthomason/packer.nvim'
  -- My plugins here
  use 'nvim-lualine/lualine.nvim'
  use 'shaunsingh/nord.nvim'
  use 'nvim-treesitter/nvim-treesitter'
  use 'nvim-tree/nvim-tree.lua'
  use 'echasnovski/mini.tabline'
  use 'nvim-tree/nvim-web-devicons'
  use {'nvim-telescope/telescope-fzf-native.nvim', run = 'cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build' }

  use {
    "nvim-telescope/telescope.nvim",
    requires = {
      { "nvim-telescope/telescope-live-grep-args.nvim" },
      {'nvim-lua/plenary.nvim'}
    },
    config = function()
      require("telescope").load_extension("live_grep_args")
    end
  }
  use 'neovim/nvim-lspconfig' -- Configurations for Nvim LSP
  use 'hrsh7th/nvim-cmp' -- Autocompletion plugin
  use 'hrsh7th/cmp-nvim-lsp' -- LSP source for nvim-cmp
  use 'hrsh7th/cmp-path'
  use { "ellisonleao/gruvbox.nvim" }
  use 'github/copilot.vim'
  use 'tpope/vim-fugitive'
  use 'mhartington/formatter.nvim'
  -- null-ls allows to inject actions into the LSP. Used here to allow to use formatters with pyright (which doesn't inherently support formatters)
  use 'jose-elias-alvarez/null-ls.nvim'
  -- Vimwiki
  use 'vimwiki/vimwiki'
  use({
    "kylechui/nvim-surround",
    tag = "*", -- Use for stability; omit to use `main` branch for the latest features
    config = function()
        require("nvim-surround").setup({
            -- Configuration here, or leave empty to use defaults
        })
    end
  })
  -- use ({
  --   "MunifTanjim/nui.nvim",
  --   config = function()
  --     require("nui").setup({
  --       -- optional configuration
  --     })
  --   end
  -- })
  -- use({
  --   "jackMort/ChatGPT.nvim",
  --   config = function()
  --     require("chatgpt").setup({
  --       -- optional configuration
  --     })
  --   end,
  --   requires = {
  --     -- "MunifTanjim/nui.nvim",
  --     "nvim-lua/plenary.nvim",
  --     "nvim-telescope/telescope.nvim"
  --   }
  -- })

  -- Automatically set up your configuration after cloning packer.nvim
  -- Put this at the end after all plugins
  if packer_bootstrap then
    require('packer').sync()
  end
end)


-- Lualine for status
require('lualine').setup {
  options = { theme = 'nord' }
}

-- setup must be called before loading the colorscheme
-- Default options:
require("gruvbox").setup({
  undercurl = true,
  underline = true,
  bold = true,
  italic = {
    strings = true,
    comments = true,
    operators = false,
    folds = true,
  },
  strikethrough = true,
  invert_selection = false,
  invert_signs = false,
  invert_tabline = false,
  invert_intend_guides = false,
  inverse = true, -- invert background for search, diffs, statuslines and errors
  contrast = "", -- can be "hard", "soft" or empty string
  palette_overrides = {},
  overrides = {},
  dim_inactive = false,
  transparent_mode = false,
})
vim.cmd("colorscheme gruvbox")

-- require('chatgpt').setup({
--   -- optional configuration
--   openai_params = {
--     -- model = "gpt-3.5-turbo",
--     model = "gpt-4",
--     frequency_penalty = 0,
--     presence_penalty = 0,
--     max_tokens = 2000,
--     temperature = 0,
--     top_p = 1,
--     n = 1,
--   },
--     openai_edit_params = {
--     -- model = "code-davinci-edit-001",
--     model = "gpt-3.5-turbo",
--     temperature = 0,
--     top_p = 1,
--     n = 1,
--   },
--   keymaps = {
--     close = { "<C-c>" },
--     submit = "<leader><Enter>",
--     yank_last = "<C-y>",
--     yank_last_code = "<C-k>",
--     scroll_up = "<C-u>",
--     scroll_down = "<C-d>",
--     toggle_settings = "<C-o>",
--     -- new session with leader-n
--     new_session = "<leader>n",
--     -- new_session = "<C-n>",
--     cycle_windows = "<Tab>",
--     -- in the Sessions pane
--     select_session = "<Space>",
--     rename_session = "r",
--     delete_session = "d",
--   },
-- })
--------------------
-- Key maps
-- Navigate buffers
local opts = { noremap = true, silent = true }
local builtin = require('telescope.builtin')

vim.api.nvim_set_keymap("n", "<C-l>", ":bnext<CR>", opts)
vim.api.nvim_set_keymap("n", "<C-h>", ":bprevious<CR>", opts)
vim.api.nvim_set_keymap("i", "jj", "<ESC>", opts)
vim.api.nvim_set_keymap("n", "<leader>w", ":bd<CR>", opts)
vim.api.nvim_set_keymap("n", "<leader>q", ":NvimTreeToggle<CR>", opts)
vim.api.nvim_set_keymap("n", "<C-p>", ":Telescope find_files<CR>", opts)
vim.keymap.set('n', '<leader>ff', builtin.find_files, {})
vim.keymap.set('n', '<leader>fg', builtin.live_grep, {})
vim.keymap.set('n', '<leader>,', builtin.buffers, {})
vim.keymap.set('n', '<leader>fh', builtin.help_tags, {})
vim.api.nvim_set_keymap("n", "<leader>s", ":Git<CR>", opts)
vim.api.nvim_set_keymap("i", "jdd", '<C-R>=strftime("%Y-%m-%d")<CR>', opts)
vim.api.nvim_set_keymap("i", "jii", '🚩 ', opts)

--
-- Arad: Run 'todo process'
-- nnoremap <silent> <leader>tp :silent !~/projects/todos/play.py process<CR>
vim.api.nvim_set_keymap("n", "<leader>tp", ":silent !~/projects/todos/.virtualenv/bin/python3 ~/projects/todos/play.py process<CR>", opts)


-- Nord color scheme
vim.g.nord_contrast = true
vim.g.nord_borders = true
vim.g.nord_disable_background = true
vim.g.nord_italic = true
vim.g.nord_uniform_diff_background = true
vim.g.nord_bold = true

require('nord').set()
vim.cmd[[colorscheme nord]]
--------------------

-- Treesitter syntax highlighting
require('nvim-treesitter.configs').setup({
  highlight = {
    enable = true,
  },
  ensure_installed = {
    'vim',
    'javascript',
    'typescript',
    'css',
    'json',
    'lua',
    'python',
    'vimdoc',
  },
})

-- # 2024-01-09 - this doesn't work for some reason, try again in the next version of treesitter/neovim
-- local function get_custom_foldtxt_suffix(foldstart)
--   local fold_suffix_str = string.format(
--     "  %s [%s lines]",
--     '┉',
--     vim.v.foldend - foldstart + 1
--   )
-- 
--   return { fold_suffix_str, "Folded" }
-- end
-- 
-- local function get_custom_foldtext(foldtxt_suffix, foldstart)
--   local line = vim.api.nvim_buf_get_lines(0, foldstart - 1, foldstart, false)[1]
-- 
--   return {
--     { line, "Normal" },
--     foldtxt_suffix
--   }
-- end
-- 
-- _G.get_foldtext = function()
--   local foldstart = vim.v.foldstart
--   local ts_foldtxt = vim.treesitter.foldtext()
--   local foldtxt_suffix = get_custom_foldtxt_suffix(foldstart)
-- 
--   if type(ts_foldtxt) == "string" then
--     return get_custom_foldtext(foldtxt_suffix, foldstart)
-- 	end
-- 
-- 	table.insert(ts_foldtxt, foldtxt_suffix)
-- 	return ts_foldtxt
-- end


vim.opt.foldmethod = "expr"
vim.opt.foldexpr = "v:lua.vim.treesitter.foldexpr()"
-- vim.opt.foldtext = "v:lua.vim.treesitter.foldtext()"
-- vim.opt.foldtext = "v:lua.get_foldtext()"

-- Import keyboard shortcuts from nvim-tree
-- require("nvim-tree-on-attach")
-- nvim-tree
require("nvim-tree").setup({
  -- on_attach = on_attach_nvim_tree,
  -- sort = {
  --   sorter = "case_insensitive",
  -- },
  view = {
    adaptive_size = true,
  },
  renderer = {
    group_empty = true,
    icons = {
      webdev_colors = false
    }
  },
  filters = {
    dotfiles = true,
  },
})

-- mini.nvim tabs
require('mini.tabline').setup({
  show_icons = true
})

-- dev icons
require'nvim-web-devicons'.setup {
  color_icons = true;
  default = true;
}

-- Telescope
local actions = require("telescope.actions")
require("telescope").setup{
  defaults = {
    mappings = {
      i = {
        ["<esc>"] = actions.close
      },
    },
  },
  -- Arad: note that below conf requires to build and install fzf-native
  extensions = {
    fzf = {
      fuzzy = true,                    -- false will only do exact matching
      override_generic_sorter = true,  -- override the generic sorter
      override_file_sorter = true,     -- override the file sorter
      case_mode = "smart_case",        -- or "ignore_case" or "respect_case"
                                       -- the default case_mode is "smart_case"
    }
  }
}

-- You dont need to set any of these options. These are the default ones. Only
-- the loading is important
require('telescope').setup {
}
-- To get fzf loaded and working with telescope, you need to call
-- load_extension, somewhere after setup function:
require('telescope').load_extension('fzf')

-- LSP Mappings.
-- See `:help vim.diagnostic.*` for documentation on any of the below functions
local opts = { noremap=true, silent=true }
vim.keymap.set('n', '<space>e', vim.diagnostic.open_float, opts)
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, opts)
vim.keymap.set('n', ']d', vim.diagnostic.goto_next, opts)
vim.keymap.set('n', '<space>q', vim.diagnostic.setloclist, opts)
vim.keymap.set('n', '<space>bl', function()
	-- Set background to light
  vim.cmd('colorscheme lunaperche')
  vim.cmd('set background=light')
end, opts)
	

-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
local on_attach = function(client, bufnr)
  -- Enable completion triggered by <c-x><c-o>
  vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

  -- Mappings.
  -- See `:help vim.lsp.*` for documentation on any of the below functions
  local bufopts = { noremap=true, silent=true, buffer=bufnr }
  vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, bufopts)
  vim.keymap.set('n', 'gd', vim.lsp.buf.definition, bufopts)
  vim.keymap.set('n', 'K', vim.lsp.buf.hover, bufopts)
  vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, bufopts)
  vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, bufopts)
  vim.keymap.set('n', '<space>wa', vim.lsp.buf.add_workspace_folder, bufopts)
  vim.keymap.set('n', '<space>wr', vim.lsp.buf.remove_workspace_folder, bufopts)
  vim.keymap.set('n', '<space>wl', function()
    print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
  end, bufopts)
  vim.keymap.set('n', '<space>D', vim.lsp.buf.type_definition, bufopts)
  vim.keymap.set('n', '<space>rn', vim.lsp.buf.rename, bufopts)
  vim.keymap.set('n', '<space>ca', vim.lsp.buf.code_action, bufopts)
  vim.keymap.set('n', 'gr', vim.lsp.buf.references, bufopts)
  vim.keymap.set('n', '<space>f', function() vim.lsp.buf.format { async = true } end, bufopts)
end

local lsp_flags = {
  -- This is the default in Nvim 0.7+
  debounce_text_changes = 150,
}
-- require('lspconfig')['pyright'].setup{
--     on_attach = on_attach,
--     flags = lsp_flags,
-- }
-- require('lspconfig')['tsserver'].setup{
--     on_attach = on_attach,
--     flags = lsp_flags,
-- }

local capabilities = require("cmp_nvim_lsp").default_capabilities()
local lspconfig = require('lspconfig')
-- Enable some language servers with the additional completion capabilities offered by nvim-cmp
local servers = { 'pyright', 'tsserver', 'ruff_lsp' }
for _, lsp in ipairs(servers) do
  lspconfig[lsp].setup {
    -- on_attach = my_custom_on_attach,
    capabilities = capabilities,
    on_attach = on_attach,
    flags = lsp_flags,
  }
end

-- nvim-cmp setup
local cmp = require 'cmp'
cmp.setup {
  mapping = cmp.mapping.preset.insert({
    ['<C-d>'] = cmp.mapping.scroll_docs(-4),
    ['<C-f>'] = cmp.mapping.scroll_docs(4),
    ['<C-Space>'] = cmp.mapping.complete(),
    ['<CR>'] = cmp.mapping.confirm {
      behavior = cmp.ConfirmBehavior.Replace,
      select = true,
    },
    ['<C-Tab>'] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_next_item()
      else
        fallback()
      end
    end, { 'i', 's' }),
    ['<S-Tab>'] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_prev_item()
      else
        fallback()
      end
    end, { 'i', 's' }),
  }),
  sources = {
    { name = 'nvim_lsp' },
  },
}

cmp.setup({
  sources = {
    {
      name = 'path',
    },
  },
})

-- local formatters = require "null-ls"
-- formatters.setup {
--   { command = "black", filetypes = { "python" } },
--   { command = "isort", filetypes = { "python" } },
--   { command = "shfmt", filetypes = { "sh" } },
-- }
require("null-ls").setup({
  sources = {
    require("null-ls").builtins.formatting.black
  },
  debug = true
})

-- Vimwiki
vim.g.vimwiki_auto_header = 1
vim.g.vimwiki_conceal_onechar_markers = 0
vim.g.vimwiki_dir_link = 'index'
vim.g.vimwiki_folding = 'syntax'
vim.g.vimwiki_use_calendar = 0
vim.g.vimwiki_key_mappings = { table_mappings = 0 }  -- prevent vimwiki from overriding 'tab' mapping (to make copilot work in vimwiki files)
-- let g:vimwiki_list = [{'path': '~/path/', 'listsyms' = '✗○◐●✓'}]
vim.g.vimwiki_listsyms = " ○◐●x"


wiki_prime = {
  auto_diary_index = 1,
  auto_generate_links = 1,
  auto_generate_tags = 1,
  auto_tags = 0,  -- don't automatically update tag metadata upon save
  auto_toc = 1,
  automatic_nested_syntaxes = 1,
  diary_caption_level = 2,
  list_margin = 0,  -- margin for lists, should be 0 for markdown
  name = 'tv',
  nested_syntaxes = {  -- provide formatting for nested syntax
    python = "python",
    lua = "lua",
    html = 'html'
  },
  path = '~/tv',
  syntax = 'markdown',
  ext = '.md'
}

vim.g.vimwiki_list = {wiki_prime}

-- Copilot
vim.g.copilot_filetypes = {markdown = true, vimwiki = true}
-- vim.g.copilot_filetypes = {{'python': v:true, 'lua': v:true, 'vimwiki': v:true, 'markdown': v:true}}
-- g:copilot_filetypes = {
--         \ 'markdown': v:true,
--     \ }
