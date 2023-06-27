--@type MappingsTable
local M = {}

M.general = {
  n = {
    [";"] = { ":", "enter command mode", opts = { nowait = true } },
    ["<leader>tt"] = { "<cmd> SymbolsOutline <CR>", "Open SymbolsOutline", opts = { nowait = true } },
    ["<leader>fa"] = { "^", "Beginning of line", opts = { nowait = true, silent = true } },
    ["<leader>fe"] = { "$", "End of line", opts = { nowait = true, silent = true } },
    ["gw"] = { "<C-w>w", "光标切换到下一个窗口", opts = { nowait = true, silent = true } },
    ["<Left>"] = { "h", "光标左移一个字符", opts = { noremap = true, nowait = true, silent = true } },
    ["<Right>"] = { "l", "光标右移一个字符", opts = { noremap = true, nowait = true, silent = true } },

    -- 上下快速移动5行光标
    ["<C-Down>"] = { "5j", "Move down 5 lines", opts = { noremap = true, nowait = true, silent = true } },
    ["<A-j>"] = { "5j", "Move down 5 lines", opts = { noremap = true, nowait = true, silent = true } },
    ["<C-Up>"] = { "5k", "Move up 5 lines", opts = { noremap = true, nowait = true, silent = true } },
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
      "<cmd> yy <CR>p",
      "Duplicate current line",
      opts = { noremap = true, nowait = true, silent = true },
    },

    -- 窗口大小管理
    ["<A-.>"] = {
      "winnr() <= winnr('$') - winnr() ? '<c-w>3>' : '<c-w>3<'",
      "窗口大小向左增加3",
      opts = { noremap = true, expr = true },
    },
    ["<A-,>"] = {
      "winnr() <= winnr('$') - winnr() ? '<c-w>3<' : '<c-w>3>'",
      "窗口大小向右增加3",
      opts = { noremap = true, expr = true },
    },
    ["<A-+>"] = {
      "winnr() <= winnr('$') - winnr() ? '<c-w>3+' : '<c-w>3-'",
      "窗口水平方向大小增加3",
      opts = { noremap = true, expr = true },
    },
    ["<A-_>"] = {
      "winnr() <= winnr('$') - winnr() ? '<c-w>3-' : '<c-w>3+'",
      "窗口水平方向大小减小3",
      opts = { noremap = true, expr = true },
    },

    ["<A-`>"] = {
      -- "<cmd> lua require('goto-preview').close_all_win()<CR>",
      "<cmd> q <CR>",
      "关闭当前窗口",
      opts = { noremap = true, silent = true },
    },

    ["<leader>gl"] = {
      "<cmd> Gitsigns toggle_current_line_blame <CR>",
      "显示当前行Git提交信息",
      opts = { noremap = true, nowait = true, silent = true },
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
      ":m '<-2<CR>gv=gv",
      "将当前行内容向上移动一行",
      opts = { noremap = true, nowait = true, silent = true },
    },
    ["<C-S-Down>"] = {
      ":m '>+1<CR>gv=gv",
      "将当前行内容向下移动一行",
      opts = { noremap = true, nowait = true, silent = true },
    },

    -- 上下快速移动3行
    ["<A-j>"] = { "3j", "Move down 3 lines", opts = { noremap = true, nowait = true, silent = true } },
    ["<A-k>"] = { "3k", "Move up 3 lines", opts = { noremap = true, nowait = true, silent = true } },

    -- 左/右快速移动光标
    ["<A-l>"] = { "<C-Right>", "光标快速向右移动一个单词", opts = { noremap = true, nowait = true } },
    ["<A-h>"] = { "<C-Left>", "光标快速向左移动一个单词", opts = { noremap = true, nowait = true } },

    ["<leader>gl"] = {
      "<cmd> Gitsigns toggle_current_line_blame <CR>",
      "显示当前行Git提交信息",
      opts = { noremap = true, nowait = true, silent = true },
    },
  },
}

M.floatwindow = {
  plugin = false,

  n = {

    ["<leader>wt"] = {
      "<cmd> FloatToTop <Cr>",
      "浮动窗口置顶",
      opts = { noremap = true, nowait = true, silent = true },
    },
    ["<leader>wg"] = {
      "<cmd> FloatRearrangeByGrid <Cr>",
      "浮动窗口按照网格排列",
      opts = { noremap = true, nowait = true, silent = true },
    },
    ["<leader>wf"] = {
      "<cmd> FloatRearrangeByFalls <Cr>",
      "浮动窗口按照瀑布排列",
      opts = { noremap = true, nowait = true, silent = true },
    },
    ["<leader>we"] = {
      "<cmd> FloatOpenInMainWin <Cr>",
      "在主窗口打开当前浮动窗口",
      opts = { noremap = true, nowait = true, silent = true },
    },
  },
}

M.translator = {
  -- 一些自定义插件plugin需要设置成false，否则快捷键不被加载
  plugin = false,

  n = {
    ["<A-t>"] = {
      "<cmd> Translate <CR>",
      "翻译",
      opts = { noremap = true, nowait = true, silent = true },
    },
    ["<leader>tw"] = {
      "<cmd> TranslateW <CR>",
      "弹窗翻译",
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
    ["<leader>tw"] = {
      "<cmd> TranslateW <CR>",
      "弹窗翻译",
      opts = { noremap = true, nowait = true, silent = true },
    },
  },
}

M.nvimtree = {
  plugin = true,

  n = {
    -- toggle
    ["<A-e>"] = {
      "<cmd> NvimTreeToggle <CR>",
      "Toggle nvimtree",
      opts = { noremap = true, nowait = true, silent = true },
    },

    -- focus
    ["<leader>e"] = { "<cmd> NvimTreeFocus <CR>", "Focus nvimtree" },
  },

  i = {
    -- toggle
    ["<A-e>"] = {
      "<cmd> NvimTreeToggle <CR>",
      "Toggle nvimtree",
      opts = { noremap = true, nowait = true, silent = true },
    },
  },

  v = {
    -- toggle
    ["<A-e>"] = {
      "<cmd> NvimTreeToggle <CR>",
      "Toggle nvimtree",
      opts = { noremap = true, nowait = true, silent = true },
    },
  },
}

M.visualmulti = {
  plugin = false,

  n = {
    -- 强制覆盖原来nvterm设置的C-n
    ["<C-n>"] = {
      "<cmd> :call vm#commands#add_cursor_at_pos(0) <CR>",
      "进入多行操作模式",
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
    ["<A-`>"] = {
      function()
        vim.cmd "stopinsert"
      end,
      "Nvterm 进入插入模式",
      opts = { noremap = true, nowait = true, silent = true },
    },
  },
}

-- more keybinds!
return M
