local Remap = require("miles.keymap")
local nnoremap = Remap.nnoremap
local vnoremap = Remap.vnoremap

require('gitsigns').setup({
    current_line_blame = false,
    current_line_blame_opts = {
      virt_text = true,
      virt_text_pos = 'right_align', -- 'eol' | 'overlay' | 'right_align'
      delay = 0,
      ignore_whitespace = false,
    },
    on_attach = function(--[[bufnr]])
      local gs = package.loaded.gitsigns

      -- Navigation
      nnoremap(']c', function()
        if vim.wo.diff then return ']c' end
        vim.schedule(function() gs.next_hunk() end)
        return '<Ignore>'
      end, {expr=true})

      nnoremap('[c', function()
        if vim.wo.diff then return '[c' end
        vim.schedule(function() gs.prev_hunk() end)
        return '<Ignore>'
      end, {expr=true})

      -- Actions
      -- nnoremap('<leader>hs', ':Gitsigns stage_hunk<CR>')
      -- nnoremap('<leader>hr', ':Gitsigns reset_hunk<CR>')
      -- vnoremap('<leader>hs', ':Gitsigns stage_hunk<CR>')
      -- vnoremap('<leader>hr', ':Gitsigns reset_hunk<CR>')
      -- nnoremap('<leader>hS', gs.stage_buffer)
      -- nnoremap('<leader>hu', gs.undo_stage_hunk)
      -- nnoremap('<leader>hR', gs.reset_buffer)
      nnoremap('<leader>hp', gs.preview_hunk)
      nnoremap('<leader>hb', function() gs.blame_line{full=true} end)
      nnoremap('<leader>tb', gs.toggle_current_line_blame)
      nnoremap('<leader>hd', gs.diffthis)
      nnoremap('<leader>hD', function() gs.diffthis('~') end)
      -- nnoremap('<leader>td', gs.toggle_deleted)

      -- Text object
      -- map({'o', 'x'}, 'ih', ':<C-U>Gitsigns select_hunk<CR>')
    end
})
