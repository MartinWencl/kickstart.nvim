--sets the cp1250 encoding for .pas, .dfm, .proj, .dproj filetype_set
-- TODO: Fix
vim.api.nvim_create_autocmd("BufReadPost", {
  -- pattern = {".pas", ".dfm", ".proj", ".dproj"},
  pattern = "*.pas",
  group = vim.api.nvim_create_augroup("DEKEncoding", { clear = true }),
  callback = function ()
    local bufnr = vim.api.nvim_get_current_buf()
    vim.api.nvim_buf_call(bufnr, function ()
      vim.cmd("set fileencoding=cp1250")
    end)
  end
})
