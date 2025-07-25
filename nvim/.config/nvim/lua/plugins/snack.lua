return {
  "folke/snacks.nvim",
  priority = 1000,
  lazy = false,
  opts = {
    bigfile = { enabled = true },
    dashboard = { enabled = true },
    explorer = { enabled = true },
    indent = { enabled = true },
    input = { enabled = true },
    -- picker = { enabled = true },
    notifier = { enabled = true },
    quickfile = { enabled = true },
    scope = { enabled = true },
    scroll = { enabled = true },
    statuscolumn = { enabled = true },
    words = { enabled = true },

    picker = {
      enabled = true,
      sources = {
        explorer = {
          hidden = true,
          -- auto_close = true,
          jump = { close = true },
        }
      }
    },
  },
  
  keys = {
    -- EXPLORER
    {
      "<leader>fe",
      function()
        Snacks.explorer({ cwd = vim.uv.cwd() })
      end,
      desc = "Explorer Snacks (root dir)",
    },
    {
      "<leader>fE",
      function()
        Snacks.explorer()
      end,
      desc = "Explorer Snacks (cwd)",
    },
    { "<leader>e",  "<leader>fe",                                                           desc = "Explorer Snacks (root dir)", remap = true },
    { "<leader>E",  "<leader>fE",                                                           desc = "Explorer Snacks (cwd)",      remap = true },
    -- FIND
    -- find
    { "<leader>fb", function() Snacks.picker.buffers() end, desc = "Buffers" },
    { "<leader>fB", function() Snacks.picker.buffers({ hidden = true, nofile = true }) end, desc = "Buffers (all)" },
    { "<leader>fc", function() Snacks.picker.files({ cwd = vim.fn.stdpath("config") }) end, desc = "Find Config File" },
    { "<leader>ff", function() Snacks.picker.files() end, desc = "Find Files" },
    { "<leader>fg", function() Snacks.picker.git_files() end, desc = "Find Git Files" },
    { "<leader>fp", function() Snacks.picker.projects() end, desc = "Projects" },
    { "<leader>fr", function() Snacks.picker.recent() end, desc = "Recent" },
    -- GREP
    { "<leader>sb", function() Snacks.picker.lines() end, desc = "Buffer Lines" },
    { "<leader>sB", function() Snacks.picker.grep_buffers() end, desc = "Grep Open Buffers" },
    { "<leader>sg", function() Snacks.picker.grep() end, desc = "Grep" },
    { "<leader>sw", function() Snacks.picker.grep_word() end, desc = "Visual selection or word", mode = { "n", "x" } },
    -- SEARCH
    { '<leader>ss"', function() Snacks.picker.registers() end, desc = "Registers" },
    { '<leader>ss/', function() Snacks.picker.search_history() end, desc = "Search History" },
    { "<leader>ssa", function() Snacks.picker.autocmds() end, desc = "Autocmds" },
    { "<leader>ssb", function() Snacks.picker.lines() end, desc = "Buffer Lines" },
    { "<leader>ssc", function() Snacks.picker.command_history() end, desc = "Command History" },
    { "<leader>ssC", function() Snacks.picker.commands() end, desc = "Commands" },
    { "<leader>ssd", function() Snacks.picker.diagnostics() end, desc = "Diagnostics" },
    { "<leader>ssD", function() Snacks.picker.diagnostics_buffer() end, desc = "Buffer Diagnostics" },
    { "<leader>ssh", function() Snacks.picker.help() end, desc = "Help Pages" },
    { "<leader>ssH", function() Snacks.picker.highlights() end, desc = "Highlights" },
    { "<leader>ssi", function() Snacks.picker.icons() end, desc = "Icons" },
    { "<leader>ssj", function() Snacks.picker.jumps() end, desc = "Jumps" },
    { "<leader>ssk", function() Snacks.picker.keymaps() end, desc = "Keymaps" },
    { "<leader>ssl", function() Snacks.picker.loclist() end, desc = "Location List" },
    { "<leader>ssm", function() Snacks.picker.marks() end, desc = "Marks" },
    { "<leader>ssM", function() Snacks.picker.man() end, desc = "Man Pages" },
    { "<leader>ssp", function() Snacks.picker.lazy() end, desc = "Search for Plugin Spec" },
    { "<leader>ssq", function() Snacks.picker.qflist() end, desc = "Quickfix List" },
    { "<leader>ssR", function() Snacks.picker.resume() end, desc = "Resume" },
    { "<leader>ssu", function() Snacks.picker.undo() end, desc = "Undo History" },
    { "<leader>uC", function() Snacks.picker.colorschemes() end, desc = "Colorschemes" },
    -- NOTIFICATION
    { "<leader>n",  function() Snacks.notifier.show_history() end, desc = "Notification History" },
    -- GIT
    { "<leader>gg", function() Snacks.lazygit() end, desc = "Lazygit" },
    { "<leader>gb", function() Snacks.picker.git_branches() end, desc = "Git Branches" },
    { "<leader>gl", function() Snacks.picker.git_log() end, desc = "Git Log" },
    { "<leader>gL", function() Snacks.picker.git_log_line() end, desc = "Git Log Line" },
    { "<leader>gs", function() Snacks.picker.git_status() end, desc = "Git Status" },
    { "<leader>gS", function() Snacks.picker.git_stash() end, desc = "Git Stash" },
    { "<leader>gd", function() Snacks.picker.git_diff() end, desc = "Git Diff (Hunks)" },
    { "<leader>gf", function() Snacks.picker.git_log_file() end, desc = "Git Log File" },
  },
}
