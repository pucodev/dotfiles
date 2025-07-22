local function get_clients()
  local clients = {}
  local buf_clients = vim.lsp.get_clients({ bufnr = 0 })

  for _, client in pairs(buf_clients) do
    table.insert(clients, client.name)
  end

  return table.concat(clients, ", ")
end

local function get_lint()
  local buf_ft = vim.bo.filetype
  local linters = {}
  local lint_success, lint = pcall(require, "lint")

  if lint_success then
    for ft, ft_linters in pairs(lint.linters_by_ft) do
      if ft == buf_ft then
        if type(ft_linters) == "table" then
          for _, linter in pairs(ft_linters) do
            table.insert(linters, linter)
          end
        else
          table.insert(linters, ft_linters)
        end
      end
    end
  end
  return table.concat(linters, ", ")
end

local function get_formatter()
  local formatters = {}
  local conform_success, conform = pcall(require, "conform")
  if conform_success then
    for _, formatter in pairs(conform.list_formatters_for_buffer(0)) do
      if formatter then
        table.insert(formatters, formatter)
      end
    end
  end

  return table.concat(formatters, ", ")
end

return {
  "nvim-lualine/lualine.nvim",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  config = function()
    require("lualine").setup({
      options = {
        theme = "catppuccin",
        disabled_filetypes = { "lazy", "NVimTree" },
        globalstatus = true,
      },
      sections = {
        lualine_x = {
          {
            get_clients,
            icon = { "" },
            color = {
              fg = "#91d7e3",
            },
          },
          {
            get_lint,
            icon = { "" },
            color = {
              fg = "#f5a97f",
            },
          },
          {
            get_formatter,
            icon = { "󰉡" },
            color = {
              fg = "#c6a0f6",
            },
          },
          "filetype",
        },
      },
    })
  end,
}
