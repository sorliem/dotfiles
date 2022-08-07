require('lualine').setup {
  options = {
    icons_enabled = true,
    -- theme = 'gruvbox',
    theme = 'auto',
    component_separators = { left = '', right = ''},
    section_separators = { left = '', right = ''},
    disabled_filetypes = {},
    always_divide_middle = true,
  },
  sections = {
    lualine_a = {},
    lualine_b = {},
    lualine_c = {
        {
            'filename',
            path = 3
        }
    },
    lualine_x = {'filetype'},
    lualine_y = {'branch', 'diff',
                  {'diagnostics', sources={'nvim_diagnostic'}}},
    lualine_z = {'progress'}
  },
  inactive_sections = {
    lualine_a = {},
    lualine_b = {},
    lualine_c = {
        {
            'filename',
            path = 3
        }
    },
    lualine_x = {'filetype'},
    lualine_y = {'branch', 'diff',
                  {'diagnostics', sources={'nvim_diagnostic'}}},
    lualine_z = {'progress'}
  },
  tabline = {},
  extensions = {}
}
