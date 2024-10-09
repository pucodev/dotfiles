return {
  "heavenshell/vim-jsdoc",
  build = "make install",
  config = function()
    vim.keymap.set("n", "<leader>cd", "<cmd>JsDoc<cr>", { desc = "Create JsDoc" })
  end,
}
