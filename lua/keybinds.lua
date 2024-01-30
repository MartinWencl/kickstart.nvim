-- TODO: Think about moving keybinds to specific files, i.e. neotree keybinds -> neotree config
-- Global key groups
local wk = require("which-key")
wk.register({
  ["<leader>"] = {
    g = { name = "[g]it", },
    s = { name = "[s]earch" },
    e = { name = "[e]rror/diagnostics/debug" },
    d = { name = "[d]elphi" },
    f = { name = "[f]iles", },
    b = { name = "[b]uffers" },
    p = { name = "[p]review" },
    t = { name = "[t]abs" },
    o = { name = "[o]pen" },
    w = { name = '[w]work' },
  }
})

-- Turn off arrow keys in insert mode
vim.keymap.set("i", "<left>", "")
vim.keymap.set("i", "<right>", "")
vim.keymap.set("i", "<up>", "")
vim.keymap.set("i", "<down>", "")

-- Turn off arrow keys in normal mode
vim.keymap.set("n", "<left>", "")
vim.keymap.set("n", "<right>", "")
vim.keymap.set("n", "<up>", "")
vim.keymap.set("n", "<down>", "")

-- Git keybindings
-- <leader>g for git "submenu"
wk.register({
  ["<leader>g"] = {
    b = {
      name = "Local [b]uffer",
    }
  }
})

vim.keymap.set("n", "<leader>gc", "<Cmd>Telescope git_commits<CR>", { desc = 'Global git [c]ommits' })
vim.keymap.set("n", "<leader>gbc", "<Cmd>Telescope git_bcommits<CR>", { desc = 'Buffer git [c]ommits' })
vim.keymap.set("n", "<leader>gb", "<Cmd>Telescope git_branches<CR>", { desc = 'Global git [b]ranches' })

-- Telescope keybindings
vim.keymap.set("n", "<leader>sg", "<Cmd>Telescope live_grep<CR>", { desc = 'Live [g]rep' })
vim.keymap.set("n", "<leader>sf", "<Cmd>Telescope fd theme=ivy<CR>", { desc = 'Search [f]iles' })
vim.keymap.set("n", "<leader>s/", function()
  require("telescope.builtin").current_buffer_fuzzy_find(require("telescope.themes").get_dropdown {
    winblend = 10,
    previewer = true,
  })
end, { desc = "Search current buffer" })
vim.keymap.set("n", "<leader>sb", "<Cmd>Telescope buffers<CR>", { desc = "View buffers" })

-- Error/Diagnostics/Debuggins
vim.keymap.set("n", "<leader>ed", "<Cmd>Telescope diagnostics<CR>", { desc = 'Current [d]iagnostics' })
vim.keymap.set('n', '<leader>el', vim.diagnostic.setloclist, { desc = 'Open diagnostics list' })

-- File management keybindings
vim.keymap.set("n", "<leader>e", "<Cmd>Neotree toggle<CR>")

-- Terminal
-- Changes the crazy default terminal escape keymap to esc
vim.keymap.set("t", "<esc>", "<C-\\><C-n>", { silent = true })

-- Tab navigation
-- TODO: Fix
vim.keymap.set("n", "<leader>tq", "<Cmd>tabclose<CR>", { silent = true, desc = "close tab" })
vim.keymap.set("n", "<leader>ta", "<Cmd>tabnew<CR>", { silent = true, desc = "new tab - [a]fter current tab" })
vim.keymap.set("n", "<leader>tb", "<Cmd>-tabnew<CR>", { silent = true, desc = "new tab - [b]efore current tab" })

-- hydra for tab navigation
local hydra = require("hydra")
hydra({
  name = "Tab navigation",
  hint = [[ hydra used for tab navigation ]],
  config = {},
  mode = "n",
  body = "<leader>t",
  heads = {
    { "n",     "<Cmd>tabnext<CR>",     { desc = "[n]ext tab" } },
    { "p",     "<Cmd>tabprevious<CR>", { desc = "[p]revious tab" } },

    { "q",     nil,                    { exit = true, nowait = true } },
    { ";",     nil,                    { exit = true, nowait = true } },
    { "<Esc>", nil,                    { exit = true, nowait = true } },
  },
})

-- Sourcing file
vim.keymap.set("n", "<leader><leader>x", "<Cmd>source %<CR>", { desc = "source current file" })

-- Opening floating diagnostic window
vim.keymap.set("n", "<leader>i", ":lua vim.diagnostic.open_float(nil, {focus=false, scope=\"cursor\"})<CR>", { desc = "Open floating diagnostic window", silent = true })
