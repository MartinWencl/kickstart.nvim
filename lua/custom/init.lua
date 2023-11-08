local toggle_whitespace = function ()
  vim.cmd.set("listchars=eol:¬,tab:>·,trail:~,extends:>,precedes:<,space:␣")
  vim.cmd.set("list!")
 end

-- Sourcing file
vim.keymap.set("n", "<leader><leader>x", "<Cmd>source %<CR>", { desc = "source current file"})
