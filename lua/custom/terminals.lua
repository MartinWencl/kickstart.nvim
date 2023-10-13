-- Terminal setup

-- Bottom terminal
local bottom_terminal = {}

local toggle_bottom_term = function()
  if bottom_terminal.win == nil then
    local height = 8 -- height in rows

    vim.cmd("below split")
    vim.cmd.terminal()
    local win = vim.api.nvim_get_current_win()
    bottom_terminal.win = win
    vim.api.nvim_win_set_height(win, height)
    -- vim.cmd('startinsert')
  else
    vim.api.nvim_win_close(bottom_terminal.win, false)
    bottom_terminal.win = nil
  end
end

-- TODO: Make into command
vim.keymap.set("n", "<leader>tt", toggle_bottom_term)

-- drop-down terminal, like Yakuake.
-- TODO: make toggle
local quake_style_terminal = {}

local toggle_quake_term = function()
  local buf = quake_style_terminal.buf
  if buf == nil then
    buf = vim.api.nvim_create_buf(false, true)
    quake_style_terminal.buf = buf
  end

  local ui = vim.api.nvim_list_uis()[1]
  local width = ui.width
  local height = 15
  local opts = {
    relative = 'editor',
    width = width,
    height = height,
    col = 0,
    row = 0,
    anchor = 'NW',
    style = 'minimal',
    border = 'shadow',
  }

  vim.api.nvim_open_win(buf, true, opts)
  vim.cmd.terminal()
  vim.cmd('startinsert')
end

-- TODO: make into command
vim.keymap.set("n", "<leader>tq", toggle_quake_term)
