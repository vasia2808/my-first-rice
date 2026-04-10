vim.pack.add({
    'https://github.com/RRethy/base16-nvim',
    'https://github.com/nvim-lualine/lualine.nvim'
})

vim.cmd.colorscheme('base16-espresso')

local function override_bg(group, color)
  local hl = vim.api.nvim_get_hl(0, { name = group })
  hl.bg = color
  hl.link = nil
  vim.api.nvim_set_hl(0, group, hl)
end

local function override_fg(group, color)
  local hl = vim.api.nvim_get_hl(0, { name = group })
  hl.fg = color
  hl.link = nil
  vim.api.nvim_set_hl(0, group, hl)
end

override_bg('Normal', '#191319')
override_bg('NormalFloat', '#191319')
override_bg('EndOfBuffer', '#191319')
override_bg('LineNr', '#191319')
override_bg('CursorLine', '#2d262c')
override_bg('CursorLineNr', '#2d262c')

override_fg('LineNr', '#777777')

local colors = {
  color2   = '#3a3339',
  color3   = '#d197d9',
  color4   = '#cccccc',
  color5   = '#453d43',
  color13  = '#a5c261',
  color10  = '#6c99bb',
  color8   = '#f9a959',
  color9   = '#b4b7b4',
}

require('lualine').setup {
  options = {
    theme = {
      visual = {
        a = { fg = colors.color2, bg = colors.color3, gui = 'bold' },
        b = { fg = colors.color4, bg = colors.color5 },
      },
      replace = {
        a = { fg = colors.color2, bg = colors.color8, gui = 'bold' },
        b = { fg = colors.color4, bg = colors.color5 },
      },
      inactive = {
        c = { fg = colors.color4, bg = colors.color2 },
        a = { fg = colors.color4, bg = colors.color5, gui = 'bold' },
        b = { fg = colors.color4, bg = colors.color5 },
      },
      normal = {
        c = { fg = colors.color9, bg = colors.color2 },
        a = { fg = colors.color2, bg = colors.color10, gui = 'bold' },
        b = { fg = colors.color4, bg = colors.color5 },
      },
      insert = {
        a = { fg = colors.color2, bg = colors.color13, gui = 'bold' },
        b = { fg = colors.color4, bg = colors.color5 },
      }
    },
    component_separators = { left = '', right = ''},
    section_separators = { left = '', right = ''}
  },
  sections = {
    lualine_a = {'mode'},
    lualine_b = {},
    lualine_c = {'filename'},
    lualine_x = {},
    lualine_y = {'progress'},
    lualine_z = {'location'}
  }
}

vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true

vim.opt.number = true
vim.opt.relativenumber = true

vim.opt.cursorline = true
vim.opt.showmode = false
vim.opt.fillchars:append { eob = ' ' }

vim.opt.guicursor = 'n-v-o-r-cr:block-blinkoff600-blinkon600,i-c-ci-ve:ver20-blinkoff600-blinkon600'

