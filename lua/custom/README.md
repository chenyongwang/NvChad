# Example_config

This can be used as an example custom config for NvChad, this branch is a minimal one. Do check the feature_full branch if you need all the ease in your config

# Golang开发环境设置

已为Go语言安装对应的vim-go插件，当第一次启动时需要通过Mason安装对应工具

- goimports
- goimports-reviser
- golines
- gomodifytags
- gopls
- gotests


# 修改vim statusline主题

基于~/.local/share/nvim/lazy/ui/lua/nvchad/statusline/default.lua文件修改，修改前建议保存好default.lua文件
1. 修改M.fileInfo函数，将local filename的%:t改为%:.显示全路径
2. 添加函数，以下函数从vscode.lua中拷贝而来

   ```lua
   M.cursor_position_line_and_column = function()
   M.file_encoding = function()
   ```
3. run函数中对应位置添加 

   ```lua
   modules.cursor_position_line_and_column(),
   modules.file_encoding(),
   ```
