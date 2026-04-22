return {
	"polarmutex/git-worktree.nvim",
	version = "^2",
	dependencies = { "nvim-lua/plenary.nvim" },
	cond = false,
	config = function()
		local Worktree = require("git-worktree")
		local gw = require("git-worktree")

		-- Creates a worktree.  Requires the path, branch name, and the upstream
		-- Example:
		vim.keymap.set("n", "<leader>gw", function()
			require("telescope").extensions.git_worktree.git_worktrees()
		end, { desc = "[G]it [W]orktrees" })

		vim.keymap.set("n", "<leader>gaw", function()
			local base = vim.fn.input("base (default:master)>")
			local base = base or "master"
			local branch = vim.fn.input("worktree name")

			gw.create_worktree(branch, base, "origin")
		end, { desc = "[G]it [A]dd [W]orktree" })

		Worktree.on_tree_change(function(op, metadata)
			if op == Worktree.Operations.Switch then
				print("Switched from " .. metadata.prev_path .. " to " .. metadata.path)
			end
		end)
	end,
}
