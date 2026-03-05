-- Load NvChad's LSP defaults (keymaps, diagnostics, capabilities)
require("nvchad.configs.lspconfig").defaults()

-- Servers to enable with default settings
local servers = { "html", "cssls", "ts_ls" }

for _, lsp in ipairs(servers) do
  vim.lsp.enable(lsp)
end
