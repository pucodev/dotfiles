return {
  "shellRaining/hlchunk.nvim",
  -- enabled = false,
  event = { "BufReadPre", "BufNewFile" },
  config = function()
    require("hlchunk").setup({
      chunk = {
        enable = true,
        duration = 150,
        delay = 10,
      },
      line_num = {
        enable = true,
      },
      indent = {
        enable = true,
      },
    })
  end,
}
