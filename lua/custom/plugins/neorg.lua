-- https://github.com/nvim-neorg/neorg
return {
  "nvim-neorg/neorg",
  build = ":Neorg sync-parsers",
  dependencies = { { "nvim-lua/plenary.nvim" }, { "nvim-neorg/neorg-telescope" } },
  config = function()
    require("neorg").setup {
      load = {
        ["core.defaults"] = {},  -- Loads default behaviour
        ["core.concealer"] = {}, -- Adds pretty icons to your documents
        -- TODO: Completion
        -- ["core.completion"] = { -- Adds completion
          -- engine = "nvim-cmp",
          -- name = "neorg"
        -- },
        ["core.dirman"] = {      -- Manages Neorg workspaces
          config = {
            workspaces = {
              work = "~/Notes/work",
              home = "~/Notes/home"
            },
          },
        },
        ["core.integrations.treesitter"] = {},
        ["core.export"] = {},
        ["core.integrations.telescope"] = {},
        ["core.summary"] = {},
        ["core.esupports.hop"] = {},
        ["core.mode"] = {},
      },
    }

    -- Keybinds groups setup
    local wk = require("which-key")
    wk.register({
      ["<leader>"] = {
        n = {
          name = "[n]eorg",
        },
      },
      ["<leader>n"] = {
        w = {
          name = "[w]orkspace"
        },
      },
    })

    -- Workspaces
    vim.keymap.set("n", "<leader>nww", "<Cmd>Neorg workspace work<CR>", { desc = "[w]ork" })
    vim.keymap.set("n", "<leader>nwh", "<Cmd>Neorg workspace home<CR>", { desc = "[h]ome" })

    -- iterate trough workspaces
    local switch_modes = function ()
      local mode_module =  require("neorg").modules.get_module("core.mode")
      local all_modes = mode_module.get_modes()
      local current_mode = mode_module.get_mode()

      -- Setting next mode
      local current_index = 0
      for i, module in ipairs(all_modes) do
        if module == current_mode then
          current_index = i
        end

        if i == current_index + 1 then
          mode_module.set_mode(module)
          vim.notify("Neorg mode set to " .. module, vim.log.levels.INFO)
        end
      end
    end
    vim.keymap.set("n", "<leader>ns", switch_modes, { desc = "[s]witch mode" })

    vim.wo.foldlevel = 99
    vim.wo.conceallevel = 2
  end,
}
