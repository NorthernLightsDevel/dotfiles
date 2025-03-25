return {
	"vim-test/vim-test",
	vim.keymap.set("n", "<leader>tt", ":TestFile<CR>"),
	vim.keymap.set("n", "<leader>ta", ":TestSuite<CR>"),
	vim.keymap.set("n", "<leader>tl", ":TestLast<CR>"),
	vim.keymap.set("n", "<leader>tg", ":TestVisit<CR>"),
}
