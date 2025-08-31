local lazy = require("lazy")
-- since this is just an example spec, don't actually load anything here and return an empty spec
-- stylua: ignore
-- if true then return {} end

-- every spec file under the "plugins" directory will be loaded automatically by lazy.nvim
--
-- In your plugin files, you can:
-- * add extra plugins
-- * disable/enabled LazyVim plugins
-- * override the configuration of LazyVim plugins
return {
  -- add gruvbox
{
  "ellisonleao/gruvbox.nvim",
  priority = 1000, -- Высокий приоритет для загрузки первым
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
      }
    })
    -- Установка цветовой схемы
    -- vim.cmd("colorscheme gruvbox")
  end
},

{
  "tokyonight.nvim",
  opts = {
    transparent = true,
    styles = {
      sidebars = "transparent",
      floats = "transparent",
    },
    on_colors = function(colors)
      -- Кастомные цвета можно настроить здесь
      -- colors.bg = "#1a1b26"  -- пример изменения фона
    end,
    on_highlights = function(hl, colors)
      -- Treesitter highlights
      hl["@function"] = { italic = true, fg = colors.blue }
      hl["@function.builtin"] = { italic = true, fg = colors.blue1 }
      hl["@function.call"] = { italic = true, fg = colors.blue }
      hl["@method"] = { italic = true, fg = colors.blue }
      hl["@method.call"] = { italic = true, fg = colors.blue }
      hl["@constructor"] = { italic = true, bold = true, fg = colors.orange }
      
      -- LSP semantic tokens
      hl["@lsp.type.function"] = { italic = true, fg = colors.blue }
      hl["@lsp.type.method"] = { italic = true, fg = colors.blue }
      hl["@lsp.type.class"] = { bold = true, fg = colors.yellow }
      hl["@lsp.type.interface"] = { italic = true, bold = true, fg = colors.yellow }
      hl["@lsp.type.enum"] = { fg = colors.purple }
      hl["@lsp.type.struct"] = { fg = colors.orange }
      hl["@lsp.type.typeParameter"] = { italic = true, fg = colors.teal }
      
      -- Ключевые слова и параметры
      hl["@keyword"] = { italic = true, fg = colors.magenta }
      hl["@keyword.function"] = { italic = true, fg = colors.magenta }
      hl["@keyword.operator"] = { fg = colors.magenta2 }
      hl["@keyword.return"] = { italic = true, fg = colors.magenta }
      hl["@parameter"] = { italic = true, fg = colors.fg }
      hl["@parameter.reference"] = { italic = true, fg = colors.fg }
      
      -- Переменные и константы
      hl["@variable"] = { bold = true, fg = colors.blue1 }
      hl["@variable.builtin"] = { bold = true, italic = true, fg = colors.orange }
      hl["@variable.member"] = { fg = colors.fg }
      hl["@variable.parameter"] = { italic = true, fg = colors.fg }
      hl["@constant"] = { bold = true, fg = colors.purple }
      hl["@constant.builtin"] = { bold = true, italic = true, fg = colors.purple }
      hl["@constant.macro"] = { bold = true, fg = colors.purple }
      
      -- Типы и структуры
      hl["@type"] = { fg = colors.yellow }
      hl["@type.builtin"] = { fg = colors.yellow }
      hl["@type.definition"] = { fg = colors.yellow }
      hl["@type.qualifier"] = { italic = true, fg = colors.yellow }
      hl["@storageclass"] = { italic = true, fg = colors.magenta }
      hl["@structure"] = { fg = colors.yellow }
      
      -- Строки и текстовые элементы
      hl["@string"] = { fg = colors.green }
      hl["@string.regex"] = { fg = colors.cyan }
      hl["@string.escape"] = { fg = colors.cyan }
      hl["@string.special"] = { fg = colors.green }
      hl["@character"] = { fg = colors.green }
      hl["@character.special"] = { fg = colors.green }
      
      -- Числа и булевы значения
      hl["@number"] = { fg = colors.orange }
      hl["@number.float"] = { fg = colors.orange }
      hl["@boolean"] = { bold = true, fg = colors.orange }
      
      -- Комментарии
      hl["@comment"] = { italic = true, fg = colors.comment }
      hl["@comment.documentation"] = { italic = true, fg = colors.comment }
      hl["@comment.error"] = { italic = true, fg = colors.error }
      hl["@comment.warning"] = { italic = true, fg = colors.warning }
      hl["@comment.todo"] = { italic = true, bold = true, fg = colors.info }
      hl["@comment.note"] = { italic = true, fg = colors.hint }
      
      -- Операторы и пунктуация
      hl["@operator"] = { fg = colors.fg }
      hl["@punctuation"] = { fg = colors.fg }
      hl["@punctuation.delimiter"] = { fg = colors.fg }
      hl["@punctuation.bracket"] = { fg = colors.fg }
      hl["@punctuation.special"] = { fg = colors.fg }
      
      -- Теги и атрибуты (для HTML/XML)
      hl["@tag"] = { fg = colors.blue }
      hl["@tag.attribute"] = { italic = true, fg = colors.cyan }
      hl["@tag.delimiter"] = { fg = colors.fg }
      
      -- Свойства и поля
      hl["@property"] = { fg = colors.cyan }
      hl["@field"] = { fg = colors.cyan }
      
      -- Namespace и модули
      hl["@namespace"] = { fg = colors.blue }
      hl["@module"] = { fg = colors.blue }
      
      -- Импорты и includes
      hl["@include"] = { fg = colors.magenta }
      
      -- Исключения и ошибки
      hl["@exception"] = { fg = colors.red }
      hl["@error"] = { fg = colors.error }
      
      -- Декораторы и аннотации
      hl["@decorator"] = { fg = colors.yellow }
      hl["@annotation"] = { fg = colors.yellow }
      
      -- Diff и изменения
      hl["@diff.plus"] = { fg = colors.git.add }
      hl["@diff.minus"] = { fg = colors.git.delete }
      hl["@diff.delta"] = { fg = colors.git.change }
    end
  }
},

  -- Configure LazyVim to load gruvbox
  {
    "LazyVim/LazyVim",
    opts = {
      -- colorscheme = "gruvbox",
      colorsheme = "tokyonight"
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
  { "folke/trouble.nvim", enabled = false },

  -- override nvim-cmp and add cmp-emoji
  {
    "hrsh7th/nvim-cmp",
    dependencies = { "hrsh7th/cmp-emoji" },
    ---@param opts cmp.ConfigSchema
    opts = function(_, opts)
      table.insert(opts.sources, { name = "emoji" })
    end,
  },

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

  -- add pyright to lspconfig
  {
    "neovim/nvim-lspconfig",
    ---@class PluginLspOpts
    opts = {
      ---@type lspconfig.options
      servers = {
        -- pyright will be automatically installed with mason and loaded with lspconfig
        pyright = {},
      },
    },
  },

  -- add tsserver and setup with typescript.nvim instead of lspconfig
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      "jose-elias-alvarez/typescript.nvim",
      init = function()
        require("lazyvim.util").lsp.on_attach(function(_, buffer)
          -- stylua: ignore
          vim.keymap.set( "n", "<leader>co", "TypescriptOrganizeImports", { buffer = buffer, desc = "Organize Imports" })
          vim.keymap.set("n", "<leader>cR", "TypescriptRenameFile", { desc = "Rename File", buffer = buffer })
        end)
      end,
    },
    ---@class PluginLspOpts
    opts = {
      ---@type lspconfig.options
      servers = {
        -- tsserver will be automatically installed with mason and loaded with lspconfig
        tsserver = {},
      },
      -- you can do any additional lsp server setup here
      -- return true if you don't want this server to be setup with lspconfig
      ---@type table<string, fun(server:string, opts:_.lspconfig.options):boolean?>
      setup = {
        -- example to setup with typescript.nvim
        tsserver = function(_, opts)
          require("typescript").setup({ server = opts })
          return true
        end,
        -- Specify * to use this function as a fallback for any server
        -- ["*"] = function(server, opts) end,
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
    opts = function(_, opts)
      -- add tsx and treesitter
      vim.list_extend(opts.ensure_installed, {
        "tsx",
        "typescript",
      })
    end,
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
    "williamboman/mason.nvim",
    opts = {
      ensure_installed = {
        "stylua",
        "shellcheck",
        "shfmt",
        "flake8",
      },
    },
  },


}
