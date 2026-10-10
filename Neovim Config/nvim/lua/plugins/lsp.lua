return {
  {
    "williamboman/mason.nvim",

    dependencies = {
      "williamboman/mason-lspconfig.nvim",
      "neovim/nvim-lspconfig",
    },

    config = function()
      require("mason").setup()

      require("mason-lspconfig").setup({
        ensure_installed = {
          "lua_ls",	-- Lua
          "pyright",	-- Python
          "clangd",	-- C / C++
          "jdtls",	-- Java
          "ts_ls",	-- JavaScript / TypeScript
          "html",	-- HTML
          "cssls",	-- CSS
          "jsonls",	-- JSON
          "bashls",	-- Bash
        },
      })

      vim.diagnostic.config({
	  virtual_text = true,
	  underline = true,
      })

      -- Tell Lua LSP that `vim` is a valid global
      vim.lsp.config("lua_ls", {
        settings = {
          Lua = {
            diagnostics = {
              globals = { "vim" },
            },

            workspace = {
              library = vim.api.nvim_get_runtime_file("", true),
              checkThirdParty = false,
            },
          },
        },
      })

      -- QML LSP
      vim.lsp.config("qmlls", {
        cmd = { "qmlls6" },
        filetype = { "qml" },
      })

      -- Enable LSPs
      vim.lsp.enable({
        "lua_ls",
        "pyright",
        "clangd",
        "jdtls",
        "ts_ls",
	"qmlls",
        "html",
        "cssls",
        "jsonls",
        "bashls",
      })
    end,
  },
}
