-- Dashboard
return {
  "goolord/alpha-nvim",
  dependencies = {
    "echasnovski/mini.icons",
    "nvim-lua/plenary.nvim",
  },
  config = function()
    require("alpha").setup(require("alpha.themes.theta").config)
  end,
  init = function()
    vim.api.nvim_create_autocmd("BufEnter", {
      desc = "Start dashboard",
      once = true,
      callback = function()
        require("alpha").start()
      end,
    })
  end,
}
