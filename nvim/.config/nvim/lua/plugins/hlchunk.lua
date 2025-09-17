-- Similar to indent-blankline, this plugin can highlight the indent line,
-- and highlight the code chunk according to the current cursor position.
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
