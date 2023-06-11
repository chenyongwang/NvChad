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
    "NvChad/nvterm",
    opts = overrides.nvterm,
  },

  {
    "nvim-telescope/telescope.nvim",
    opts = overrides.telescope,
  },

  {
    "williamboman/mason.nvim",
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

  -- Install a plugin
  {
    "max397574/better-escape.nvim",
    event = "InsertEnter",
    config = function()
      require("better_escape").setup()
    end,
  },

  -- To make a plugin not be loaded
  -- {
  --   "NvChad/nvim-colorizer.lua",
  --   enabled = false
  -- },

  -- All NvChad plugins are lazy-loaded by default
  -- For a plugin to be loaded, you will need to set either `ft`, `cmd`, `keys`, `event`, or set `lazy = false`
  -- If you want a plugin to load on startup, add `lazy = false` to a plugin spec, for example
  {
    "mg979/vim-visual-multi",
    lazy = false,
  },

  {
    "fatih/vim-go",
    lazy = false,
    ff = { "go" },
    config = function()
      --require("vim-go").setup()
    end,
  },

  {
    "simrat39/symbols-outline.nvim",
    lazy = false,
    config = function()
      require("symbols-outline").setup()
    end,
  },

  {
    "voldikss/vim-translator",
    lazy = false,
  },

  {
    "rmagatti/goto-preview",
    lazy = false,
    config = function()
      require("goto-preview").setup {
        default_mappings = true,
        width = 118,
        height = 30,
        -- opacity = 50,
        resizing_mappings = true,
        references = {
          telescope = require("telescope.themes").get_dropdown {
            hide_preview = false,
            layout_config = {
              preview_cutoff = 1,
              width = function(_, max_columns, _)
                return math.min(max_columns, 140)
              end,

              height = function(_, _, max_lines)
                return math.min(max_lines, 10)
              end,
            },
          },
        },
      }
    end,
  },

  -- Markdown目录生成工具
  {
    "mzlogin/vim-markdown-toc",
    lazy = false,
  },

  {
    "LintaoAmons/scratch.nvim",
    event = "VimEnter",
  },

  {
    "Pocco81/auto-save.nvim",
    lazy = false,
    config = function()
      require("auto-save").setup {
        -- your config goes here
        -- or just leave it empty :)
      }
    end,
  },

  -- {
  --   "hkupty/nvimux",
  --   lazy = false,
  --   config = function()
  --     local nvimux = require "nvimux"
  --     nvimux.setup {
  --       config = {
  --         prefix = "<C-a>",
  --      },
  --       bindings = {
  --         { { "n", "v", "i", "t" }, "s", nvimux.commands.horizontal_split },
  --         { { "n", "v", "i", "t" }, "v", nvimux.commands.vertical_split },
  --       },
  --     }
  --   end,
  -- },
}

return plugins
