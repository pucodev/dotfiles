-- Create annotations with one keybind, and jump your cursor in the inserted annotation
return {
  "danymat/neogen",
  config = true,
  keys = {
    { "<leader>cn", ":lua require('neogen').generate()<CR>", desc = "Add annotation" },
    { "<leader>caf", ":lua require('neogen').generate({type = 'func'})<CR>", desc = "Add function annotation" },
    { "<leader>cac", ":lua require('neogen').generate({type = 'class'})<CR>", desc = "Add class annotation" },
    { "<leader>cat", ":lua require('neogen').generate({type = 'type'})<CR>", desc = "Add type annotation" },
    { "<leader>cal", ":lua require('neogen').generate({type = 'file'})<CR>", desc = "Add file annotation" },
  },
  -- Uncomment next line if you want to follow only stable versions
  -- version = "*"
}
