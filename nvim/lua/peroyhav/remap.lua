-- [[ Basic Keymaps ]]
--  See `:help vim.keymap.set()`

-- Clear highlights on search when pressing <Esc> in normal mode
--  See `:help hlsearch`
vim.keymap.set("n", "<Esc>", "<cmd>nohlsearch<CR>")
-- Diagnostic keymaps
vim.keymap.set("n", "<leader>q", vim.diagnostic.setloclist, { desc = "Open diagnostic [Q]uickfix list" })

-- Exit terminal mode in the builtin terminal with a shortcut that is a bit easier
-- for people to discover. Otherwise, you normally need to press <C-\><C-n>, which
-- is not what someone will guess without a bit more experience.
--
-- NOTE: This won't work in all terminal emulators/tmux/etc. Try your own mapping
-- or just use <C-\><C-n> to exit terminal mode
vim.keymap.set("t", "<Esc><Esc>", "<C-\\><C-n>", { desc = "Exit terminal mode" })

-- TIP: Disable arrow keys in normal mode
vim.keymap.set("n", "<left>", '<cmd>echo "Use h to move!!"<CR>')
vim.keymap.set("n", "<right>", '<cmd>echo "Use l to move!!"<CR>')
vim.keymap.set("n", "<up>", '<cmd>echo "Use k to move!!"<CR>')
vim.keymap.set("n", "<down>", '<cmd>echo "Use j to move!!"<CR>')

-- Center cursor on screen when moving half pages.
vim.keymap.set("n", "<C-d>", "zz<C-d>zz")
vim.keymap.set("n", "<C-u>", "zz<C-u>zz")

-- Keybinds to make split navigation easier.
--  Use CTRL+<hjkl> to switch between windows
--
--  See `:help wincmd` for a list of all window commands
vim.keymap.set("n", "<C-h>", "<C-w><C-h>", { desc = "Move focus to the left window" })
vim.keymap.set("n", "<C-l>", "<C-w><C-l>", { desc = "Move focus to the right window" })
vim.keymap.set("n", "<C-j>", "<C-w><C-j>", { desc = "Move focus to the lower window" })
vim.keymap.set("n", "<C-k>", "<C-w><C-k>", { desc = "Move focus to the upper window" })

vim.keymap.set("n", "<leader>ex", ":Ex<CR>")

local os = require("os")
vim.keymap.set("n", "<leader>Y", '"+Y', { desc = "[Y]ank current line to system clipboard" })
vim.keymap.set("n", "<leader>y", '"+y', { desc = "[y]ank to clipboard" })
vim.keymap.set("v", "<leader>y", '"+y', { desc = "[y]ank selection to clipboard" })
vim.keymap.set("n", "<leader>p", '"+p', { desc = "[p]aste content of system clipboard after cursor position" })
vim.keymap.set("n", "<leader>P", '"+P', { desc = "[P]aste content of system clipboard before cursor position" })
vim.keymap.set("v", "<leader>p", '"+p', { desc = "[p]aste content of system clipboard over current selection" })

vim.keymap.set("n", "<leader>wc", ":w<CR>:Ex<CR>")

vim.keymap.set("v", "<A-j>", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "<A-k>", ":m '<-2<CR>gv=gv")

vim.keymap.set("n", "<A-j>", "V:m '>+1<CR>gv=gv<Esc>")
vim.keymap.set("n", "<A-k>", "V:m '<-2<CR>gv=gv<Esc>")

vim.keymap.set("n", "<leader>co", ":%bd|e#|bd#<CR>")
vim.keymap.set("n", "<leader>cb", ":!dotnet build<CR>", { desc = "[C]ode [B]uild" })
vim.keymap.set("n", "<leader>cr", ":!dotnet run<CR>", { desc = "[C]ode [R]un" })
