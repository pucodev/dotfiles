return {
  "folke/snacks.nvim",
  priority = 1000,
  lazy = false,
  opts = {
    bigfile = { enabled = true },
    dashboard = {
      enabled = true,
      sections = {
        {
          section = "terminal",
          cmd = "cat ~/.config/nvim/lua/assets/pucodev-dashboard.ansi; sleep .1",
          width = 70,
          height = 9,
          indent = -3,
          padding = 2,
        },
        -- { section = "header" },
        { section = "keys", gap = 1, padding = 1 },
        { section = "startup" },
      },
    },
    explorer = { enabled = true },
    indent = { enabled = false },
    input = { enabled = true },
    notifier = { enabled = true },
    quickfile = { enabled = true },
    scope = { enabled = true },
    scroll = { enabled = true },
    statuscolumn = { enabled = false },
    words = { enabled = true },

    picker = {
      enabled = true,
      sources = {
        explorer = {
          hidden = true,
          include = { ".env", ".env.*" },
          -- auto_close = true,
          jump = { close = true },
        },
      },
    },
  },

  keys = {
    -- ==========
    -- EXPLORER
    -- ==========
    {
      "<leader>fe",
      function()
        require("snacks").explorer({ cwd = vim.uv.cwd() })
      end,
      desc = "Explorer Snacks (root dir)",
    },
    {
      "<leader>fE",
      function()
        require("snacks").explorer()
      end,
      desc = "Explorer Snacks (cwd)",
    },
    {
      "<leader>e",
      "<leader>fe",
      desc = "Explorer Snacks (root dir)",
      remap = true,
    },
    {
      "<leader>E",
      "<leader>fE",
      desc = "Explorer Snacks (cwd)",
      remap = true,
    },

    -- =======
    -- FIND
    -- =======
    {
      "<leader>fb",
      function()
        require("snacks").picker.buffers()
      end,
      desc = "Buffers",
    },
    {
      "<leader>fB",
      function()
        require("snacks").picker.buffers({ hidden = true, nofile = true })
      end,
      desc = "Buffers (all)",
    },
    {
      "<leader>fc",
      function()
        require("snacks").picker.files({ cwd = vim.fn.stdpath("config") })
      end,
      desc = "Find Config File",
    },
    {
      "<leader>ff",
      function()
        require("snacks").picker.files()
      end,
      desc = "Find Files",
    },
    {
      "<leader>fg",
      function()
        require("snacks").picker.git_files()
      end,
      desc = "Find Git Files",
    },
    {
      "<leader>fp",
      function()
        require("snacks").picker.projects()
      end,
      desc = "Projects",
    },
    {
      "<leader>fr",
      function()
        require("snacks").picker.recent()
      end,
      desc = "Recent",
    },

    -- =======
    -- GREP
    -- =======
    {
      "<leader>sb",
      function()
        require("snacks").picker.lines()
      end,
      desc = "Buffer Lines",
    },
    {
      "<leader>sB",
      function()
        require("snacks").picker.grep_buffers()
      end,
      desc = "Grep Open Buffers",
    },
    {
      "<leader>sg",
      function()
        require("snacks").picker.grep()
      end,
      desc = "Grep",
    },
    {
      "<leader>sw",
      function()
        require("snacks").picker.grep_word()
      end,
      desc = "Visual selection or word",
      mode = { "n", "x" },
    },

    -- =======
    -- SEARCH
    -- =======
    {
      '<leader>ss"',
      function()
        require("snacks").picker.registers()
      end,
      desc = "Registers",
    },
    {
      "<leader>ss/",
      function()
        require("snacks").picker.search_history()
      end,
      desc = "Search History",
    },
    {
      "<leader>ssa",
      function()
        require("snacks").picker.autocmds()
      end,
      desc = "Autocmds",
    },
    {
      "<leader>ssb",
      function()
        require("snacks").picker.lines()
      end,
      desc = "Buffer Lines",
    },
    {
      "<leader>ssc",
      function()
        require("snacks").picker.command_history()
      end,
      desc = "Command History",
    },
    {
      "<leader>ssC",
      function()
        require("snacks").picker.commands()
      end,
      desc = "Commands",
    },
    {
      "<leader>ssd",
      function()
        require("snacks").picker.diagnostics()
      end,
      desc = "Diagnostics",
    },
    {
      "<leader>ssD",
      function()
        require("snacks").picker.diagnostics_buffer()
      end,
      desc = "Buffer Diagnostics",
    },
    {
      "<leader>ssh",
      function()
        require("snacks").picker.help()
      end,
      desc = "Help Pages",
    },
    {
      "<leader>ssH",
      function()
        require("snacks").picker.highlights()
      end,
      desc = "Highlights",
    },
    {
      "<leader>ssi",
      function()
        require("snacks").picker.icons()
      end,
      desc = "Icons",
    },
    {
      "<leader>ssj",
      function()
        require("snacks").picker.jumps()
      end,
      desc = "Jumps",
    },
    {
      "<leader>ssk",
      function()
        require("snacks").picker.keymaps()
      end,
      desc = "Keymaps",
    },
    {
      "<leader>ssl",
      function()
        require("snacks").picker.loclist()
      end,
      desc = "Location List",
    },
    {
      "<leader>ssm",
      function()
        require("snacks").picker.marks()
      end,
      desc = "Marks",
    },
    {
      "<leader>ssM",
      function()
        require("snacks").picker.man()
      end,
      desc = "Man Pages",
    },
    {
      "<leader>ssp",
      function()
        require("snacks").picker.lazy()
      end,
      desc = "Search for Plugin Spec",
    },
    {
      "<leader>ssq",
      function()
        require("snacks").picker.qflist()
      end,
      desc = "Quickfix List",
    },
    {
      "<leader>ssR",
      function()
        require("snacks").picker.resume()
      end,
      desc = "Resume",
    },
    {
      "<leader>ssu",
      function()
        require("snacks").picker.undo()
      end,
      desc = "Undo History",
    },
    {
      "<leader>uC",
      function()
        require("snacks").picker.colorschemes()
      end,
      desc = "Colorschemes",
    },

    -- ==============
    -- NOTIFICATION
    -- ==============
    {
      "<leader>n",
      function()
        require("snacks").notifier.show_history()
      end,
      desc = "Notification History",
    },

    -- =======
    -- GIT
    -- =======
    {
      "<leader>gg",
      function()
        require("snacks").lazygit()
      end,
      desc = "Lazygit",
    },
    {
      "<leader>gb",
      function()
        require("snacks").picker.git_branches()
      end,
      desc = "Git Branches",
    },
    {
      "<leader>gl",
      function()
        require("snacks").picker.git_log()
      end,
      desc = "Git Log",
    },
    {
      "<leader>gL",
      function()
        require("snacks").picker.git_log_line()
      end,
      desc = "Git Log Line",
    },
    {
      "<leader>gs",
      function()
        require("snacks").picker.git_status()
      end,
      desc = "Git Status",
    },
    {
      "<leader>gS",
      function()
        require("snacks").picker.git_stash()
      end,
      desc = "Git Stash",
    },
    {
      "<leader>gd",
      function()
        require("snacks").picker.git_diff()
      end,
      desc = "Git Diff (Hunks)",
    },
    {
      "<leader>gf",
      function()
        require("snacks").picker.git_log_file()
      end,
      desc = "Git Log File",
    },
  },
}
