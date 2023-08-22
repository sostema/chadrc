---@type MappingsTable
local M = {}

M.general = {
  n = {
    ["<leader>cp"] = { "<cmd> Copilot <CR>", "Open Copilot", opts = { nowait = true } },
    ["<leader>lg"] = { "<cmd> LazyGit <CR>", opts = { nowait = true } },
  },
}

-- more keybinds!

return M
