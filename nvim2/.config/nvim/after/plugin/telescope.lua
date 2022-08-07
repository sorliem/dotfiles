local Remap = require("miles.keymap")
local nnoremap = Remap.nnoremap

local actions = require('telescope.actions')
local action_layout = require('telescope.actions.layout')

nnoremap("<C-P>", ":lua require('miles.telescope').project_files()<CR>")
-- nnoremap <leader>o :lua require('telescope.builtin').oldfiles()<CR>
nnoremap("<leader>vrc", ":lua require('miles.telescope').search_dotfiles()<CR>")
nnoremap("<leader><leader>", ":lua require('telescope.builtin').buffers()<CR>")
nnoremap("<leader>ht", ":lua require('telescope.builtin').help_tags()<CR>")
nnoremap("<leader>gc", ":lua require('telescope.builtin').git_branches()<CR>")
nnoremap("<leader>gm", ":lua require('telescope.builtin').git_commits()<CR>")
nnoremap("<leader>gf", ":lua require('telescope.builtin').git_status()<CR>")

require('telescope').setup{
    defaults = {
        file_sorter = require("telescope.sorters").get_fzf_sorter,
        prompt_prefix = " > ",
        color_devicons = true,
        selection_strategy = "reset",
        sorting_strategy = "ascending",
        scroll_strategy = "cycle",
        preview = {
            filesize_limit = 10
        },
        file_ignore_patterns = {
            ".git"
        },
        layout_config = {
            width = 0.75,
            height = 0.85,
            -- preview_cutoff = 120,
            prompt_position = "top",

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
                width = 0.7,
                height = 0.85,
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
                ["<esc>"] = actions.close,
                ["<tab>"] = actions.toggle_selection + actions.move_selection_next,
                ["<s-tab>"] = actions.toggle_selection + actions.move_selection_previous,
                ["<C-Down>"] = require('telescope.actions').cycle_history_next,
                ["<C-Up>"] = require('telescope.actions').cycle_history_prev,
                ["<M-p>"] = action_layout.toggle_preview,
                ["<C-w>"] = function()
                    vim.cmd [[normal! bcw]]
                end,
            },
            n = {
                ["<tab>"] = actions.toggle_selection + actions.move_selection_next,
                ["<s-tab>"] = actions.toggle_selection + actions.move_selection_previous,
                ["<M-p>"] = action_layout.toggle_preview,
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
require("telescope").load_extension("live_grep_args")
require("telescope").load_extension("git_worktree")
