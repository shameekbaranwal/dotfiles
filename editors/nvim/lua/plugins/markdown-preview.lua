-- https://github.com/iamcco/markdown-preview.nvim
-- Live markdown preview in the browser
---@type LazySpec
return {
  "iamcco/markdown-preview.nvim",
  cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
  ft = { "markdown" },
  build = function() vim.fn["mkdp#util#install"]() end,
  init = function() vim.g.mkdp_filetypes = { "markdown" } end,
  keys = {
    { "<Leader>mp", "<cmd>MarkdownPreviewToggle<cr>", desc = "Toggle markdown preview" },
  },
}
