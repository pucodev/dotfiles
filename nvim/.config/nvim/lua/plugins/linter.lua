return {
  "mfussenegger/nvim-lint",
  event = {
    "BufReadPre",
    "BufNewFile",
  },
  config = function()
    local lint = require("lint")

    lint.linters_by_ft = {
      javascript = { "eslint_d" },
      typescript = { "eslint_d" },
      javascriptreact = { "eslint_d" },
      typescriptreact = { "eslint_d" },
      vue = { "eslint_d" },
      svelte = { "eslint_d" },
      python = { "pylint" },
      php = { "php" },
    }

    -- Config eslint
    local eslint = lint.linters.eslint_d
    eslint.args = {
      "--stdin",
      "--stdin-filename",
      function()
        return vim.api.nvim_buf_get_name(0)
      end,
      "--format",
      "json",
    }

    -- try to ignore "No ESLint configuration found" error
    -- if diagnostic.message:find("Error: No ESLint configuration found") then -- old version
    local util = require("lint.util")
    lint.linters.eslint_d = util.wrap(eslint, function(diag)
      if diag.message:find("Could not find config file") then
        return nil
      end
      return diag
    end)

    local lint_augroup = vim.api.nvim_create_augroup("lint", { clear = true })

    vim.api.nvim_create_autocmd({ "BufEnter", "BufWritePost", "InsertLeave" }, {
      group = lint_augroup,
      callback = function()
        lint.try_lint()
      end,
    })

    vim.keymap.set("n", "<leader>cl", function()
      lint.try_lint()
    end, { desc = "Trigger linting for current file" })
  end,
}
