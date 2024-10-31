---
-- Config lsp
---
local lsp_zero = require("lsp-zero")

local lsp_attach = function(_, bufnr)
  local opts = { buffer = bufnr }

  vim.keymap.set("n", "K", "<cmd>lua vim.lsp.buf.hover()<cr>", opts)
  vim.keymap.set("n", "gd", "<cmd>lua vim.lsp.buf.definition()<cr>", opts)
  vim.keymap.set("n", "gD", "<cmd>lua vim.lsp.buf.declaration()<cr>", opts)
  vim.keymap.set("n", "gi", "<cmd>lua vim.lsp.buf.implementation()<cr>", opts)
  vim.keymap.set("n", "go", "<cmd>lua vim.lsp.buf.type_definition()<cr>", opts)
  vim.keymap.set("n", "gr", "<cmd>lua vim.lsp.buf.references()<cr>", opts)
  vim.keymap.set("n", "gs", "<cmd>lua vim.lsp.buf.signature_help()<cr>", opts)
  vim.keymap.set("n", "<F2>", "<cmd>lua vim.lsp.buf.rename()<cr>", opts)
  vim.keymap.set({ "n", "x" }, "<F3>", "<cmd>lua vim.lsp.buf.format({async = true})<cr>", opts)
  vim.keymap.set("n", "<F4>", "<cmd>lua vim.lsp.buf.code_action()<cr>", opts)
end

lsp_zero.extend_lspconfig({
  sign_text = true,
  lsp_attach = lsp_attach,
  capabilities = require("cmp_nvim_lsp").default_capabilities(),
})

---
-- Install lsp servers
---
require("mason").setup({})
require("mason-lspconfig").setup({
  ensure_installed = {
    "lua_ls",
    "intelephense",
    "docker_compose_language_service",
    "dockerls",
    "pyright",
    "vtsls",

    -- Vetur - Vue 2
    "vuels",
    -- Volar - Vue 3
    -- "volar",
  },
  handlers = {
    function(server_name)
      require("lspconfig")[server_name].setup({})
    end,

    vtsls = function()
      require("lspconfig").vtsls.setup({
        commands = {
          OrganizeImports = {
            function()
              local param = {
                command = "typescript.organizeImports",
                arguments = { vim.api.nvim_buf_get_name(0) },
                title = "Organize imports !!!",
              }
              vim.lsp.buf.execute_command(param)
            end,
            description = "Organize imports",
          },
        },
      })
    end,

    -- Activar cuando se va a usar volar con vue 3
    -- vtsls = function()
    --   local lspconfig = require('lspconfig')
    --   local mason_registry = require("mason-registry")
    --   local vue_language_server_path = mason_registry.get_package("vue-language-server"):get_install_path()
    --       .. "/node_modules/@vue/language-server"

    --   lspconfig.vtsls.setup({
    --     settings = {
    --       vtsls = {
    --         tsserver = {
    --           globalPlugins = {
    --             {
    --               name = "@vue/typescript-plugin",
    --               location = vue_language_server_path,
    --               languages = { "vue" },
    --               configNamespace = "typescript",
    --               enableForWorkspaceTypeScriptVersions = true,
    --             },
    --           },
    --         },
    --       },
    --     },
    --     filetypes = { "typescript", "javascript", "javascriptreact", "typescriptreact", "vue" },
    --   })
    -- end,
  },
})

vim.keymap.set("n", "<leader>co", ":OrganizeImports<CR>", { desc = "Organize imports", silent = true })

---
-- Formatters and linters
---
local mason_tool_installer = require("mason-tool-installer")
mason_tool_installer.setup({
  ensure_installed = {
    "black", -- python formatter
    "eslint_d", -- js linter
    "isort", -- python formatter
    "php-cs-fixer", -- php formatter
    "prettierd", -- prettier formatter
    "pretty-php", -- php formatter
    "pylint", -- python linter
    "sql-formatter", -- sql
    "stylua", -- lua formatter
  },
})

---
-- Lua snip
---
local luasnip = require("luasnip")
local types = require("luasnip.util.types")

luasnip.config.set_config({
  -- This tells LuaSnip to remember to keep around the last snippet.
  -- You can jump back into even if you move outside of the selection
  history = true,

  -- This one is cool cause if you have dynamic snippets, it updatesas you type!
  updateevents = "TextChanged,TextChangedI",

  -- Autosnippets:
  enable_autosnippets = true,

  ext_opts = {
    [types.choiceNode] = {
      active = {
        virt_text = { { "<- Choice", "Error" } },
      },
    },
  },
})

