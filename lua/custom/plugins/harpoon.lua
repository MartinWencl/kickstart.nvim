-- https://github.com/ThePrimeagen/harpoon
return {
  'ThePrimeagen/harpoon',
  config = function()
    require("harpoon").setup({
      global_settings = {
        -- sets the marks upon calling `toggle` on the ui, instead of require `:w`.
        save_on_toggle = false,

        -- saves the harpoon file upon every change. disabling is unrecommended.
        save_on_change = true,

        -- sets harpoon to run the command immediately as it's passed to the terminal when calling `sendCommand`.
        enter_on_sendcmd = false,

        -- closes any tmux windows harpoon that harpoon creates when you close Neovim.
        tmux_autoclose_windows = false,

        -- filetypes that you want to prevent from adding to the harpoon list menu.
        excluded_filetypes = { "harpoon" },

        -- set marks specific to each git branch inside git repository
        mark_branch = false,

        -- enable tabline with harpoon marks
        tabline = true,
        tabline_prefix = ">  ",
        tabline_suffix = "   ",
      }
    })
    -- Register harpoon as a Telescope extension 
    require("telescope").load_extension('harpoon')

    -- Quick menu
    -- TODO: decide if I want to use Telescope or the built in quick menu
    -- :Telescope harpoon marks
    local open_menu = function ()
      require("harpoon.ui").toggle_quick_menu()
    end
    vim.keymap.set("n", "<leader>hq", open_menu, { desc = "harpoon [q]uickmenu" })

    local add_to_quickfix = function ()
      require("harpoon.mark").to_quickfix_list()
    end
    vim.keymap.set("n", "<leader>hf", add_to_quickfix, { desc = "add to quick[f]ix" })

    -- Mark file
    -- removes file but leaves mark to empty file - (empty)
    local mark_file = function ()
      local harproon = require("harpoon.mark")
      local current_file_index = harproon.get_current_index()
      if current_file_index ~= nil then
        harproon.rm_file(current_file_index)
      else
        harproon.add_file()
      end
    end
    vim.keymap.set("n", "<leader>hm", mark_file, { desc = "harpoon [m]mark"})

    -- Clear all marks 
    local clear_marks = function ()
      require("harpoon.mark").clear_all()
    end
    vim.keymap.set("n", "<leader>hc", clear_marks, { desc = "harpoon [c]lear marks"} )

  end
}
