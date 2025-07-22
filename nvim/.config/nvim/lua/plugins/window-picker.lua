return {
  "s1n7ax/nvim-window-picker",
  name = "window-picker",
  event = "VeryLazy",
  version = "2.*",
  keys = {
    {
      "<leader>wp",
      function()
        local picked_window_id = require("window-picker").pick_window()
        if picked_window_id then
          vim.api.nvim_set_current_win(picked_window_id)
        end
      end,
      desc = "Pick Window",
    },
  },
  config = function()
    require("window-picker").setup({
      hint = "floating-big-letter",
      filter_rules = {
        include_current_win = true,
      },
    })
  end,
}
