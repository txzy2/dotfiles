return {
  {
    "ellisonleao/gruvbox.nvim",
    config = function()
      require("gruvbox").setup({
        overrides = {
          -- Treesitter highlights для функций и методов
          ["@function"] = { italic = true },
          ["@function.builtin"] = { italic = true },
          ["@method"] = { italic = true },
          ["@constructor"] = { italic = true, bold = true },
          -- LSP semantic tokens
          ["@lsp.type.function"] = { italic = true },
          ["@lsp.type.method"] = { italic = true },
          ["@lsp.type.class"] = { bold = true },
          ["@lsp.type.interface"] = { italic = true },
          -- Ключевые слова и параметры
          ["@keyword"] = { italic = true },
          ["@parameter"] = { italic = true },
          ["@comment"] = { italic = true },
          -- Переменные и константы
          ["@variable"] = { bold = true },
          ["@constant"] = { bold = true },
          ["@constant.builtin"] = { bold = true, italic = true },
        },
      })
      -- Установка цветовой схемы
      -- vim.cmd("colorscheme gruvbox")
    end,
  },

  {
    "folke/tokyonight.nvim",
    lazy = false,
    priority = 1000,
    opts = {},
  },

  { "rebelot/kanagawa.nvim" },

  {
    "catppuccin/nvim",
    name = "catppuccin",
    priority = 1000,
    opts = {
      flavour = "mocha",
      custom_highlights = function(colors)
        return {

          -- ❗ 1. Обычные переменные ($user, $data, $json)
          ["@php.variable"] = {
            fg = colors.lavender,
            italic = true,
          },

          -- ❗ 2. Суперглобальные ($_POST, $_GET, $_SERVER)
          ["@php.superglobal"] = {
            fg = colors.peach,
            bold = true,
          },

          -- ❗ 3. Свойства ($user['id'])
          ["@property"] = {
            fg = colors.green,
            bold = false,
          },

          -- ❗ 4. Ключи массива ('id', 'password')
          ["@string"] = {
            fg = colors.teal,
          },

          -- ❗ 5. Имена функций (validatePassword, sendError)
          ["@function"] = {
            fg = colors.blue,
            bold = true,
          },

          -- ❗ 6. Параметры функции ($user, $password внутри ())
          ["@parameter"] = {
            fg = colors.sky,
            italic = true,
          },

          -- ❗ 7. Классы и модели (Users_model, Roles_model)
          ["@type"] = {
            fg = colors.mauve,
            bold = true,
          },

          -- ❗ 8. Константы (true, false, null)
          ["@constant.builtin"] = {
            fg = colors.red,
            bold = true,
          },
        }
      end,
    },
  },

  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "catppuccin-mocha",
    },
  },

  { import = "lazyvim.plugins.extras.lang.rust" },
  { import = "lazyvim.plugins.extras.ai.codeium" },

  -- и при необходимости добавляем rustaceanvim
  {
    "mrcjkb/rustaceanvim",
    version = "^4",
    ft = "rust",
    opts = {
      server = {
        settings = {
          ["rust-analyzer"] = {
            checkOnSave = { command = "clippy" },
            cargo = { allFeatures = true },
          },
        },
      },
    },
  },

  -- change trouble config
  {
    "folke/trouble.nvim",
    -- opts will be merged with the parent spec
    opts = { use_diagnostic_signs = true },
  },

  -- disable trouble
  { "folke/trouble.nvim", enabled = true },

  -- change some telescope options and a keymap to browse plugin files
  {
    "nvim-telescope/telescope.nvim",
    keys = {
      -- add a keymap to browse plugin files
      -- stylua: ignore
      {
        "<leader>fp",
        function() require("telescope.builtin").find_files({ cwd = require("lazy.core.config").options.root }) end,
        desc = "Find Plugin File",
      },
    },
    -- change some options
    opts = {
      defaults = {
        layout_strategy = "horizontal",
        layout_config = { prompt_position = "top" },
        sorting_strategy = "ascending",
        winblend = 0,
      },
    },
  },

  -- for typescript, LazyVim also includes extra specs to properly setup lspconfig,
  -- treesitter, mason and typescript.nvim. So instead of the above, you can use:
  { import = "lazyvim.plugins.extras.lang.typescript" },

  -- add more treesitter parsers
  {
    "nvim-treesitter/nvim-treesitter",
    opts = {
      ensure_installed = {
        "bash",
        "html",
        "javascript",
        "json",
        "lua",
        "markdown",
        "markdown_inline",
        "python",
        "query",
        "regex",
        "tsx",
        "typescript",
        "vim",
        "yaml",
      },
    },
  },

  -- since `vim.tbl_deep_extend`, can only merge tables and not lists, the code above
  -- would overwrite `ensure_installed` with the new value.
  -- If you'd rather extend the default config, use the code below instead:
  {
    "nvim-treesitter/nvim-treesitter",
  },

  -- the opts function can also be used to change the default opts:
  {
    "nvim-lualine/lualine.nvim",
    event = "VeryLazy",
    opts = function(_, opts)
      table.insert(opts.sections.lualine_x, {
        function()
          return "😄"
        end,
      })
    end,
  },

  -- or you can return new options to override all the defaults
  {
    "nvim-lualine/lualine.nvim",
    event = "VeryLazy",
    opts = function()
      return {
        --[[add your custom lualine config here]]
      }
    end,
  },

  -- use mini.starter instead of alpha
  -- { import = "lazyvim.plugins.extras.ui.mini-starter" },

  -- add jsonls and schemastore packages, and setup treesitter for json, json5 and jsonc
  { import = "lazyvim.plugins.extras.lang.json" },

  -- add any tools you want to have installed below
  {
    "mason-org/mason.nvim",
    opts = {
      ensure_installed = {
        "stylua",
        "shellcheck",
        "shfmt",
        "flake8",
      },
    },
  },

  {
    "fei6409/log-highlight.nvim",
    config = true,
  },
  { "nvim-treesitter/nvim-treesitter", build = ":TSUpdate" },
  {
    "mfussenegger/nvim-lint",
    config = function()
      require("lint").linters_by_ft = {
        python = { "flake8" },
      }
    end,
  },
}
