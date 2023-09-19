---@type MappingsTable
local M = {}

M.general = {
  n = {
    ["<leader>cp"] = { "<cmd> Copilot <CR>", "Open Copilot", opts = { nowait = true } },
    ["<leader>lg"] = { "<cmd> LazyGit <CR>", opts = { nowait = true } },
  },
}

M.dap = {
  plugin = true,
  n = {
    ["<leader>db"] = { "<cmd> DapToggleBreakpoint <CR>" },
  },
}

M.dap_python = {
  plugin = true,
  n = {
    ["<leader>dpr"] = {
      function()
        require("dap_python").test_method()
      end,
    },
  },
}

-- more keybinds!

return M
