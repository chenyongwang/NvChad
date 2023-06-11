local autocmd = vim.api.nvim_create_autocmd

-- Auto resize panes when resizing nvim window
-- autocmd("VimResized", {
--   pattern = "*",
--   command = "tabdo wincmd =",
-- })

-- 设置C/C++文件格式
autocmd('FileType', {
  pattern = {'c', 'cpp', 'h', 'hpp'},
  callback = function ()
    vim.opt.expandtab = true
    vim.opt.shiftwidth = 4
    vim.opt.smartindent = true
    vim.opt.tabstop = 4
    vim.opt.softtabstop = 4
  end
})
