vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

local map = vim.keymap.set

-- save file
map({ "i", "x", "n", "s" }, "<C-s>", "<cmd>w<cr><esc>", { desc = "Save File" })

-- Move Lines
map("n", "<A-j>", "<cmd>m .+1<cr>==", { desc = "Move Down" })
map("n", "<A-k>", "<cmd>m .-2<cr>==", { desc = "Move Up" })
map("i", "<A-j>", "<esc><cmd>m .+1<cr>==gi", { desc = "Move Down" })
map("i", "<A-k>", "<esc><cmd>m .-2<cr>==gi", { desc = "Move Up" })
map("v", "<A-j>", ":m '>+1<cr>gv=gv", { desc = "Move Down" })
map("v", "<A-k>", ":m '<-2<cr>gv=gv", { desc = "Move Up" })

-- buffers
map("n", "<S-h>", "<cmd>bprevious<cr>", { desc = "Prev Buffer" })
map("n", "<S-l>", "<cmd>bnext<cr>", { desc = "Next Buffer" })
map("n", "[b", "<cmd>bprevious<cr>", { desc = "Prev Buffer" })
map("n", "]b", "<cmd>bnext<cr>", { desc = "Next Buffer" })
map("n", "<leader>bb", "<cmd>e #<cr>", { desc = "Switch to Other Buffer" })
map("n", "<leader>`", "<cmd>e #<cr>", { desc = "Switch to Other Buffer" })
map("n", "<leader>bd", "<cmd>:bd<cr>", { desc = "Delete Buffer and Window" })

-- Clear search with <esc>
map({ "i", "n" }, "<esc>", "<cmd>noh<cr><esc>", { desc = "Escape and Clear hlsearch" })

-- toggle
local toggle = require("util").toggle
map("n", "<leader>tw", function()
  toggle.wrap()
end, { desc = "Toggle Wrap" })

-- quit
map("n", "<leader>qq", "<cmd>qa<cr>", { desc = "Quit All" })

-- Move to window using the <ctrl> hjkl keys
map("n", "<C-h>", "<C-w>h", { desc = "Go to Left Window", remap = true })
map("n", "<C-j>", "<C-w>j", { desc = "Go to Lower Window", remap = true })
map("n", "<C-k>", "<C-w>k", { desc = "Go to Upper Window", remap = true })
map("n", "<C-l>", "<C-w>l", { desc = "Go to Right Window", remap = true })

-- Resize window using <ctrl> arrow keys
map("n", "<C-S-Up>", "<cmd>resize +2<cr>", { desc = "Increase Window Height" })
map("n", "<C-S-Down>", "<cmd>resize -2<cr>", { desc = "Decrease Window Height" })
map("n", "<C-S-Left>", "<cmd>vertical resize -2<cr>", { desc = "Decrease Window Width" })
map("n", "<C-S-Right>", "<cmd>vertical resize +2<cr>", { desc = "Increase Window Width" })

-- lazy
map("n", "<leader>l", "<cmd>Lazy<cr>", { desc = "Lazy" })

-- UI
map("n", "<leader>ui", vim.show_pos, { desc = "Inspect Pos" })
map("n", "<leader>uI", "<cmd>InspectTree<cr>", { desc = "Inspect Tree" })

-- windows
map("n", "<leader>ws", ":vsplit | wincmd h | bprevious<CR>", { desc = "Split and go to previous buffer" })
map("n", "<leader>wS", ":split | wincmd k | bprevious<CR>", { desc = "Horizontal split and go to previous buffer" })
map("n", "<leader>wq", "<C-W>c", { desc = "Delete Window", remap = true })

-- Delete and change not copy to clipboard
map({ "n", "x", "v" }, "d", '"_d', { desc = "Delete without clipboard", noremap = true, silent = true })
map({ "n", "x", "v" }, "c", '"_c', { desc = "Change without clipboard", noremap = true, silent = true })

-- Keeping the cursor centered.
vim.keymap.set("n", "<C-d>", "<C-d>zz", { desc = "Scroll downwards" })
vim.keymap.set("n", "<C-u>", "<C-u>zz", { desc = "Scroll upwards" })
vim.keymap.set("n", "n", "nzzzv", { desc = "Next result" })
vim.keymap.set("n", "N", "Nzzzv", { desc = "Previous result" })

-- Indent while remaining in visual mode.
vim.keymap.set("v", "<", "<gv")
vim.keymap.set("v", ">", ">gv")

-- Make U opposite to u.
vim.keymap.set("n", "U", "<C-r>", { desc = "Redo" })

-- Custom remaps
vim.keymap.set("n", "<leader><space>a", "gg<S-v>G", { desc = "Select all" })
vim.api.nvim_set_keymap(
  "n",
  "<leader><space>b",
  ":norm yygccp<CR>",
  { desc = "Copy, comment and paste", noremap = true, silent = true }
)
vim.api.nvim_set_keymap(
  "v",
  "<leader><leader>S",
  'y/<C-r>"<CR>',
  { desc = "Search selected text", noremap = true, silent = true }
)

vim.api.nvim_set_keymap(
  "n",
  "<leader><leader>s",
  'yiw/<C-r>"<CR>',
  { desc = "Select all word and search", noremap = true, silent = true }
)

--- delete copping to clipboard
map({ "n", "x", "v" }, "<leader><space>d", '"+d', { desc = "Delete and save clipboard", noremap = true, silent = true })
map({ "n", "x", "v" }, "<leader><space>c", '"+c', { desc = "Change and save clipboard", noremap = true, silent = true })

-- Reload Neovim config
map("n", "<leader>r", ":source ~/.config/nvim/init.lua<CR>", { desc = "Reload Neovim config" })

-- Window maximixes
map({ "n", "x", "v" }, "<leader>ww", "<cmd>WindowsMaximize<cr>", {
  desc = "Toggle Maximize Window",
})
map({ "n", "x", "v" }, "<leader>wv", "<cmd>WindowsMaximizeVertically<cr>", {
  desc = "Toggle Maximize Window Vertically",
})
map({ "n", "x", "v" }, "<leader>wh", "<cmd>WindowsMaximizeHorizontally<cr>", {
  desc = "Toggle Maximize Window Horizontally",
})
map({ "n", "x", "v" }, "<leader>we", "<cmd>WindowsEqualize<cr>", {
  desc = "Toggle Equalize Window",
})
