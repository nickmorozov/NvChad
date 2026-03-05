---@type ChadrcConfig
local M = {}

M.base46 = {
  theme = "bearded-arc",
  theme_toggle = { "bearded-arc", "one_light" },

  hl_override = {
    Comment = { italic = true },
  },

  hl_add = {
    NvimTreeOpenedFolderName = { fg = "green", bold = true },
  },
}

M.nvdash = { load_on_startup = false }

M.ui = {
  statusline = { theme = "default" },
  tabufline = { enabled = true },
}

return M
