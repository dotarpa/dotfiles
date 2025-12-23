return {
	{
		"CopilotC-Nvim/CopilotChat.nvim",
		build = "make tiktoken",
		dependencies = {
			{ "nvim-lua/plenary.nvim", branch = "master" },
			"nvim-telescope/telescope.nvim",
		},
		cmd = { "CopilotChat" },

		keys = {
			{ "<leader>1", "<cmd>CopilotChat<cr>", desc = "CopilotChat: open" },

			{
				"<leader>9",
				function()
					local input = vim.fn.input("Quick Chat: ")
					if input ~= "" then
						require("CopilotChat").ask(input, { selection = "buffer" })
					end
				end,
				desc = "CopilotChat: quick chat (buffer)",
			},

			--      {
			--        "<leader>0",
			--        function()
			--          local actions = require("CopilotChat.actions")
			--          require("CopilotChat.integrations.telescope").pick(actions.prompt_actions())
			--        end,
			--        desc = "CopilotChat: prompt actions",
			--      },
			{ "<leader>0", "<cmd>CopilotChatPrompt<cr>", desc = "CopilotChat: prompts" },

			-- おまけ: 診断を投げたい場合は自前でテキスト化して送る（selectモジュール依存なし）
			{
				"<leader>8",
				function()
					local diags = vim.diagnostic.get(0)
					if #diags == 0 then
						require("CopilotChat").ask(
							"このファイルの診断はありません。",
							{ selection = "buffer" }
						)
						return
					end
					table.sort(diags, function(a, b)
						return a.lnum < b.lnum
					end)
					local lines = {}
					for _, d in ipairs(diags) do
						table.insert(lines, string.format("%d:%d %s", d.lnum + 1, d.col + 1, d.message))
					end
					local body = table.concat(lines, "\n")
					require("CopilotChat").ask(
						"次の診断を解消する修正案を提案して、必要ならパッチも示してください:\n\n"
							.. body,
						{ selection = "buffer" }
					)
				end,
				desc = "CopilotChat: fix diagnostics (no select module)",
			},
			{ "<leader>6", "<cmd>CopilotChatModels<cr>", desc = "CopilotChat: models" },
		},

		opts = {
			window = { layout = "vertical", relative = "editor" },
			prompts = {
				Explain = {
					prompt = "選択されたコードの説明を段落をつけて書いてください。",
				},
				Review = {
					prompt = "選択されたコードをレビューしてください。",
				},
				Fix = {
					prompt = "このコードには問題があります。バグを修正したコードに書き直してください。",
				},
				Optimize = {
					prompt = "選択されたコードを最適化してパフォーマンスと可読性を向上させてください。",
				},
				Docs = {
					prompt = "選択されたコードに対してドキュメンテーションコメントを追加してください。",
				},
				Tests = {
					prompt = "選択されたコードの詳細な単体テスト関数を書いてください。",
				},
			},
		},
	},
}
