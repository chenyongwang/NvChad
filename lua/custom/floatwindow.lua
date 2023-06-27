local M = {}

local function is_float_window(win_id)
  local win_config = vim.api.nvim_win_get_config(win_id)
  return win_config.relative ~= "", win_config
end

local function get_float_windows()
  local result = {}
  local ids = vim.api.nvim_list_wins()
  for _, id in ipairs(ids) do
    local ok, conf = is_float_window(id)
    if ok then
      table.insert(result, { id = id, conf = conf })
    end
  end
  return result
end

local function find_char(s, ch, idx)
  local b = string.byte(ch)
  for i = 1, idx or #s, 1 do
    if string.byte(s, i, i) == b then
      return i
    end
  end
  return nil
end

local function get_float_win_title(win_conf, index)
  local c = "─"
  local file_name = win_conf.title[1][1]
  local idx = find_char(file_name, c)
  if idx ~= nil then
    file_name = string.sub(file_name, 1, idx - 1)
  end

  return { { file_name .. "──────#" .. index .. "#", win_conf.title[1][2] } }
end

M.float_to_top = function()
  -- 获取当前光标所在窗口
  local current_win = vim.api.nvim_get_current_win()
  -- 如果不是浮动窗口则直接退出
  if not is_float_window(current_win) then
    return
  end

  local float_wins = get_float_windows()
  local num_wins = #float_wins
  if num_wins == 1 then
    return
  end

  -- 设置 z-index 使光标所在窗口上浮到最前面
  vim.api.nvim_win_set_config(current_win, { zindex = num_wins })
end

M.open_float_in_main_win = function()
  -- 获取光标所在的窗口
  local current_win = vim.api.nvim_get_current_win()

  -- 检查当前窗口是否为 float 窗口
  if not is_float_window(current_win) then
    return
  end

  -- 获取 float 窗口的缓冲区
  local buf = vim.api.nvim_win_get_buf(current_win)
  local cursor = vim.api.nvim_win_get_cursor(current_win)
  local file = vim.api.nvim_buf_get_name(buf)

  -- 关闭当前 float 窗口
  -- vim.api.nvim_win_close(current_win, false)

  -- 关闭所有 float 窗口
  local float_windows = get_float_windows()
  for _, win in ipairs(float_windows) do
    vim.api.nvim_win_close(win.id, false)
  end

  -- 在主窗口中编辑指定文件并跳转到指定位置
  vim.api.nvim_command("edit " .. file)
  vim.api.nvim_win_set_cursor(0, cursor)
end

M.rearrange_float_windows_by_grid = function()
  local float_wins = get_float_windows()
  local num_wins = #float_wins

  if num_wins <= 1 then
    local w_ratio = 0.45
    local h_ratio = 0.9
    vim.api.nvim_win_set_config(float_wins[1].id, {
      relative = "editor",
      width = math.ceil(vim.o.columns * w_ratio),
      height = math.ceil(vim.o.lines * h_ratio),
      col = math.ceil(vim.o.columns * (1 - w_ratio)),
      row = math.ceil(vim.o.lines * (1 - h_ratio)),
    })
    return
  end

  -- 计算 float 窗口网格状布局
  local offset = 2
  local ratio = 0.88
  local grid_size = math.ceil(math.sqrt(num_wins))
  local width = math.ceil(vim.o.columns * ratio / grid_size) - offset
  local height = math.ceil(vim.o.lines * ratio / grid_size) - offset
  if num_wins == 2 then
    height = math.ceil(vim.o.lines * ratio) - offset
  end
  local start_col = math.ceil(vim.o.columns * (1 - ratio) / 2)
  local start_row = math.ceil(vim.o.lines * (1 - ratio) / 2)

  local index = num_wins
  local n = 0
  for row = 0, grid_size - 1 do
    n = n + 1
    local m = 0
    for col = 0, grid_size - 1 do
      m = m + 1
      if index >= 1 then
        local c = start_col + col * width
        local r = start_row + row * height
        if n > 1 and row ~= 0 then
          r = r + (n - 1) * offset
        end
        if m > 1 and col ~= 0 then
          c = c + (m - 1) * offset
        end
        -- 更新 float 窗口的位置和大小
        local win = float_wins[index]
        vim.api.nvim_win_set_config(win.id, {
          relative = "editor",
          width = width,
          height = height,
          col = c,
          row = r,
          title = get_float_win_title(win.conf, num_wins - index + 1),
        })

        index = index - 1
      end
    end
  end
end

M.rearrange_float_windows_by_falls = function()
  local float_wins = get_float_windows()
  local num_wins = #float_wins

  if num_wins <= 1 then
    return
  end

  -- 用于计算窗口大小和偏移量的基本值
  local col_offset = 10
  local row_offset = 3
  local total_columns = vim.o.columns
  local total_rows = vim.o.lines
  local start_col = math.ceil(total_columns * 0.33)
  local start_row = math.ceil(total_rows * 0.28)
  local base_width = math.min(total_columns - start_col - num_wins * col_offset, 100)
  local base_height = math.min(total_rows - start_row - num_wins * row_offset, 30)

  for index, win in ipairs(float_wins) do
    -- 计算每个 float 窗口的新布局
    local col = (num_wins - index) * col_offset
    local row = (num_wins - index) * row_offset

    -- 更新 float 窗口的位置和大小
    vim.api.nvim_win_set_config(win.id, {
      relative = "editor",
      width = base_width,
      height = base_height,
      col = start_col + col,
      row = start_row + row,
      zindex = num_wins,
      title = get_float_win_title(win.conf, num_wins - index + 1),
    })
  end
end

local function register_commands()
  local commands = {
    FloatToTop = M.float_to_top,
    FloatOpenInMainWin = M.open_float_in_main_win,
    FloatRearrangeByGrid = M.rearrange_float_windows_by_grid,
    FloatRearrangeByFalls = M.rearrange_float_windows_by_falls,
  }

  -- 逐个为表中的每个函数创建一个命令
  for cmd_name, cmd_func in pairs(commands) do
    -- `lua-command-name` 是全局的，因此需要在函数名前加上模块名来确保唯一性
    local global_func_name = "floatwindow" .. cmd_name
    _G[global_func_name] = cmd_func

    -- 使用 `vim.api.nvim_command()` 注册命令
    vim.api.nvim_command(string.format("command! %s lua %s()", cmd_name, global_func_name))
  end
end

M.setup = function(opts)
  register_commands()
end

return M
