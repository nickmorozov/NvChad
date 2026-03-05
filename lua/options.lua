local opt = vim.opt

-- relative line numbers
opt.relativenumber = true

-- clipboard includes system clipboard
opt.clipboard = "unnamed,unnamedplus"

-- 4-space tabs (override NvChad's 2-space default) for non-web files
-- web files use prettier/conform anyway
opt.shiftwidth = 4
opt.tabstop = 4
opt.softtabstop = 4

-- column marker
opt.colorcolumn = "180"

-- Delete key mapping for xterm terminals
if vim.env.TERM and vim.env.TERM:match "xterm" then
  vim.keymap.set({ "n", "v" }, "<Del>", "x", { noremap = true })
end
