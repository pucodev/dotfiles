-- -------------------------------
-- Install Formatters and linters
-- -------------------------------
local mason_tool_installer = require("mason-tool-installer")
mason_tool_installer.setup({
  ensure_installed = {
    "black", -- python formatter
    "eslint_d", -- js linter
    "isort", -- python formatter
    "php-cs-fixer", -- php formatter
    "prettierd", -- prettier formatter
    "pretty-php", -- php formatter
    "pylint", -- python linter
    "sql-formatter", -- sql
    "stylua", -- lua formatter
  },
})

-- ---------
-- Config
-- ---------
local conform = require("conform")
conform.setup({
  formatters_by_ft = {
    css = { "prettierd" },
    scss = { "prettierd" },
    sass = { "prettierd" },
    graphql = { "prettierd" },
    html = { "prettierd" },
    javascript = { "prettierd" },
    javascriptreact = { "prettierd" },
    json = { "prettierd" },
    jsonc = { "prettierd" },
    lua = { "stylua" },
    php = { "pretty-php" },
    python = { "isort", "black" },
    sql = { "sql-formatter" },
    svelte = { "prettierd" },
    typescript = { "prettierd" },
    typescriptreact = { "prettierd" },
    vue = { "prettierd" },
    yaml = { "prettierd" },
    markdown = { "prettierd" },
    mdx = { "prettierd" },
  },
  format_on_save = {
    lsp_fallback = true,
    async = false,
    timeout_ms = 500,
  },
  notify_on_error = true,
  formatters = {
    ["prettierd_mdx"] = {
      command = "prettierd",
      args = function(_, ctx)
        return { "--plugin-search-dir=.", "--parser=mdx", ctx.filename }
      end,
      stdin = true,
    },
    ["sql-formatter"] = {
      command = "sql-formatter",
    },
    ["php-cs-fixer"] = {
      command = "php-cs-fixer",
      args = {
        "fix",
        "--rules=@PhpCsFixer", -- Formatting preset. Other presets are available, see the php-cs-fixer docs.
        "$FILENAME",
      },
      stdin = false,
    },

    ["html_fragment"] = {
      command = "prettierd",
      args = function(_, ctx)
        return {
          "--plugin-search-dir=.",
          "--parser=html",
          ctx.filename,
        }
      end,
      stdin = true,
      cwd = require("conform.util").root_file({ ".prettierrc", ".prettierrc.json", "package.json" }),
    },
  },
})

vim.keymap.set({ "n", "v" }, "<leader>cf", function()
  conform.format({
    lsp_fallback = true,
    async = false,
    timeout_ms = 2000,
  })
end, { desc = "Format file or range (in visual mode)" })

-- ------------------------
-- CREATE FORMAT COMMANDS
-- ------------------------

-- Function that formats HTML code selected
vim.api.nvim_create_user_command("FormatAsHTML", function()
  conform.format({
    formatters = { "html_fragment" },
    range = {
      ["start"] = vim.api.nvim_buf_get_mark(0, "<"),
      ["end"] = vim.api.nvim_buf_get_mark(0, ">"),
    },
  })
end, { range = true })