-- <c-k> is my expansion key
-- this will expand the current item or jump to the next item within the snippet.
vim.keymap.set({ "i", "s" }, "<c-k>", function()
  if luasnip.expand_or_jumpable() then
    luasnip.expand_or_jump()
  end
end, { silent = true })

-- <c-j> is my jump backwards key.
-- this always moves to the previous item within the snippet
vim.keymap.set({ "i", "s" }, "<c-j>", function()
  if luasnip.jumpable(-1) then
    luasnip.jump(-1)
  end
end, { silent = true })

-- <c-l> is selecting within a list of options.
-- This is useful for choice nodes (introduced in the forthcoming episode 2)
vim.keymap.set("i", "<c-l>", function()
  if luasnip.choice_active() then
    luasnip.change_choice(1)
  end
end)

---
-- Autocompletion setup
---
local cmp = require("cmp")
local cmp_window = require("cmp.config.window")
local neogen = require("neogen")

-- `/` cmdline setup.
cmp.setup.cmdline("/", {
  mapping = cmp.mapping.preset.cmdline(),
  sources = {
    { name = "buffer" },
  },
})

-- `:` cmdline setup.
cmp.setup.cmdline(":", {
  mapping = cmp.mapping.preset.cmdline(),
  sources = cmp.config.sources({
    { name = "path" },
  }, {
    {
      name = "cmdline",
      option = {
        ignore_cmds = { "Man", "!" },
      },
    },
  }),
})

local kind_icons = {
  Text = "󰉿",
  Method = "󰆧",
  Function = "󰊕",
  Constructor = "",
  Field = "󰜢",
  Variable = "󰀫",
  Class = "󰠱",
  Interface = "",
  Module = "",
  Property = "󰜢",
  Unit = "󰑭",
  Value = "󰎠",
  Enum = "",
  Keyword = "󰌋",
  Snippet = "",
  Color = "󰏘",
  File = "󰈙",
  Reference = "󰈇",
  Folder = "󰉋",
  EnumMember = "",
  Constant = "󰏿",
  Struct = "󰙅",
  Event = "",
  Operator = "󰆕",
  TypeParameter = "",
}

cmp.setup({
  window = {
    completion = cmp_window.bordered(),
    documentation = cmp_window.bordered(),
  },
  formatting = {
    format = function(entry, vim_item)
      -- Kind icons
      vim_item.kind = string.format("%s %s", kind_icons[vim_item.kind], vim_item.kind) -- This concatenates the icons with the name of the item kind
      -- Source
      vim_item.menu = ({
        buffer = "[Buffer]",
        nvim_lsp = "[LSP]",
        luasnip = "[LuaSnip]",
        nvim_lua = "[Lua]",
        latex_symbols = "[LaTeX]",
      })[entry.source.name]
      return vim_item
    end,
  },
  mapping = cmp.mapping.preset.insert({
    ["<C-b>"] = cmp.mapping.scroll_docs(-4),
    ["<C-f>"] = cmp.mapping.scroll_docs(4),
    ["<C-Space>"] = cmp.mapping.complete(),
    ["<C-e>"] = cmp.mapping.abort(),

    -- https://github.com/hrsh7th/nvim-cmp/wiki/Example-mappings#luasnip
    ["<CR>"] = cmp.mapping(function(fallback)
      if cmp.visible() then
        if luasnip.expandable() then
          luasnip.expand()
        else
          cmp.confirm({
            select = true,
          })
        end
      else
        fallback()
      end
    end),

    ["<Tab>"] = cmp.mapping(function(fallback)
      if neogen.jumpable() then
        neogen.jump_next()
      elseif cmp.visible() then
        cmp.select_next_item()
      elseif luasnip.locally_jumpable(1) then
        luasnip.jump(1)
      else
        fallback()
      end
    end, { "i", "s" }),

    ["<S-Tab>"] = cmp.mapping(function(fallback)
      if neogen.jumpable(true) then
        neogen.jump_prev()
      elseif cmp.visible() then
        cmp.select_prev_item()
      elseif luasnip.locally_jumpable(-1) then
        luasnip.jump(-1)
      else
        fallback()
      end
    end, { "i", "s" }),
  }),
  sources = {
    { name = "nvim_lsp" },
    { name = "path" },
    { name = "luasnip" },
    { name = "buffer" },
  },
  snippet = {
    expand = function(args)
      luasnip.lsp_expand(args.body)
    end,
  },
})
