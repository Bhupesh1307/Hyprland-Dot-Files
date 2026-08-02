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
          "lua_ls",
          "pyright",
          "clangd",
          "jdtls",
          "ts_ls",
          "html",
          "cssls",
          "jsonls",
          "bashls",
        },
      })

      vim.diagnostic.config({
	  virtual_text = true,
	  underline = true,
      })

      vim.lsp.enable({
        "lua_ls",
        "pyright",
        "clangd",
        "jdtls",
        "ts_ls",
        "html",
        "cssls",
        "jsonls",
        "bashls",
      })
    end,
  },
}
