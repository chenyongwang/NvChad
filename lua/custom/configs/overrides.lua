local M = {}

M.treesitter = {
  ensure_installed = {
    "vim",
    "lua",
    "html",
    "css",
    "javascript",
    "typescript",
    "tsx",
    "c",
    "markdown",
    "markdown_inline",
  },
  indent = {
    enable = true,
    -- disable = {
    --   "python"
    -- },
  },
}

M.mason = {
  ensure_installed = {
    -- lua stuff
    "lua-language-server",
    "stylua",

    -- web dev stuff
    "css-lsp",
    "html-lsp",
    "typescript-language-server",
    "deno",
    "prettier",

    -- c/cpp stuff
    "clangd",
    "clang-format",
  },
}

-- git support in nvimtree
M.nvimtree = {
  git = {
    enable = true,
  },

  renderer = {
    highlight_git = true,
    icons = {
      show = {
        git = true,
      },
    },
  },

  view = {
    width = 25,
  },
}

M.nvterm = {
  terminals = {
    type_opts = {
      float = {
        row = 0.1,
        col = 0.1,
        width = 0.75,
        height = 0.75,
      },
      vertical = { location = "rightbelow", split_ratio = 0.4 },
    },
  },
}

M.telescope = {
  defaults = {
    layout_config = {
      horizontal = {
        prompt_position = "top",
        preview_width = 0.60,
        results_width = 0.90,
      },
      width = 0.93,
      height = 0.90,
      preview_cutoff = 1,
    },
    preview = {
      filesize_limit = 1,
    },
  },
}

return M
