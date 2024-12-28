--TODO: hello
return {
	"folke/trouble.nvim",
	dependencies = { "nvim-tree/nvim-web-devicons", "folke/todo-comments.nvim" },
	config = true,
	keys = {
		{
			"<leader>xX",
			"<cmd>Trouble diagnostics toggle focus=true auto_close=true<CR>",
			desc = "Open trouble workspace diagnostics",
		},
		{
			"<leader>xx",
			"<cmd>Trouble diagnostics toggle focus=true auto_close=true filter.buf=0<CR>",
			desc = "Open trouble workspace diagnostics",
		},
		{ "<leader>xs", "<cmd>Trouble symbols toggle<CR>", desc = "Open trouble document diagnostics" },
		{
			"<leader>cs",
			"<cmd>Trouble lsp toggle focus=false win.position=right<CR>",
			desc = "Open trouble document diagnostics",
		},
		{ "<leader>xQ", "<cmd>Trouble quickfix toggle focus=true<CR>", desc = "Open trouble quickfix list" },
		{ "<leader>xq", "<cmd>Trouble qflist toggle focus=true<CR>", desc = "Open trouble quickfix list" },
		{ "<leader>xl", "<cmd>Trouble loclist toggle focus=true<CR", desc = "Open trouble location list" },
		{ "<leader>xt", "<cmd>Trouble telescope toggle focus=true<CR>", desc = "Open trouble location list" },
		{ "<leader>xd", "<cmd>Trouble todo toggle focus=true<CR>", desc = "Open todos in trouble" },
	},
}
