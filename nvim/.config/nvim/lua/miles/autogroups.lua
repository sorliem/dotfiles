local augroup = vim.api.nvim_create_augroup
local autocmd = vim.api.nvim_create_autocmd
MilesDevGroup = augroup('Miles', {})
YankGroup = augroup('YankGroup', {})
WhiteSpaceGroup = augroup('WhiteSpaceGroup', {})
PackerGroup = augroup('PackerGroup', {})

autocmd('BufWritePre', {
    group = WhiteSpaceGroup,
    pattern = '*',
    command = '%s/\\s\\+$//e'
})

-- autocmd('WinLeave', {
--     pattern = '*',
--     command = 'set nocursorline'
-- })

-- autocmd('WinEnter', {
--     pattern = '*',
--     command = 'set cursorline'
-- })

autocmd('WinLeave', {
    pattern = '*',
    callback = function()
        vim.opt.cursorline = false
        vim.opt.cursorcolumn = false
    end
})

autocmd('WinEnter', {
    pattern = '*',
    callback = function()
        vim.opt.cursorline = true
        vim.opt.cursorcolumn = true
    end
})

autocmd('TextYankPost', {
    group = YankGroup,
    pattern = '*',
    callback = function()
      vim.highlight.on_yank{higroup="IncSearch", timeout=250}
    end
})

autocmd({'BufNewFile','BufRead'}, {
    group = MilesDevGroup,
    pattern = {'*.ex', '.exs'},
    command = 'set syntax=elixir'
})

autocmd({'BufNewFile','BufRead'}, {
    group = MilesDevGroup,
    pattern = '*.eex',
    command = 'set syntax=eelixir'
})

autocmd('FileType', {
    group = MilesDevGroup,
    pattern = {'gitcommit', 'markdown'},
    callback = function()
      vim.opt_local.spell = true
      vim.opt_local.wrap = true
    end
})

autocmd('FileType', {
    group = MilesDevGroup,
    pattern = {'vimwiki'},
    callback = function()
      vim.opt_local.spell = true
      vim.opt.listchars:remove('eol')
    end
})

autocmd('BufWritePost', {
    group = PackerGroup,
    pattern = 'packer.lua',
    command = 'source <afile> | PackerCompile'
})

local attach_to_buffer = function(output_bufnr, pattern, command)
    vim.api.nvim_create_autocmd("BufWritePost", {
        group = vim.api.nvim_create_augroup("miles-autorun", { clear = true }),
        pattern = pattern,
        callback = function()
            local append_data = function(_, data)
                if data then
                    vim.api.nvim_buf_set_lines(output_bufnr, -1, -1, false, data)
                end
            end

            vim.api.nvim_buf_set_lines(output_bufnr, 0, -1, false, { "main.ex output:" })
            vim.fn.jobstart(command, {
                stdout_buffered = true,
                on_stdout = append_data,
                on_stderr = append_data,
            })
        end
    })
end

attach_to_buffer(34, "main.ex", { "elixir", "main.ex" })

vim.api.nvim_create_user_command("AutoRun", function()
    local bufnr = vim.fn.input("Bufnr: ")
    local pattern = vim.fn.input "Pattern: "
    local command = vim.split(vim.fn.input "Command: ", " ")
    attach_to_buffer(tonumber(bufnr), pattern, command)
end, {})
