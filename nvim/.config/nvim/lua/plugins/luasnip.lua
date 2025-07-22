return {
  "L3MON4D3/LuaSnip",
  -- follow latest release.
  version = "v2.*", -- Replace <CurrentMajor> by the latest released major (first number of latest release)
  dependencies = { "rafamadriz/friendly-snippets" },
  config = function()
    local filepath = vim.api.nvim_buf_get_name(0)
    require("luasnip.loaders.from_vscode").lazy_load()
    require("luasnip.loaders.from_vscode").load({ paths = { filepath .. "/.vscode" } })
  end,
}
