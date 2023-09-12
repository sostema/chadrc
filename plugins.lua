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
    "mfussenegger/nvim-dap-python",
    ft = "python",
    dependencies = {
      "mfussenegger/nvim-dap",
      "rcarriga/nvim-dap-ui",
    },
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
    "ray-x/go.nvim",
    dependencies = { -- optional packages
      "ray-x/guihua.lua",
      "neovim/nvim-lspconfig",
      "nvim-treesitter/nvim-treesitter",
    },
    config = function()
      require("go").setup()
    end,
    event = { "CmdlineEnter" },
    ft = { "go", "gomod" },
    build = ':lua require("go.install").update_all_sync()', -- if you need to install/update all binaries
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
        language = "go",
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
  -- To make a plugin not be loaded
  -- {
  --   "NvChad/nvim-colorizer.lua",
  --   enabled = false
  -- },

  -- All NvChad plugins are lazy-loaded by default
  -- For a plugin to be loaded, you will need to set either `ft`, `cmd`, `keys`, `event`, or set `lazy = false`
  -- If you want a plugin to load on startup, add `lazy = false` to a plugin spec, for example
  -- {
  --   "mg979/vim-visual-multi",
  --   lazy = false,
  -- }

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

}

return plugins
