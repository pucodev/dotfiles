return {
  "stevearc/conform.nvim",
  event = { "BufReadPre", "BufNewFile" },
  config = function()
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
        lua = { "stylua" },
        markdown = { "prettierd_mdx" },
        mdx = { "prettierd" },
        php = { "pretty-php" },
        python = { "isort", "black" },
        sql = { "sql-formatter" },
        svelte = { "prettierd" },
        typescript = { "prettierd" },
        typescriptreact = { "prettierd" },
        vue = { "prettierd" },
        yaml = { "prettierd" },
        -- php = { "php-cs-fixer" }, -- Lento
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
      },
    })

    vim.keymap.set({ "n", "v" }, "<leader>cf", function()
      conform.format({
        lsp_fallback = true,
        async = false,
        timeout_ms = 2000,
      })
    end, { desc = "Format file or range (in visual mode)" })
  end,
}
