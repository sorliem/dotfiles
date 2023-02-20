
return {
	{
	'ThePrimeagen/harpoon',
		config = {
			vim.keymap.set('n', "<leader>ha", ":lua require('harpoon.mark').add_file()<CR>"),
			vim.keymap.set('n', '<leader>he', ':lua require("harpoon.ui").toggle_quick_menu()<CR>', {silent = true}),
			vim.keymap.set('n', "<M-j>", ":lua require('harpoon.ui').nav_file(1)<CR>", {silent = true}),
			vim.keymap.set('n', "<M-k>", ":lua require('harpoon.ui').nav_file(2)<CR>", {silent = true}),
			vim.keymap.set('n', "<M-l>", ":lua require('harpoon.ui').nav_file(3)<CR>", {silent = true}),
			vim.keymap.set('n', "<M-;>", ":lua require('harpoon.ui').nav_file(4)<CR>", {silent = true}),
			vim.keymap.set('n', "<M-'>", ":lua require('harpoon.ui').nav_file(5)<CR>", {silent = true})
		}
	}
}
