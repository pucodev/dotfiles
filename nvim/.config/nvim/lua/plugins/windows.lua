return {
  "anuvyklack/windows.nvim",
  -- lazy = false,
  dependencies = {
    "anuvyklack/middleclass",
    "anuvyklack/animation.nvim",
  },
  config = function()
    vim.o.winwidth = 10
    vim.o.winminwidth = 10
    vim.o.equalalways = false
    require("windows").setup({
      ignore = {			
          filetype = { "snacks_layout_box" }
      },
      animation = {
          enable = true,
          duration = 150,
          fps = 30,
          easing = "in_out_sine"
      }
    })
  end,
}
