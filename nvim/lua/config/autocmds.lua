-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
--
-- Add any additional autocmds here
-- with `vim.api.nvim_create_autocmd`
--
-- Or remove existing autocmds by their group name (which is prefixed with `lazyvim_` for the defaults)
-- e.g. vim.api.nvim_del_augroup_by_name("lazyvim_wrap_spell")

vim.api.nvim_create_autocmd("FileType", {
  pattern = "php",
  callback = function()
    vim.b.autoformat = false
  end,
})

vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
  pattern = "*.log",
  callback = function()
    vim.bo.filetype = "log"
  end,
})

vim.api.nvim_create_autocmd("FileType", {
  pattern = "log",
  callback = function()
    vim.wo.wrap = true
    vim.wo.linebreak = true
    vim.wo.breakindent = true

    local buf = vim.api.nvim_get_current_buf()

    vim.api.nvim_set_hl(0, "LogError", { fg = "#f38ba8", bold = true })
    vim.api.nvim_set_hl(0, "LogWarn", { fg = "#fab387", bold = true })
    vim.api.nvim_set_hl(0, "LogInfo", { fg = "#a6e3a1" })
    vim.api.nvim_set_hl(0, "LogDebug", { fg = "#89b4fa" })
    vim.api.nvim_set_hl(0, "LogTimestamp", { fg = "#6c7086" })
    vim.api.nvim_set_hl(0, "LogSource", { fg = "#cba6f7" })

    local ns = vim.api.nvim_create_namespace("log_highlights")

    local patterns = {
      { pattern = "%d%d%d%d%-%d%d%-%d%d[^%s]*%s+%d%d:%d%d:%d%d[%.,]%d+", hl = "LogTimestamp" },
      { pattern = "%f[%u]ERROR%f[^%u]", hl = "LogError" },
      { pattern = "%f[%u]WARN%f[^%u]", hl = "LogWarn" },
      { pattern = "%f[%u]INFO%f[^%u]", hl = "LogInfo" },
      { pattern = "%f[%u]DEBUG%f[^%u]", hl = "LogDebug" },
      { pattern = "ERROR", hl = "LogError" },
      { pattern = "WARN", hl = "LogWarn" },
      { pattern = "INFO", hl = "LogInfo" },
      { pattern = "DEBUG", hl = "LogDebug" },
    }

    local function highlight_log()
      vim.api.nvim_buf_clear_namespace(buf, ns, 0, -1)
      local lines = vim.api.nvim_buf_get_lines(buf, 0, -1, false)
      for i, line in ipairs(lines) do
        for _, item in ipairs(patterns) do
          local start_idx = line:find(item.pattern)
          if start_idx then
            local end_idx = start_idx + #item.pattern - 1
            vim.api.nvim_buf_add_highlight(buf, ns, item.hl, i - 1, start_idx - 1, end_idx)
          end
        end
      end
    end

    highlight_log()
    vim.api.nvim_create_autocmd({ "TextChanged", "TextChangedI" }, {
      buffer = buf,
      callback = highlight_log,
    })
  end,
})
