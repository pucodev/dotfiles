local function dir_exists(path)
  return vim.loop.fs_stat(path) ~= nil
end

local pucoui_dir = "/home/jorge/develop/pucoui/apps/snippets/nvim"

if not dir_exists(pucoui_dir) then
  vim.notify("NO EXISTE FOLDER")
  return {}
end

return {
  {
    dir = pucoui_dir,
    name = "pucoui",
    dependencies = {
      "hrsh7th/nvim-cmp",
      "nvim-treesitter/nvim-treesitter",
    },
    config = function()
      require("pucoui").setup()
    end,
  },
}
