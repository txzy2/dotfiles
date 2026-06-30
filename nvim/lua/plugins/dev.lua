-- ============================================================
-- Theme
-- ============================================================
return {
  {
    "catppuccin/nvim",
    name = "catppuccin",
    priority = 1000,
    opts = {
      flavour = "frappe",
      transparent_background = false,
      integrations = {
        cmp = true,
        gitsigns = true,
        treesitter = true,
        mason = true,
        telescope = { enabled = true },
        native_lsp = {
          enabled = true,
          underlines = {
            errors = { "undercurl" },
            hints = { "undercurl" },
            warnings = { "undercurl" },
            information = { "undercurl" },
          },
        },
      },
    },
  },
  {
    "folke/tokyonight.nvim",
    priority = 1000,
    opts = {
      style = "storm",
      transparent = false,
      terminal_colors = true,
    },
  },
  {
    "LazyVim/LazyVim",
    opts = { colorscheme = "tokyonight" },
  },

  -- ============================================================
  -- TypeScript
  -- ============================================================
  { import = "lazyvim.plugins.extras.lang.typescript" },

  -- ============================================================
  -- PHP
  -- ============================================================
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        phpactor = {},
        intelephense = {},
      },
    },
  },
  {
    "stevearc/conform.nvim",
    opts = {
      formatters_by_ft = {
        php = { "php_cs_fixer" },
      },
    },
  },

  -- ============================================================
  -- Universal imports
  -- ============================================================
  {
    "neovim/nvim-lspconfig",
    init = function()
      vim.keymap.set("n", "<leader>ci", function()
        vim.lsp.buf.code_action()
      end, { desc = "Code Actions (import, refactor)" })
    end,
  },

  -- ============================================================
  -- Autocompletion (nvim-cmp + NeoCodeium)
  -- ============================================================
  {
    "hrsh7th/nvim-cmp",
    dependencies = {
      "hrsh7th/cmp-emoji",
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-path",
      "L3MON4D3/LuaSnip",
      "saadparwaiz1/cmp_luasnip",
      "monkoose/neocodeium",
    },
    opts = function(_, opts)
      local cmp = require("cmp")
      local luasnip = require("luasnip")

      opts.snippet = {
        expand = function(args)
          luasnip.lsp_expand(args.body)
        end,
      }

      opts.mapping = cmp.mapping.preset.insert({
        ["<C-n>"] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Insert }),
        ["<C-p>"] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Insert }),
        ["<C-d>"] = cmp.mapping.scroll_docs(-4),
        ["<C-f>"] = cmp.mapping.scroll_docs(4),
        ["<C-Space>"] = cmp.mapping.complete(),
        ["<C-e>"] = cmp.mapping.abort(),
        ["<CR>"] = cmp.mapping.confirm({ select = true }),
        ["<Tab>"] = cmp.mapping(function(fallback)
          if cmp.visible() then
            cmp.select_next_item()
          elseif luasnip.expand_or_jumpable() then
            luasnip.expand_or_jump()
          else
            fallback()
          end
        end, { "i", "s" }),
        ["<S-Tab>"] = cmp.mapping(function(fallback)
          if cmp.visible() then
            cmp.select_prev_item()
          elseif luasnip.jumpable(-1) then
            luasnip.jump(-1)
          else
            fallback()
          end
        end, { "i", "s" }),
      })

      opts.sources = cmp.config.sources({
        { name = "neocodeium" },
        { name = "nvim_lsp" },
        { name = "luasnip" },
        { name = "buffer", keyword_length = 3 },
        { name = "path" },
        { name = "emoji" },
      })
    end,
  },

  -- ============================================================
  -- NeoCodeium
  -- ============================================================
  {
    "monkoose/neocodeium",
    event = "BufEnter",
    config = function()
      require("neocodeium").setup()
      vim.keymap.set("i", "<C-g>", function()
        require("neocodeium").accept()
      end, { silent = true, desc = "NeoCodeium Accept" })
      vim.keymap.set("i", "<M-]>", function()
        require("neocodeium").cycle(1)
      end, { silent = true, desc = "NeoCodeium Next" })
      vim.keymap.set("i", "<M-[>", function()
        require("neocodeium").cycle(-1)
      end, { silent = true, desc = "NeoCodeium Prev" })
      vim.keymap.set("i", "<C-x>", function()
        require("neocodeium").clear()
      end, { silent = true, desc = "NeoCodeium Dismiss" })
    end,
  },

  -- ============================================================
  -- Treesitter
  -- ============================================================
  {
    "nvim-treesitter/nvim-treesitter",
    opts = {
      ensure_installed = {
        "lua",
        "vim",
        "vimdoc",
        "typescript",
        "tsx",
        "javascript",
        "json",
        "html",
        "css",
        "php",
        "php_only",
        "twig",
        "bash",
        "markdown",
        "markdown_inline",
        "sql",
      },
    },
  },

}
