-- From https://github.com/nvim-telescope/telescope.nvim/issues/416#issuecomment-841273053

local actions = require("telescope.actions")
local action_state = require("telescope.actions.state")

local custom_actions = {}

function custom_actions.fzf_multi_select(prompt_bufnr)
    local picker = action_state.get_current_picker(prompt_bufnr)
    local num_selections = table.getn(picker:get_multi_selection())

    if num_selections > 1 then
        -- actions.file_edit throws - context of picker seems to change
        --actions.file_edit(prompt_bufnr)
        actions.send_selected_to_qflist(prompt_bufnr)
        actions.open_qflist()
    else
        actions.file_edit(prompt_bufnr)
    end
end

require("telescope").setup {
    defaults = {
        mappings = {
            i = {
                -- close on escape
                ["<esc>"] = actions.close,
                ["<tab>"] = actions.toggle_selection + actions.move_selection_next,
                ["<s-tab>"] = actions.toggle_selection + actions.move_selection_previous,
                ["<cr>"] = custom_actions.fzf_multi_select
            },
            n = {
                ["<tab>"] = actions.toggle_selection + actions.move_selection_next,
                ["<s-tab>"] = actions.toggle_selection + actions.move_selection_previous,
                ["<cr>"] = custom_actions.fzf_multi_select
            }
        }
    }
}

require('telescope').load_extension('fzf')
