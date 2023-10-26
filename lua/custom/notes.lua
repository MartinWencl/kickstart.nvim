require "lib.windows"

-- Quicknotes
-- Autocmd -> saves the buffer of quicknote and appends it to Notes/home/index.norg
vim.api.nvim_create_autocmd("BufLeave", {
  pattern = "quicknote.norg",
  group = vim.api.nvim_create_augroup("Quicknote", { clear = true }),
  callback = function ()
    local quicknote_buf = vim.api.nvim_get_current_buf()
    local file = io.open(vim.fn.expand("~") .. "/Notes/home/index.norg", "a")
    local lines = vim.api.nvim_buf_get_lines(quicknote_buf, 0, -1, false)
    local header = "\n** Quicknote from " .. os.date("%d.%m.%Y")

    if lines ~= {} then return end

    if file ~= nil then
      file:write(header)
      for _, line in ipairs(lines) do
        file:write("\n" .. line)
      end
      file:close()
    end

    vim.api.nvim_buf_delete(quicknote_buf, { force = true })
  end,
})

local open_quick_note = function()
  local buf = vim.api.nvim_create_buf(false, false)
  local name = "quicknote.norg"
  vim.api.nvim_buf_set_name(buf, name)
  vim.api.nvim_buf_call(buf, vim.cmd.edit)
  vim.api.nvim_buf_call(buf, function ()
    vim.keymap.set("n", "q", "<Cmd>q!<CR>", { silent = true })
    vim.keymap.set("n", "<esc>", "<Cmd>q!<CR>", { silent = true })
    vim.keymap.set("n", ";", "<Cmd>q!<CR>", { silent = true })
  end)
  WindowLib:open_floating_window(60, 30, buf)
end

vim.keymap.set("n", "<leader>on", open_quick_note, { desc = "open quick [n]ote"})

-- TODO: Ability to select note to quickly edit
-- i.e. use Neo-tree to select a file from notes dir and open in big floating window
local open_note = function()
  local buf = vim.api.nvim_create_buf(false, false)
  require("neo-tree").open()
end
