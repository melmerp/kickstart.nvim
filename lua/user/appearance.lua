-- @module user.transparency
-- ~/.config/nvim/lua/user/transparency.lua

local appearance = {}

appearance.setup = function()
  -- Fixes tmux inactive window dimming: Neovim's default background
  -- usually overrides terminal/tmux colors. By clearing the 'bg' of
  -- these highlight groups, Neovim becomes "see-through," letting
  -- tmux control the background color of the pane.
  vim.api.nvim_create_autocmd('ColorScheme', {
    pattern = '*',
    callback = function()
      local hl_groups = {
        -- Main backgrounds
        'Normal',
        'NormalNC',
        'NonText',

        -- Gutter and Line Numbers
        'SignColumn',
        'LineNr',
        'CursorLineNr', -- The current line number

        -- Gitsigns
        'GitSignsAdd',
        'GitSignsChange',
        'GitSignsDelete',

        -- Diagnostics (LSP icons in gutter)
        'DiagnosticSignError',
        'DiagnosticSignWarn',
        'DiagnosticSignInfo',
        'DiagnosticSignHint',

        -- Floating windows (optional, but recommended for consistency)
        'NormalFloat',
        'FloatBorder',
      }

      for _, group in ipairs(hl_groups) do
        vim.api.nvim_set_hl(0, group, { bg = 'none', ctermbg = 'none' })
      end
    end,
  })

  -- Manually trigger once to apply to current session
  vim.cmd('colorscheme ' .. (vim.g.colors_name or 'default'))
  ----
  vim.cmd [[highlight CursorLine guibg=#1a1a1a]] -- Example terminal color name
end

return appearance
