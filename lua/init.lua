local toggle_whitespace = function ()
  vim.cmd.set("listchars=eol:¬,tab:>·,trail:~,extends:>,precedes:<,space:␣")
  vim.cmd.set("list!")
 end
vim.keymap.set("n", "<leader>tw", toggle_whitespace, { desc = "[t]oggle [w]hitespace" })

-- setting EOL char
vim.opt.list = true
vim.opt.listchars = {
  eol = "󰌑"
}

-- Sets spelling
vim.opt.spelllang = {"en_us", "cs"}
vim.opt.spell = true
