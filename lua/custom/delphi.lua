local delphi_start = function ()
  local config_file = vim.fs.find({"Prodejna.delphilsp.json"}, { upward = true })[1]
  vim.schedule(function ()
    vim.notify(config_file, vim.log.levels.WARN)
  end)
  vim.lsp.start({
    name = "DelphiLSP",
    cmd = {"/mnt/c/Program Files (x86)/Embarcadero/Studio/22.0/bin/DelphiLSP.exe"},
    root_dir = vim.fs.dirname(config_file),
  })
end
vim.api.nvim_create_user_command("DelphiStart", delphi_start, {})

local delphi_get_completion = function ()
  local bufrn = vim.api.nvim_get_current_buf()
  vim.lsp.buf.completion({})
  vim.notify("Called completion", vim.log.levels.WARN)
end
vim.keymap.set("i", "<C-w>", delphi_get_completion)

local delphi_test = function ()
  local bufrn = vim.api.nvim_get_current_buf()
  vim.lsp.buf.implementation()
  vim.notify("Called test", vim.log.levels.WARN)
end
vim.keymap.set("i", "<C-e>", delphi_test)
