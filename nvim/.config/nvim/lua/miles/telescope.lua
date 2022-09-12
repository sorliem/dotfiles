local M = {}
M.search_dotfiles = function()
    require("telescope.builtin").find_files({
            prompt_title = "< Dotfiles >",
            cwd = vim.env.DOTFILES,
            hidden = true,
        })
end

-- search git files and if not successful do a regular find files
M.project_files = function()
    local opts = {} -- define here if you want to define something
    local ok = pcall(require'telescope.builtin'.git_files, opts)
    if not ok then require'telescope.builtin'.find_files(opts) end
end

return M
