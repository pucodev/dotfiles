-- Lightweight yet powerful formatter plugin for Neovim
return {
  "stevearc/conform.nvim",
  event = { "BufReadPre", "BufNewFile" },
}