return {
  "folke/which-key.nvim",
  event = "VeryLazy",
  opts = {
    -- your configuration comes here
    -- or leave it empty to use the default settings
    -- refer to the configuration section below
    preset = "modern",
    spec = {
      {
        mode = { "n", "v" },
        { "<leader>c", group = "code" },
        { "<leader>cs", group = "snippets" },
        { "<leader>f", group = "file/find" },
        { "<leader>g", group = "git" },
        { "<leader><space>", group = "custom keys", icon = { icon = "" } },
        -- { "<leader>gh", group = "hunks" },
        { "<leader>q", group = "quit/session" },
        { "<leader>s", group = "search" },
        { "<leader>ss", group = "extra search" },
        { "<leader>ca", group = "add annotation" },
        { "<leader>cp", group = "package", icon = { icon = "" } },
        { "<leader>u", group = "ui", icon = { icon = "󰙵 ", color = "cyan" } },
        { "<leader>x", group = "diagnostics/quickfix", icon = { icon = "󱖫 ", color = "green" } },
        { "<leader>d", group = "diagnostics", icon = { icon = "", color = "yellow" } },
        {
          "<leader>b",
          group = "buffer",
        },
        {
          "<leader>t",
          group = "Toggle",
          icon = { icon = "󰨚", color = "cyan" },
        },
        {
          "<leader>w",
          group = "Windows",
        },
      },
    },
  },
  keys = {
    {
      "<leader>?",
      function()
        require("which-key").show({ global = false })
      end,
      desc = "Buffer Local Keymaps (which-key)",
    },
  },
  config = function(_, opts)
    local wk = require("which-key")
    wk.setup(opts)
  end,
}
