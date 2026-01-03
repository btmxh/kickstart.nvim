return {
  { -- Autocompletion
    'saghen/blink.cmp',
    event = 'VimEnter',
    version = '1.*',
    dependencies = {
      -- Snippet Engine
      {
        'L3MON4D3/LuaSnip',
        build = (function()
          -- Build Step is needed for regex support in snippets.
          -- This step is not supported in many windows environments.
          -- Remove the below condition to re-enable on windows.
          if vim.fn.has 'win32' == 1 or vim.fn.executable 'make' == 0 then
            return
          end
          return 'make install_jsregexp'
        end)(),
        dependencies = {
          -- `friendly-snippets` contains a variety of premade snippets.
          --    See the README about individual language/framework/plugin snippets:
          --    https://github.com/rafamadriz/friendly-snippets
          {
            'rafamadriz/friendly-snippets',
            config = function()
              require('luasnip.loaders.from_vscode').lazy_load()
            end,
          },
          -- {
          --   'kaarmu/typst.vim',
          --   ft = 'typst',
          --   lazy = false,
          --   config = function()
          --     vim.g.typst_conceal = 1
          --   end
          -- }
        },
        opts = {
          history = true, -- keep around last snippet local to jump back
          enable_autosnippets = true,
          store_selection_keys = "<Tab>",
        },
        config = function(_, opts)
          require("luasnip").setup(opts)
          require("luasnip.loaders.from_lua").lazy_load({ paths = { "./LuaSnip" } })
        end,
        keys = {
          {
            "<C-K>",
            function()
              require("luasnip").expand()
            end,
            silent = true,
            mode = "i"
          },
          {
            "<C-L>",
            function()
              require("luasnip").jump(1)
            end,
            silent = true,
            mode = { "i", "s" }
          },
          {
            "<C-J>",
            function()
              require("luasnip").jump(-1)
            end,
            silent = true,
            mode = { "i", "s" }
          },
          {
            "<C-E>",
            function()
              local ls = require("luasnip")
              if ls.choice_active() then
                ls.change_choice(1)
              end
            end,
            silent = true,
            mode = { "i", "s" },
          },
        },
      },
      'folke/lazydev.nvim',
      'fang2hou/blink-copilot',
      -- 'milanglacier/minuet-ai.nvim'
    },
    --- @module 'blink.cmp'
    --- @type blink.cmp.Config
    opts = {
      keymap = {
        preset = 'none',
        ['<C-space>'] = { 'show', 'show_documentation', 'hide_documentation' },
        ['<C-n>'] = { 'select_next' },
        ['<C-p>'] = { 'select_prev' },
        ['<C-y>'] = { 'select_and_accept' },
        ['<C-e>'] = { 'cancel' },
      },

      appearance = {
        -- 'mono' (default) for 'Nerd Font Mono' or 'normal' for 'Nerd Font'
        -- Adjusts spacing to ensure icons are aligned
        nerd_font_variant = 'normal',
      },

      completion = {
        -- By default, you may press `<c-space>` to show the documentation.
        -- Optionally, set `auto_show = true` to show the documentation after a delay.
        documentation = { auto_show = false, auto_show_delay_ms = 500 },
        trigger = { prefetch_on_insert = false }
      },

      sources = {
        default = { 'lsp', 'path', 'snippets', 'lazydev', 'copilot' },
        providers = {
          lazydev = { module = 'lazydev.integrations.blink' },
          copilot = {
            name = "copilot",
            module = "blink-copilot",
            async = true,
          },
          -- minuet = {
          --   name = 'minuet',
          --   module = 'minuet.blink',
          --   async = true,
          --   timeout_ms = 3000,
          --   score_offset = 50,
          -- }
        },
      },

      snippets = { preset = 'luasnip' },

      -- Blink.cmp includes an optional, recommended rust fuzzy matcher,
      -- which automatically downloads a prebuilt binary when enabled.
      --
      -- By default, we use the Lua implementation instead, but you may enable
      -- the rust implementation via `'prefer_rust_with_warning'`
      --
      -- See :h blink-cmp-config-fuzzy for more information
      fuzzy = { implementation = 'lua' },

      -- Shows a signature help window while you type arguments for a function
      signature = { enabled = true },
    },
  },
}
-- vim: ts=2 sts=2 sw=2 et
