-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here

vim.opt.colorcolumn = "120"
vim.opt.cursorline = true
vim.opt.fillchars = { eob = " ", vert = "│", horiz = "─", fold = " " }

vim.api.nvim_create_autocmd("ColorScheme", {
  callback = function()
    local palette = {
      peach      = "#FFAB91",
      coral      = "#FF8A80",
      lavender   = "#B39DDB",
      mint       = "#80CBC4",
      sky        = "#81D4FA",
      sand       = "#FFE0B2",
      rose       = "#F48FB1",
      sage       = "#A5D6A7",
    }

    local treesitter_hl = {
      { "@variable",        fg = palette.peach },
      { "@function.call",   fg = palette.lavender },
      { "@parameter",       fg = palette.sand },
      { "@property",        fg = palette.sky },
      { "@field",           fg = palette.sky },
      { "@constant",        fg = palette.coral },
      { "@type",            fg = palette.mint },
      { "@comment",         fg = "#6C7086", italic = true },
    }

    local ui_hl = {
      { "LineNr",           fg = "#45475A" },
      { "CursorLine",       bg = "#1E1E2E" },
      { "Visual",           bg = "#313244" },
      { "Pmenu",            bg = "#1E1E2E", fg = "#CDD6F4" },
      { "PmenuSel",         bg = "#45475A", fg = "#CDD6F4" },
      { "FloatBorder",      fg = "#585B70" },
    }

    for _, hl in ipairs(treesitter_hl) do
      vim.api.nvim_set_hl(0, hl[1], { fg = hl.fg, bold = hl.bold, italic = hl.italic })
    end
    for _, hl in ipairs(ui_hl) do
      vim.api.nvim_set_hl(0, hl[1], { fg = hl.fg, bg = hl.bg, bold = hl.bold, italic = hl.italic })
    end
  end,
})
vim.cmd("doautocmd ColorScheme")
