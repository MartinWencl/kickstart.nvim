local toggle_whitespace = function ()
  vim.cmd.set("listchars=eol:¬,tab:>·,trail:~,extends:>,precedes:<,space:␣")
  vim.cmd.set("list!")
 end

-- setting EOL char
vim.opt.list = true
vim.opt.listchars = {
  eol = "󰌑"
}

-- Sets spelling
vim.opt.spelllang = {"en_us", "cs"}
vim.opt.spell = true
