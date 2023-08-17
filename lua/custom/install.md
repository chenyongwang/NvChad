[TOC]

# 下载安装nvim

*   到 <https://github.com/neovim/neovim/releases> 中下载对应的版本，建议要大于等于0.9版本，下载后将目录bin设置都系统PATH路径中
*   一个用rust开发的编辑器，集成了不少vim中要单独配置的插件，[GitHub - helix-editor/helix: A post-modern modal text editor.](https://github.com/helix-editor/helix) ，快捷键与nvim差不多

## 字体安装

*   配置好nvim后需要你的终端支持特殊字符，因此需要在终端机上安装[Nerd Font](https://www.nerdfonts.com/font-downloads)字体
*   Windows: 建议安装 <https://www.nerdfonts.com/font-downloads> 中的 DejaVuSansMono 字体，下载后解压直接选中所有ttf文件进行安装
*   Linux: 下载字体后参考 <https://blog.csdn.net/A___LEi/article/details/118113211> 安装方法，如果不在Linux系统上打开可以不用安装

    > 注意shell软件需要设置字体为安装的字体才能正常显示状态栏的特殊字符

## 设置光标所在行列背景颜色

```text
:set cursorline
:set cursorcolumn
:hi CursorLine cterm=none ctermbg=none guibg=grey20 guifg=none
:hi CursorColumn cterm=none ctermbg=none guibg=grey20 guifg=none
```

*   行：  \:set cursorline

## 其他参考项目

*   [LunarVim](https://www.lunarvim.org/zh-Hans/)，这个有很多插件可以参考
*   [Vim参考大全](https://harttle.land/vim-practice.html)，有丰富的Vim操作介绍
*   [一个开箱即用的nvim配置](https://github.com/yaocccc/nvim)

# 通过NvChad 2.0快速安装插件

*   [NvChad](https://nvchad.com/) 是一个开箱即用的nvim插件管理配置项目，通过它可以快速配置和安装需要的插件，更多内容可以参考它的文档
*   有必要安装ripgrep, yum install -y ripgrep，如果无法安装则可参考 <https://github.com/BurntSushi/ripgrep> 项目源码
*   下载安装命令
    ```shell
    # 请参考 https://nvchad.com/docs/quickstart/install 中的安装方法
    git clone https://github.com/NvChad/NvChad ~/.config/nvim --depth 1 && nvim
    ```
*   上面下载安装命令会自动触发网络下载一些默认配置，配置会放在`~/.config/nvim/lua/custom`下，后续主要通过修改该目录下的文件来完成自定义内容

    ```shell
    ├── chadrc.lua
    ├── configs
    │   ├── lspconfig.lua  # 添加一些语言自动提示支持
    │   ├── null-ls.lua
    │   └── overrides.lua
    ├── highlights.lua
    ├── init.lua
    ├── mappings.lua    # 修改自定义的快捷键
    ├── plugins.lua  # 增加一些有用的插件
    └── README.md
    ```
*   NvChad通过[Mason](https://github.com/williamboman/mason.nvim)来管理语言插件，nvim启动后可执行命令 \:MasonInstall x (x是随意输入字符)，会弹出都有哪些LSP可以安装，选中对应的按 `i` 键进行安装
*   NvChad通过[Lazy](https://github.com/folke/lazy.nvim)来管理插件，当你在`plugins.lua`中添加了插件后，输入命令 \:Lazy 则会弹出安装界面，最后按 `q` 键退出

# 通过NvChad 2.0设置Go开发环境

*   首先安装好Go语言开发环境，并设置好环境变量
*   通过Mason安装Golang的LSP，在nvim中执行命令 \:MasonInstall gopls gofumpt goimports golines gomodifytags gotests
*   修改custom/configs/lspconfig.lua文件，在servers = 中增加 "gopls"即可，后续要加其他语言也是如此
*   安装Go语言高亮，执行命令 \:TSInstall go ，其他语言也类似，可以执行 \:TSInstallInfo 命令查看都有支持哪些语言

# 一些有用的插件

> 大多数lua插件都会统一提供setup(opts)函数，插件的内有默认参数，如果需要修改默认参数则通过opts参数传入即可

在`~/.config/nvim/lua/custom/configs/overides.lua`中修改HvChad默认的一些配置，使得更美观一下

```lua
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
        width = 0.80,
        height = 0.80,
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

```

在`~/.config/nvim/lua/custom/plugins.lua`内添加自己的插件以及配置

```lua
  {
    "nvim-telescope/telescope.nvim",
    opts = overrides.telescope,
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
    "mg979/vim-visual-multi",
    lazy = false,
  },

  {
    "fatih/vim-go",
    lazy = false,
    ff = { "go" },
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

```

# 快捷键配置

*   默认的`leader`键是空格键，C代表Ctrl, S代表Shift，A代表Alt
*   在normal模式中通过`空格键ch`查看
*   NvChad的默认快捷键配置在`~/.config/nvim/lua/core/mappings.lua`中
*   自定义快捷键可在`~/.config/nvim/lua/custom/mappings.lua`中设置
    ```lua
    local M = {}
    M.general = {
        -- 代表normal模式下的快捷键
        n = {},
        -- 代表insert模式下的快捷键
        i = {},
        -- 代表virsul模式下的快捷键
        v = {},
        -- 代表command模式下的快捷键
        t = {},
    }

    -- 为了更易区分，可以给M加对应插件的名称的变量，这里是修改nvterm这个插件的快捷键
    M.nvterm = {
        n = {},
        t = {},
    }
    return M
    ```

# 我的快捷键

```lua
local M = {}

M.general = {
  n = {
    [";"] = { ":", "enter command mode", opts = { nowait = true } },
    ["<leader>tt"] = { "<cmd> SymbolsOutline <CR>", "Open SymbolsOutline", opts = { nowait = true } },
    ["<leader>fa"] = { "^", "Beginning of line", opts = { nowait = true, silent = true } },
    ["<leader>fe"] = { "$", "End of line", opts = { nowait = true, silent = true } },
    ["<Left>"] = { "h", "光标左移一个字符", opts = { noremap = true, nowait = true, silent = true } },
    ["<Right>"] = { "l", "光标右移一个字符", opts = { noremap = true, nowait = true, silent = true } },

    ["<A-b>"] = { ":b <tab>", "列出当前所有打开文件名列表" },

    -- 上下快速移动5行光标
    ["<C-Down>"] = { "5j", "Move down 5 lines", opts = { nowait = true, silent = true } },
    ["<A-j>"] = { "5j", "Move down 5 lines", opts = { nowait = true, silent = true } },
    ["<C-Up>"] = { "5k", "Move up 5 lines", opts = { nowait = true, silent = true } },
    ["<A-k>"] = { "5k", "Move up 5 lines", opts = { noremap = true, nowait = true, silent = true } },

    -- 左/右快速移动光标
    ["<A-l>"] = { "<C-Right>", "光标快速向右移动一个单词", opts = { noremap = true, nowait = true } },
    ["<A-h>"] = { "<C-Left>", "光标快速向左移动一个单词", opts = { noremap = true, nowait = true } },

    -- 上/下移当前行内容
    ["<C-S-Up>"] = {
      ":m .-2<CR>",
      "将当前行内容向上移动一行",
      opts = { noremap = true, nowait = true, silent = true },
    },
    ["<C-S-Down>"] = {
      ":m .+1<CR>",
      "将当前行内容向下移动一行",
      opts = { noremap = true, nowait = true, silent = true },
    },

    -- 复制当前行内容并在下一行粘贴
    ["<C-d><C-d>"] = {
      ":y1 <CR>p",
      "Duplicate current line",
      opts = { noremap = true, nowait = true, silent = true },
    },

    -- 窗口大小管理
    ["<A-.>"] = {
      "winnr() <= winnr('$') - winnr() ? '<c-w>5>' : '<c-w>5<'",
      "窗口大小向左增加5",
      opts = { noremap = true, expr = true },
    },
    ["<A-,>"] = {
      "winnr() <= winnr('$') - winnr() ? '<c-w>5<' : '<c-w>5>'",
      "窗口大小向右增加5",
      opts = { noremap = true, expr = true },
    },
    ["<A-+>"] = {
      "窗口水平方向大小增加5",
      opts = { noremap = true, expr = true },
    },
    ["<A-_>"] = {
      "winnr() <= winnr('$') - winnr() ? '<c-w>5-' : '<c-w>5+'",
      "窗口水平方向大小减小5",
      opts = { noremap = true, expr = true },
    },

    ["<A-`>"] = {
      -- "<cmd> lua require('goto-preview').close_all_win()<CR>",
      "<cmd>:q<CR>",
      "关闭当前窗口",
      opts = { noremap = true, silent = true },
    },
  },

  i = {
    -- 向上快速移动5行
    ["<C-Down>"] = {
      "<Esc>5ji",
      "Move down 5 lines",
      opts = { noremap = true, nowait = true, silent = true },
    },

    -- 向下快速移动5行
    ["<C-Up>"] = { "<Esc>5ki", "Move up 5 lines", opts = { noremap = true, nowait = true, silent = true } },

    -- 保存文件
    ["<C-s>"] = { "<Esc><cmd> w <CR>a", "Save file", opts = { noremap = true, nowait = true, silent = true } },

    -- 撤销
    ["<C-z>"] = { "<Esc>ui", "撤销上一操作", opts = { noremap = true, nowait = true, silent = true } },

    -- 向右删除一个单词
    ["<C-x>"] = { "<C-o>dw", "Delete rigth word", opts = { noremap = true, nowait = true, silent = true } },
    ["<A-d>"] = { "<C-o>dw", "Delete right word", opts = { noremap = true, nowait = true } },
    -- 向左删除一个单词，与Ctrl+w一样
    ["<A-r>"] = { "<C-w>", "Delete left word", opts = { noremap = true, nowait = true } },

    -- 复制当前行内容并在下一行粘贴
    ["<C-d><C-d>"] = {
      "<Esc> :y1 <CR>pi",
      "Duplicate current line",
      opts = { noremap = true, nowait = true, silent = true },
    },

    -- 上/下移当前行内容
    ["<C-S-Up>"] = {
      "<Esc>:m .-2<CR>a",
      opts = { noremap = true, nowait = true, silent = true },
      "将当前行内容向上移动一行",
    },
    ["<C-S-Down>"] = {
      "<Esc>:m .+1<CR>a",
      "将当前行内容向下移动一行",
      opts = { noremap = true, nowait = true, silent = true },
    },

    -- 左/右快速移动光标
    ["<A-l>"] = { "<C-Right>", "光标快速向右移动一个单词", opts = { noremap = true, nowait = true } },
    ["<A-h>"] = { "<C-Left>", "光标快速向左移动一个单词", opts = { noremap = true, nowait = true } },
  },

  v = {
    -- 上/下移当前行内容
    ["<C-S-Up>"] = {
      ":m <-2<CR>gv",
      "将当前行内容向上移动一行",
      opts = { noremap = true, nowait = true, silent = true },
    },
    ["<C-S-Down>"] = {
      ":m '>+1<CR>gv",
      "将当前行内容向下移动一行",
      opts = { noremap = true, nowait = true, silent = true },
    },

    -- 左/右快速移动光标
    ["<A-l>"] = { "<C-Right>", "光标快速向右移动一个单词", opts = { noremap = true, nowait = true } },
    ["<A-h>"] = { "<C-Left>", "光标快速向左移动一个单词", opts = { noremap = true, nowait = true } },
  },
}

M.translator = {
  plugin = true,

  n = {
    ["<A-t>"] = {
      "<cmd> Translate <CR>",
      "翻译",
      opts = { noremap = true, nowait = true, silent = true },
    },
  },

  i = {
    ["<A-t>"] = {
      "<Esc><cmd> Translate <CR>a",
      "翻译",
      opts = { noremap = true, nowait = true, silent = true },
    },
  },

  v = {
    ["<A-t>"] = {
      "<cmd> Translate <CR>",
      "翻译",
      opts = { noremap = true, nowait = true, silent = true },
    },
  },
}

M.nvterm = {
  plugin = true,

  n = {
    ["<A-m>"] = {
      function()
        require("nvterm.terminal").toggle "horizontal"
      end,
      "Toggle horizontal term",
      opts = { noremap = true, nowait = true, silent = true },
    },
  },

  t = {
    ["<A-m>"] = {
      function()
        require("nvterm.terminal").toggle "horizontal"
      end,
      "Toggle horizontal term",
      opts = { noremap = true, nowait = true, silent = true },
    },
  },
}

-- more keybinds!
return M
```

