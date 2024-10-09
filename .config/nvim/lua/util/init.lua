local M = {}

M.toggle = {}

function M.toggle.wrap()
  if vim.wo.wrap then
    vim.wo.wrap = false
    vim.notify("Wrap disabled", "warn")
  else
    vim.wo.wrap = true
    vim.notify("Wrap enabled", "info")
  end
end

return M
