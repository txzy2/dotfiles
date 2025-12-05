-- bootstrap lazy.nvim, LazyVim and your plugins
require("config.lazy")

-- vim.g.lazyvim_check_order = false
-- Отключаем форматирование при сохранении для PHP
vim.api.nvim_create_autocmd("FileType", {
  pattern = "php",
  callback = function()
    vim.b.autoformat = false
  end,
})
