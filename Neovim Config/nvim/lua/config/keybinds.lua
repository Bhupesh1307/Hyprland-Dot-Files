vim.g.mapleader = " "

local opts = { noremap = true, silent = true }

-- File explorer
vim.keymap.set("n", "<leader>cd", vim.cmd.Ex, opts)

-- LSP
vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
vim.keymap.set("n", "<leader><space>", vim.lsp.buf.hover, opts)
vim.keymap.set("n", "gi", vim.lsp.buf.implementation, opts)
vim.keymap.set("n", "<leader>d", vim.lsp.buf.type_definition, opts)
vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)
vim.keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, opts)
vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)

-- NvimTree
vim.keymap.set("n", "<C-e>", "<cmd>NvimTreeToggle<CR>", {
  desc = "Toggle file tree",
})

local function toggle_tree_focus()
  local api = require("nvim-tree.api")

  if vim.bo.filetype == "NvimTree" then
    vim.cmd("wincmd p")
  else
    api.tree.focus()
  end
end

vim.keymap.set("n", "<leader>e", toggle_tree_focus, {
  desc = "Toggle file tree focus",
})

-- Terminal
vim.keymap.set({ "n", "v", "i", "t" }, "<C-`>", function()
  if vim.bo.filetype == "NvimTree" then
    vim.cmd("wincmd p")
  end

  local editor_win = vim.api.nvim_get_current_win()

  vim.api.nvim_win_call(editor_win, function()
    vim.cmd("belowright split")
    vim.cmd("resize 10")
    vim.cmd("terminal")
  end)

  vim.cmd("startinsert")
end, { desc = "Open terminal" })

-- Insert blank line below without splitting the current line
vim.keymap.set("i", "<C-CR>", "<C-o>o", {
  desc = "Insert blank line below",
})
