-- Automagical editing and creation of snippets.
return {
  "chrisgrieser/nvim-scissors",
  dependencies = { "nvim-telescope/telescope.nvim", "garymjr/nvim-snippets" },
  keys = {
    {
      "<leader>se",
      function()
        require("scissors").editSnippet()
      end,
      desc = "Edit snippet",
    },
    {
      "<leader>sa",
      function()
        require("scissors").addNewSnippet()
      end,
      desc = "Add snippet",
    },
  },
  config = function()
    require("scissors").setup({
      snippetDir = vim.fn.getcwd() .. "/.vscode",
      jsonFormatter = "jq",
    })
  end,
}
