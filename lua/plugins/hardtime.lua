--╭──────────────────────────────────────────────────────────────────────────╮--
--│                                                                          │--
--│ File: plugins/hartime.lua                                                │--
--│ Note: a plugin helping you establish good command workflow and habit     │--
--│                                                                          │--
--╰──────────────────────────────────────────────────────────────────────────╯--
return {
	"m4xshen/hardtime.nvim",
	command = "Hardtime",
	event = "BufEnter",
	dependencies = {
		"MunifTanjim/nui.nvim",
		"nvim-lua/plenary.nvim",
	},
	opts = {},
}
