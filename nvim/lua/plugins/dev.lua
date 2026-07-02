-- ============================================================
-- Theme
-- ============================================================
return {
  {
    "catppuccin/nvim",
    name = "catppuccin",
    priority = 1000,
    opts = {
      flavour = "latte",
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
    "rebelot/kanagawa.nvim",
    priority = 1000,
    opts = {
      compile = false,
      undercurl = true,
      commentStyle = { italic = true },
      functionStyle = {},
      keywordStyle = { italic = true },
      statementStyle = { bold = true },
      typeStyle = {},
      transparent = false,
      dimInactive = false,
      terminalColors = true,
      colors = {
        palette = {},
        theme = {
          wave = {},
          lotus = {},
          dragon = {},
          all = {},
        },
      },
    },
  },
  {
    "EdenEast/nightfox.nvim",
    priority = 1000,
    opts = {
      options = {
        compile_path = vim.fn.stdpath("cache") .. "/nightfox",
        compile_file_write = true,
        styles = {
          comments = "italic",
          functions = "NONE",
          keywords = "italic",
          statements = "NONE",
          types = "NONE",
          numbers = "NONE",
          strings = "NONE",
          variables = "NONE",
        },
        inverse = {
          match_paren = false,
          visual = false,
          search = false,
        },
      },
    },
  },
  {
    "LazyVim/LazyVim",
    opts = { colorscheme = "tokyonight" },
  },
  {
    "nvim-lualine/lualine.nvim",
    dependencies = { "folke/snacks.nvim" },
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
  -- Rust
  -- ============================================================
  { import = "lazyvim.plugins.extras.lang.rust" },

  -- ============================================================
  -- Java / Spring Boot
  -- ============================================================
  { import = "lazyvim.plugins.extras.lang.java" },

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
        "rust",
        "toml",
        "java",
      },
    },
  },

  -- ============================================================
  -- Disable redundant java-language-server (jdtls is used instead)
  -- ============================================================
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        java_language_server = { enabled = false },
      },
    },
  },
}
