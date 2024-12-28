return {
	"preservim/vimux",
	cmd = {
		"VimuxPromptCommand",
		"RunLastVimTmuxCommand",
		"VimuxInspectRunner",
		"VimuxZoomRunner",
	},
	keys = {
		{ "<leader>rp", "<cmd>VimuxPromptCommand<CR>" },
		{ "<leader>rl", "<cmd>RunLastVimTmuxCommand<CR>" },
		{ "<leader>ri", "<cmd>VimuxInspectRunner<CR>" },
		{ "<leader>rz", "<cmd>VimuxZoomRunner<CR>" },
	},
}
