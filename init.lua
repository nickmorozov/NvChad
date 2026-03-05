vim.g.base46_cache = vim.fn.stdpath "data" .. "/nvchad/base46/"
vim.g.mapleader = " "

-- bootstrap lazy.nvim
local lazypath = vim.fn.stdpath "data" .. "/lazy/lazy.nvim"

if not vim.uv.fs_stat(lazypath) then
  local repo = "https://github.com/folke/lazy.nvim.git"
  vim.fn.system { "git", "clone", "--filter=blob:none", repo, "--branch=stable", lazypath }
end

vim.opt.rtp:prepend(lazypath)

-- load options before plugins
pcall(require, "nvchad.options")
require "options"

-- load lazy.nvim with NvChad + custom plugins
require("lazy").setup({
  { import = "nvchad.plugins" },
  { import = "plugins" },
}, {
  defaults = { lazy = true },
  install = { colorscheme = { "nvchad" } },

  ui = {
    icons = {
      ft = "",
      lazy = "󰂠 ",
      loaded = "",
      not_loaded = "",
    },
  },

  performance = {
    rtp = {
      disabled_plugins = {
        "2html_plugin",
        "tohtml",
        "getscript",
        "getscriptPlugin",
        "gzip",
        "logipat",
        "netrw",
        "netrwPlugin",
        "netrwSettings",
        "netrwFileHandlers",
        "matchit",
        "tar",
        "tarPlugin",
        "rrhelper",
        "spellfile_plugin",
        "vimball",
        "vimballPlugin",
        "zip",
        "zipPlugin",
        "tutor",
        "rplugin",
        "syntax",
        "synmenu",
        "optwin",
        "compiler",
        "bugreport",
        "ftplugin",
      },
    },
  },
})

-- load theme (cache is built by base46 plugin; skip on first launch)
local base46_ok, _ = pcall(dofile, vim.g.base46_cache .. "defaults")
if base46_ok then
  dofile(vim.g.base46_cache .. "statusline")
end

-- load NvChad mappings + custom mappings
pcall(require, "nvchad.mappings")
require "mappings"

-- source shared vimrc (for IdeaVim compatibility)
vim.cmd("source " .. vim.fn.stdpath "config" .. "/vimrc")
