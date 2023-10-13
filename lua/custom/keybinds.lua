-- TODO: Think about moving keybinds to specific files, i.e. neotree keybinds -> neotree config
-- Global key groups
local wk = require("which-key")
wk.register({
  ["<leader>"] = {
    g = {
      name = "[g]it",
    },
    ["<leader>"] = {
      name = "Telescope search"
    },
    e = {
      name = "[e]rror/diagnostics/debug"
    },
    d = {
      name = "[d]elphi"
    },
    f = {
      name = "[f]iles",
    },
    b = {
      name = "[b]uffers"
    },
    p = {
      name = "[p]review"
    }
  }
})

-- Git keybindings
-- <leader>g for git "submenu"
wk.register({
  ["<leader>g"] = {
    b = {
      name = "Local [b]uffer",
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
    previewer = true,
  })
end, { desc = 'Search current buffer' })

-- Error/Diagnostics/Debuggins
vim.keymap.set('n', '<leader>ed', "<Cmd>Telescope diagnostics<CR>", { desc = 'Current diagnostics' })

-- File management keybindings
vim.keymap.set('n', '<leader>ff', "<Cmd>Neotree float<CR>", { desc = 'Floating file explorer' })
vim.keymap.set('n', '<leader>fe', "<Cmd>Neotree toggle<CR>", { desc = 'Floating file explorer' })
vim.keymap.set('n', '<leader>e', "<Cmd>Neotree toggle<CR>")

-- buffers
-- TODO: Switch to Telescope, add more buffer functionality
vim.keymap.set('n', '<leader>bb', "<Cmd>Neotree source=buffers position=float toggle<CR>", { desc = "View buffers" })

-- Terminal
vim.keymap.set('t', '<esc>', "<C-\\><C-n>", { silent = true })

-- TODO: Create a function to clone all open windows other than the main, i.e. neotree, terminals
