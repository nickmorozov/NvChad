return {
  -- conform (formatting)
  {
    "stevearc/conform.nvim",
    event = "BufWritePre",
    opts = {
      formatters_by_ft = {
        lua = { "stylua" },
        javascript = { "prettier" },
        typescript = { "prettier" },
        css = { "prettier" },
        html = { "prettier" },
        json = { "prettier" },
        yaml = { "prettier" },
        sh = { "shfmt" },
      },
    },
  },

  -- LSP
  {
    "neovim/nvim-lspconfig",
    config = function()
      require "configs.lspconfig"
    end,
  },

  -- mason (LSP/formatter installer)
  {
    "mason-org/mason.nvim",
    opts = {
      ensure_installed = {
        -- lua
        "lua-language-server",
        "stylua",
        -- web
        "css-lsp",
        "html-lsp",
        "typescript-language-server",
        "prettier",
        -- shell
        "shfmt",
      },
    },
  },

  -- treesitter (syntax highlighting)
  {
    "nvim-treesitter/nvim-treesitter",
    opts = {
      ensure_installed = {
        "vim",
        "vimdoc",
        "lua",
        "html",
        "css",
        "javascript",
        "typescript",
        "tsx",
        "json",
        "markdown",
        "markdown_inline",
        "bash",
      },
    },
  },

  -- nvim-tree (git integration)
  {
    "nvim-tree/nvim-tree.lua",
    opts = {
      git = { enable = true },
      renderer = {
        highlight_git = true,
        icons = { show = { git = true } },
      },
    },
  },

  -- better escape (jk to exit insert mode)
  {
    "max397574/better-escape.nvim",
    event = "InsertEnter",
    opts = {},
  },
}
