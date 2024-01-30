require "lib.windows"

-- Value that will be set as a level 2 header for the quicknote
local quicknote_name = ""

-- Quicknotes
-- Autocmd -> saves the buffer of quicknote and appends it to Notes/home/index.norg
-- TODO: Still adds an empty note
vim.api.nvim_create_autocmd("BufLeave", {
  pattern = "quicknote.norg",
  group = vim.api.nvim_create_augroup("Quicknote", { clear = true }),
  callback = function ()
    local indent = string.rep("", 4)
    local header = "\n** Quicknote from " .. os.date("%d.%m.%Y")

    local quicknote_buf = vim.api.nvim_get_current_buf()
    -- TODO: add support for neorg workspaces, not just home
    local file = io.open(vim.fn.expand("~") .. "/Notes/home/index.norg", "a")
    local lines = vim.api.nvim_buf_get_lines(quicknote_buf, 0, -1, false)

    if quicknote_name ~= "" then
      header = "\n** " .. quicknote_name
    end

    if lines == {} then return end

    if file ~= nil then
      file:write(header)
      for _, line in ipairs(lines) do
        file:write("\n" .. indent .. line)
      end
      file:close()
    end

    vim.api.nvim_buf_delete(quicknote_buf, { force = true })
  end,
})

-- Autocmd -> removes the file if it has been written to.
-- TODO: Is there a better way to do this? Maybe block write before it happens with BufWritePre
vim.api.nvim_create_autocmd("BufWritePost", {
  pattern = "quicknote.norg",
  group = "Quicknote",
  callback = function ()
    vim.cmd("<Cmd>!rm " .. vim.fn.getcwd() .. "/quicknote.norg<CR>")
  end
})

-- Opens a floating non permanent window to write a quick note in
-- TODO: add autocmd to remove the file if written
local open_quick_note = function()
  local buf = vim.api.nvim_create_buf(false, false)
  local name = "quicknote.norg"
  quicknote_name = vim.fn.input({ prompt = "Quicknote header (leave empty to autogenerate): "})
  vim.api.nvim_buf_set_name(buf, name)
  vim.cmd.startinsert()
  vim.api.nvim_buf_call(buf, function ()
    --TODO: URGENT - this doesnt set it only for the buffer, but for the whole neovim it seems
    vim.keymap.set("n", "q", "<Cmd>q!<CR>", { silent = true })
    vim.keymap.set("n", "<esc>", "<Cmd>q!<CR>", { silent = true })
    vim.keymap.set("n", ";", "<Cmd>q!<CR>", { silent = true })
  end)
  WindowLib:open_floating_window(60, 30, buf)
end

vim.keymap.set("n", "<leader>on", open_quick_note, { desc = "open quick [n]ote"})
