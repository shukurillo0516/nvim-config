return {
	"nvim-telescope/telescope.nvim",
	tag = "0.1.5",
	dependencies = {
		"nvim-lua/plenary.nvim",
		{
			"nvim-telescope/telescope-fzf-native.nvim",
			build = "make",
		},
	},
	config = function()
		local telescope = require("telescope")

		local focus_preview = function(prompt_bufnr)
			local picker = action_state.get_current_picker(prompt_bufnr)
			local prompt_win = picker.prompt_win
			local previewer = picker.previewer
			if previewer == nil then
				return
			end
			local winid = previewer.state.winid
			local bufnr = previewer.state.bufnr
			if previewer.state.winid == nil then
				bufnr = previewer.state.termopen_bufnr
				winid = vim.fn.win_findbuf(bufnr)[1]
			end
			local cursor = api.nvim_win_get_cursor(winid)
			keymap("n", "<Tab>", function()
				api.nvim_win_set_cursor(winid, cursor)
				require("config.utils").update_preview_state(bufnr, winid)
				vim.cmd(string.format("noautocmd lua vim.api.nvim_set_current_win(%s)", prompt_win))
			end, { buffer = bufnr })
			local write = function()
				local lines = vim.api.nvim_buf_get_lines(0, 0, -1, false)
				local entry = require("telescope.actions.state").get_selected_entry()
				local filename = require("plenary.path"):new(entry.filename):normalize(vim.loop.cwd())
				local real_buf = vim.fn.bufadd(filename)
				vim.fn.bufload(real_buf)
				vim.api.nvim_buf_call(real_buf, function()
					vim.api.nvim_buf_set_lines(real_buf, 0, -1, false, lines)
					vim.cmd.write()
				end)
			end
			keymap("n", "<leader>w", function()
				write()
			end, { buffer = bufnr })
			keymap("n", "<d-s>", function()
				write()
			end, { buffer = bufnr })
			keymap("n", "<cr>", function()
				local filename = vim.b[bufnr].filepath
				local row, col = unpack(api.nvim_win_get_cursor(winid))
				actions.close(prompt_bufnr)

				vim.cmd(
					string.format("lua EditLineFromLazygit('%s','%s','%s')", filename, tostring(row), tostring(col))
				)
			end, { buffer = bufnr })
			keymap("n", "q", function()
				_G.hide_cursor(function() end)
				actions.close(prompt_bufnr)
			end, { buffer = bufnr })
			vim.cmd(string.format("noautocmd lua vim.api.nvim_set_current_win(%s)", winid))
		end

		local builtin = require("telescope.builtin")
		vim.keymap.set("n", "<leader>pf", function()
			builtin.find_files({ hidden = true })
		end, {})
		vim.keymap.set("n", "<C-p>", builtin.git_files, {})
		vim.keymap.set("n", "<leader>pws", function()
			local word = vim.fn.expand("<cword>")
			builtin.grep_string({ search = word })
		end)
		vim.keymap.set("n", "<leader>pWs", function()
			local word = vim.fn.expand("<cWORD>")
			builtin.grep_string({ search = word })
		end)
		vim.keymap.set("n", "<leader>ps", function()
			builtin.grep_string({ search = vim.fn.input("Grep > ") })
		end)
		vim.keymap.set("n", "<leader>vh", builtin.help_tags, {})

		-- Enable FZF if installed
		pcall(telescope.load_extension, "fzf")

		telescope.setup({
			defaults = {
				file_ignore_patterns = {
					"node_modules",
					".git/",
				},
			},
			mapppings = {
				n = {
					["<C-f>"] = focus_preview,
				},
				i = {
					["<C-f>"] = focus_preview,
				},
			},
		})
	end,
}
