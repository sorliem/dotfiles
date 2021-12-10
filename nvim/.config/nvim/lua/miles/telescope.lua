local actions = require('telescope.actions')

require('telescope').setup{
    defaults = {
        file_sorter = require("telescope.sorters").get_fzf_sorter,
        prompt_prefix = " > ",
        color_devicons = true,
        selection_strategy = "reset",
        sorting_strategy = "descending",
        scroll_strategy = "cycle",
        preview = {
            filesize_limit = 10
        },
        file_ignore_patterns = {
            ".git"
        },
        layout_config = {
            width = 0.95,
            height = 0.85,
            -- preview_cutoff = 120,
            prompt_position = "bottom",

            horizontal = {
                preview_width = function(_, cols, _)
                    if cols > 200 then
                        return math.floor(cols * 0.4)
                    else
                        return math.floor(cols * 0.6)
                    end
                end,
            },

            vertical = {
                width = 0.9,
                height = 0.95,
                preview_height = 0.5,
            },

            flex = {
                horizontal = {
                    preview_width = 0.9,
                },
            },
        },
        mappings = {
            i = {
                -- close on escape
                -- ["<esc>"] = actions.close,
                ["<tab>"] = actions.toggle_selection + actions.move_selection_previous,
                ["<s-tab>"] = actions.toggle_selection + actions.move_selection_next,
                ["<C-Down>"] = require('telescope.actions').cycle_history_next,
                ["<C-Up>"] = require('telescope.actions').cycle_history_prev,
                ["<C-w>"] = function()
                    vim.cmd [[normal! bcw]]
                end,
            },
            n = {
                ["<tab>"] = actions.toggle_selection + actions.move_selection_previous,
                ["<s-tab>"] = actions.toggle_selection + actions.move_selection_next,
            }
        }
    },
    pickers = {
        -- Default configuration for builtin pickers goes here:
        -- picker_name = {
        --   picker_config_key = value,
        --   ...
        -- }
        -- Now the picker_config_key will be applied every time you call this
        -- builtin picker
    },
    extensions = {
        -- Your extension configuration goes here:
        -- extension_name = {
        --   extension_config_key = value,
        -- }
        -- please take a look at the readme of the extension you want to configure
        fzf = {
            fuzzy = true,
            override_generic_sorter = true,
            override_file_sorter = true,
            case_mode = "smart_case",
        }
    }
}

require('telescope').load_extension('fzf')

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
