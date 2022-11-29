local M = {}
M.search_dotfiles = function()
    require("telescope.builtin").find_files({
            prompt_title = "< Dotfiles >",
            cwd = vim.env.DOTFILES,
            hidden = true,
        })
end

M.search_wiki = function()
    require("telescope.builtin").find_files({
            prompt_title = "< Personal VimWiki >",
            cwd = "~/vimwiki",
            hidden = true,
        })
end

-- search git files and if not successful do a regular find files
M.project_files = function()
    local opts = {} -- define here if you want to define something
    local ok = pcall(require'telescope.builtin'.git_files, opts)
    if not ok then require'telescope.builtin'.find_files(opts) end
end

function M.reload()
  -- From https://ustrajunior.com/posts/reloading-neovim-config-with-telescope/
  local function get_module_name(s)
    local module_name;

    module_name = s:gsub("%.lua", "")
    module_name = module_name:gsub("%/", ".")
    module_name = module_name:gsub("%.init", "")

    return module_name
  end

  local prompt_title = "~ neovim modules ~"

  -- sets the path to the lua folder
  local path = "~/.config/nvim/lua"

  local opts = {
    prompt_title = prompt_title,
    cwd = path,

    attach_mappings = function(_, map)
     -- Adds a new map to ctrl+e.
      map("i", "<c-e>", function(_)
        -- these two a very self-explanatory
        local entry = require("telescope.actions.state").get_selected_entry()
        local name = get_module_name(entry.value)

        -- call the helper method to reload the module
        -- and give some feedback
        R(name)
        P(name .. " RELOADED!!!")
      end)

      return true
    end
  }

  -- call the builtin method to list files
  require('telescope.builtin').find_files(opts)
end

return M
