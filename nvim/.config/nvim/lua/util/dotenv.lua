local dotenv = {}

-- Reads the contents of a file and returns it as a string
local function read_file(filename)
  local file = io.open(filename, "r")
  if not file then
    return nil, "File not found: " .. filename
  end
  local content = file:read("*a")
  file:close()
  return content
end

-- Parses the contents of a .env file and returns a table of key-value pairs
local function parse_env(content)
  local env_vars = {}
  for line in content:gmatch("[^\r\n]+") do
    line = line:match("^%s*(.-)%s*$") -- Trim whitespace
    if line ~= "" and line:sub(1, 1) ~= "#" then -- Ignore empty and commented lines
      local key, value = line:match("([^=]+)=(.*)")
      if key and value then
        key = key:match("^%s*(.-)%s*$")
        value = value:match("^%s*(.-)%s*$")

        -- Handle double-quoted values
        if value:sub(1, 1) == '"' and value:sub(-1, -1) == '"' then
          value = value:sub(2, -2):gsub('\\"', '"')
        end

        -- Handle single-quoted values
        if value:sub(1, 1) == "'" and value:sub(-1, -1) == "'" then
          value = value:sub(2, -2)
        end

        env_vars[key] = value
      end
    end
  end
  return env_vars
end

--- Loads environment variables from a .env file into _G and optionally os environment
-- @param filename string Path to the .env file (default: ".env")
-- @param set_os_env boolean Whether to also export to the OS environment (default: false)
-- @return boolean|string true on success, or an error message
function dotenv:load(filename, set_os_env)
  filename = filename or ".env"
  local content, err = read_file(filename)
  if not content then
    return nil, err
  end

  local env_vars = parse_env(content)
  for key, value in pairs(env_vars) do
    if not _G[key] then
      _G[key] = value
    end
    if set_os_env and vim.fn.setenv then
      vim.fn.setenv(key, value)
    end
  end

  return true
end

--- Reads a .env file and returns a table of key-value pairs without setting them globally
-- @param filename string Path to the .env file (default: ".env")
-- @return table|nil env table, or nil if file not found
function dotenv:get(filename)
  filename = filename or ".env"
  local content, err = read_file(filename)
  if not content then
    return nil, err
  end
  return parse_env(content)
end

-- Fetch .env
local default_path = vim.fn.stdpath("config") .. "/.env"
local uv = vim.loop
if uv.fs_stat(default_path) then
  dotenv:load(default_path, true)
end

return dotenv
