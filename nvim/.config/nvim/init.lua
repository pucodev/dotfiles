require("config.lazy")
require("config.lsp")

require("config.settings")
require("config.keymaps")

vim.filetype.add({
  extension = {
    mdx = "mdx",
    md = "markdown",
  },
})
