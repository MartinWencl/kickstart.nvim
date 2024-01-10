local toggle_whitespace = function ()
  vim.cmd.set("listchars=eol:¬,tab:>·,trail:~,extends:>,precedes:<,space:␣")
  vim.cmd.set("list!")
 end

-- Sourcing file
vim.keymap.set("n", "<leader><leader>x", "<Cmd>source %<CR>", { desc = "source current file"})

-- Opening floating diagnostic window
vim.keymap.set("n", "<C-d>", ":lua vim.diagnostic.open_float(nil, {focus=false, scope=\"cursor\"})<CR>", { desc = "Open floating diagnostic window", silent = true })
