return {
  "vuki656/package-info.nvim",
  dependencies = { "MunifTanjim/nui.nvim" },
  ft = "json",
  keys = {
    {
      "<leader>cpt",
      function()
        require("package-info").toggle()
      end,
      desc = "toogle package manager",
      silent = true,
      noremap = true,
    },
    {
      "<leader>cpu",
      function()
        require("package-info").update()
      end,
      desc = "Update package",
      silent = true,
      noremap = true,
    },
    {
      "<leader>cpi",
      function()
        require("package-info").install()
      end,
      desc = "Install package",
      silent = true,
      noremap = true,
    },
    {
      "<leader>cpc",
      function()
        require("package-info").change_version()
      end,
      desc = "Change package version",
      silent = true,
      noremap = true,
    },
  },
  opts = {
    --   package_manager = "pnpm",
    --   hide_up_to_date = true,
    autostart = true,
    notifications = true,
  },
}
