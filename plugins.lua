local overrides = require "custom.configs.overrides"

---@type NvPluginSpec[]
local plugins = {

  -- Override plugin definition options
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      -- format & linting
      {
        "jose-elias-alvarez/null-ls.nvim",
        config = function()
          require "custom.configs.null-ls"
        end,
      },
    },
    config = function()
      require "plugins.configs.lspconfig"
      require "custom.configs.lspconfig"
    end, -- Override to setup mason-lspconfig
  },

  -- override plugin configs
  {
    "williamboman/mason.nvim",
    dependencies = {
      "jay-babu/mason-nvim-dap.nvim",
    },
    opts = overrides.mason,
  },

  {
    "nvim-treesitter/nvim-treesitter",
    opts = overrides.treesitter,
  },

  {
    "nvim-tree/nvim-tree.lua",
    opts = overrides.nvimtree,
  },

  {
    "nvim-telescope/telescope.nvim",
    opts = overrides.telescope,
  },

  -- Install a plugin

  -- General
  {
    "max397574/better-escape.nvim",
    event = "InsertEnter",
    config = function()
      require("better_escape").setup()
    end,
  },

  {
    "christoomey/vim-tmux-navigator",
    lazy = false,
  },

  {
    "jghauser/mkdir.nvim",
    event = "BufWritePre",
  },

  {
    "hrsh7th/nvim-cmp",
    opts = function()
      local M = require "plugins.configs.cmp"
      table.insert(M.sources, { name = "crates" })
      return M
    end,
  },

  {
    "kdheepak/lazygit.nvim",
    dependencies = {
      "nvim-telescope/telescope.nvim",
      "nvim-lua/plenary.nvim",
    },
    cmd = {
      "LazyGit",
    },
    keys = {
      { "<leader>lg", "<cmd>LazyGit<CR>", desc = "LazyGit" },
    },
    config = function()
      require("telescope").load_extension "lazygit"
    end,
  },

  {
    "github/copilot.vim",
    cmd = {
      "Copilot",
    },
    keys = {
      { "<leader>cp", "<cmd>Copilot<CR>", desc = "Copilot" },
    },
  },

  {
    "Dhanus3133/LeetBuddy.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-telescope/telescope.nvim",
    },
    config = function()
      require("leetbuddy").setup {
        domain = "com",
        language = "rust",
      }
    end,
    keys = {
      { "<leader>leq", "<cmd>LBQuestions<CR>", desc = "List Questions" },
      { "<leader>lel", "<cmd>LBQuestion<CR>", desc = "View Question" },
      { "<leader>ler", "<cmd>LBReset<CR>", desc = "Reset Code" },
      { "<leader>let", "<cmd>LBTest<CR>", desc = "Run Code" },
      { "<leader>les", "<cmd>LBSubmit<CR>", desc = "Submit Code" },
    },
  },

  -- {
  --   "wfxr/minimap.vim",
  --   build = "cargo install --locked code-minimap",
  --   cmd = { "Minimap", "MinimapClose", "MinimapToggle", "MinimapRefresh", "MinimapUpdateHighlight" },
  --   keys = {
  --     { "<leader>mm", "<cmd>MinimapToggle<CR>", desc = "Toggle Minimap" },
  --   },
  --   init = function()
  --     vim.g.minimap_width = 5
  --     vim.g.minimap_left = 0
  --     vim.g.minimap_block_filetypes = { "fugitive", "nvim-tree", "tagbar", "fzf", "telescope", "NvimTree" }
  --     vim.g.minimap_block_buftypes = { "nofile", "nowrite", "quickfix", "terminal", "prompt", "NvimTree" }
  --     vim.g.minimap_close_filetypes = { "startify", "netrw", "vim-plug", "NvimTree" }
  --     vim.g.minimap_highlight_range = 1
  --     vim.g.minimap_highlight_search = 1
  --     vim.g.minimap_git_colors = 1
  --   end,
  -- },

  -- python

  {
    "mfussenegger/nvim-dap-python",
    ft = { "py", "python" },
    dependencies = {
      "mfussenegger/nvim-dap",
      "rcarriga/nvim-dap-ui",
    },
  },

  -- rust

  {
    "rust-lang/rust.vim",
    ft = "rust",
    init = function()
      vim.g.rustfmt_autosave = 1
    end,
  },

  {
    "saecki/crates.nvim",
    tag = "v0.3.0",
    event = { "BufRead Cargo.toml" },
    ft = { "rust", "toml" },
    dependencies = { "nvim-lua/plenary.nvim", "hrsh7th/nvim-cmp" },
    config = function(_, opts)
      local crates = require "crates"
      crates.setup(opts)
      crates.show()
    end,
  },

  {
    "simrat39/rust-tools.nvim",
    dependencies = "neovim/nvim-lspconfig",
    ft = "rust",
    opts = function()
      require "custom.configs.rust-tools"
    end,
    config = function(_, opts)
      require("rust-tools").setup(opts)
    end,
  },

  -- go

  {
    "ray-x/go.nvim",
    dependencies = { -- optional packages
      "ray-x/guihua.lua",
      "neovim/nvim-lspconfig",
      "nvim-treesitter/nvim-treesitter",
    },
    config = function()
      require("go").setup()
    end,
    ft = { "go", "gomod" },
    build = ':lua require("go.install").update_all_sync()', -- if you need to install/update all binaries
  },
}

return plugins
