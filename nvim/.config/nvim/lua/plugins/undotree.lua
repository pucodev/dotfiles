return {
  "mbbill/undotree",

  keys = {
    {
      "<leader>cu",
      function()
        vim.cmd("UndotreeShow")
        vim.cmd("UndotreeFocus")
      end,
      desc = "Show Undotree",
    },
  },
}
