require "lib.env"

local wk = require("which-key")
wk.register({
  ["<leader>w"] = {
    w = {
      name = "[w]ork",
    }
  }
})

local path_to_notes = vim.fn.expand("~") .. "/Notes/work"
vim.keymap.set("n", "<leader>wn", "<Cmd>Telescope find_files search_dirs=" .. path_to_notes .. "<CR>", { desc = "select ITA [n]ote", silent = true })

-- DEKSearch
-- Paths to search in
local path_to_repo = "/mnt/c/Vyvoj/Projekty-developer/ripgrep/"
local excluded = {".svn", "Zdroje", "zzzDCU", "zzzHelp"}

--- Function that returns a list of directiories, from a given path, while excluding given directory names
---@param path string given path to repo, using linux conventions
---@param excluded_names table list of names that will be excluded from the resulting list
local get_repo_directories = function (path, excluded_names)
  local dirs_in_repo = vim.fs.dir(path)
  local dirs = {}

  for name, type in dirs_in_repo do
    if type ~= "directory" then goto continue end
    if vim.list_contains(excluded_names, name) then goto continue end

    table.insert(dirs, name)
    ::continue::
  end
  return dirs
end

-- mode for telescope
local mode = ""

-- TODO: find out if there is a way to pass mode as param, instead of "global" var `mode`
-- currently cant change params on this func cause the `vim.select` expects a function with two parameters
on_dir_select = function (item, lnum)
  if item == nil then return end

  if mode == "live_grep" then
    require("telescope.builtin").live_grep({cwd = path_to_repo .. item, file_format = "cp1250"})
  elseif mode == "find_files" then
    require("telescope.builtin").find_files({cwd = path_to_repo .. item, file_format = "cp1250"})
  else
    vim.notify("Telescope mode not recognized or implemented!", vim.log.levels.ERROR)
  end
end

--- Checks the ripgrep repo for directories, asks to select one and calls `on_dir_select`
---  - expects the var `mode` to be set
local select_dir_to_search = function ()
  if not EnvLib:CheckLocation("work") then
    vim.notify("Not at work!", vim.log.levels.ERROR)
  end

  if not mode then
    vim.notify("Telescope mode is not set!", vim.log.levels.ERROR)
    return
  end

  local dirs = get_repo_directories(path_to_repo, excluded)

  vim.ui.select(dirs, { prompt = "Select a folder: "}, on_dir_select)
end

local use_live_grep = function ()
  mode = "live_grep"
  select_dir_to_search()
end
vim.keymap.set("n", "<leader>wg", use_live_grep, { desc = "DEK - live [g]rep"})

local use_find_files = function ()
  mode = "find_files"
  select_dir_to_search()
end
vim.keymap.set("n", "<leader>wf", use_find_files, { desc = "DEK - find [f]iles" })
