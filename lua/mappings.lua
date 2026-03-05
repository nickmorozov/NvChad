local map = vim.keymap.set

-- ; enters command mode (no shift needed)
map("n", ";", ":", { nowait = true, desc = "enter command mode" })

-- stay in visual mode after indent
map("v", ">", ">gv", { desc = "indent and reselect" })
map("v", "<", "<gv", { desc = "dedent and reselect" })
