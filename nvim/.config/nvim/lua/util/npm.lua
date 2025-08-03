local M = {}

M.NPM_DIR = "util.npm"

--- Ensures a given npm package is installed locally and exposes its path.
--- Installation is performed asynchronously using `vim.system()` (Neovim 0.10+),
--- with --no-save and --no-package-lock to avoid modifying package.json files.
---
--- @param package_name string: The npm package name (e.g. "typescript-language-server")
--- @param opts? table: Optional parameters
---   - cwd: string — directory to install the package (default: stdpath("data")/npm-bin)
---   - on_success: function(path: string) — called with path if installed
---   - on_failure: function(res: table) — called if installation fails
---   - on_missing_npm: function() — called if `npm` is not available
M.ensure_npm_binary = function(package_name, opts)
  opts = opts or {}

  -- Check if npm is available
  if vim.fn.executable("npm") == 0 then
    local msg = "❌ 'npm' is not installed or not in your $PATH."
    vim.notify(msg, vim.log.levels.ERROR)
    if opts.on_missing_npm then
      opts.on_missing_npm()
    end
    return
  end

  -- Set install directory and binary path
  local npm_dir = opts.cwd or M.get_package_path()
  local install_dir = npm_dir .. "/" .. package_name
  local node_dir = install_dir .. "/node_modules"

  -- If already installed, use it
  if vim.loop.fs_stat(node_dir) then
    -- vim.notify("🚀 '" .. install_dir .. "' is already installed.", vim.log.levels.INFO)
    if opts.on_success then
      opts.on_success(install_dir)
    end
    return
  end

  vim.notify("📦 Installing '" .. package_name .. "' via npm...", vim.log.levels.INFO)
  vim.fn.mkdir(install_dir, "p")

  -- Perform installation with no lockfile or package.json editing
  local cmd = {
    "npm",
    "install",
    package_name,
    "--no-save",
    "--no-package-lock",
  }

  vim.system(cmd, { cwd = install_dir }, function(res)
    vim.schedule(function()
      if res.code == 0 then
        vim.notify("✅ Successfully installed '" .. package_name .. "'.", vim.log.levels.INFO)
        if opts.on_success then
          opts.on_success(install_dir)
        end
      else
        vim.notify("❌ Failed to install '" .. package_name .. "':\n" .. (res.stderr or ""), vim.log.levels.ERROR)
        if opts.on_failure then
          opts.on_failure(res)
        end
      end
    end)
  end)
end

M.get_package_path = function()
  return (vim.fn.stdpath("data") .. "/" .. M.NPM_DIR)
end

return M