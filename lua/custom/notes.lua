require "lib.windows"
-- Quicknotes
local quicknote = {}

local open_quick_note = function()
  local buf = quicknote.buf
  if buf == nil then
    buf = vim.api.nvim_create_buf(false, false)
    quicknote.buf = buf
  end

  local path = "/home/martinw/Notes/quicknote.norg"
  vim.api.nvim_buf_set_name(buf, path)
  vim.api.nvim_buf_call(buf, vim.cmd.edit)
  WindowLib:open_floating_window(60, 30, buf)
end

vim.keymap.set("n", "<leader>tn", open_quick_note)

-- TODO: Ability to select note to quickly edit
-- i.e. use Neo-tree to select a file from notes dir and open in big floating window
local open_note = function()
  local buf = vim.api.nvim_create_buf(false, false)
  require("neo-tree").open()
end

vim.keymap.set("n", "<leader>to", open_note)
