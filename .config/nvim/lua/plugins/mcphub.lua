return {
	{
		"ravitemer/mcphub.nvim",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"Joakker/lua-json5",
			build = "./install.sh",
		},
		build = "npm install -g mcp-hub@latest",
		config = function()
			require("mcphub").setup({
				json_decode = require("json5").parse,
			})
		end,
	},
}
