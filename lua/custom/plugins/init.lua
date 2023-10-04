-- Global key groups
local wk = require("which-key")
wk.register({
  ["<leader>"] = {
    g = {
      name = "Git",
    },
    ["<leader>"] = {
      name = "Telescope search"
    },
    e = {
      name = "Error/Diagnostics/Debug"
    },
    d = {
      name = "Delphi"
    }
  }
})

-- Git keybindings
-- <leader>g for git "submenu"
wk.register({
  ["<leader>g"] = {
    b = {
      name = "Local buffer",
    }
  }
})

vim.keymap.set('n', '<leader>gc', "<Cmd>Telescope git_commits<CR>", { desc = 'Global git commits' })
vim.keymap.set('n', '<leader>gbc', "<Cmd>Telescope git_bcommits<CR>", { desc = 'Buffer git commits' })
vim.keymap.set('n', '<leader>gb', "<Cmd>Telescope git_branches<CR>", { desc = 'Global git branches' })

-- Telescope keybindings
vim.keymap.set('n', '<leader><leader>g', "<Cmd>Telescope live_grep<CR>", { desc = 'Live grep' })
vim.keymap.set('n', '<leader><leader>f', "<Cmd>Telescope fd<CR>", { desc = 'Search files' })
vim.keymap.set('n', '<leader><leader>/', function()
  require('telescope.builtin').current_buffer_fuzzy_find(require('telescope.themes').get_dropdown {
    winblend = 10,
    previewer = false,
  })
end, { desc = 'Search current buffer' })

-- Error/Diagnostics/Debuggins
vim.keymap.set('n', '<leader>ed', "<Cmd>Telescope diagnostics<CR>", { desc = 'Current diagnostics' })
