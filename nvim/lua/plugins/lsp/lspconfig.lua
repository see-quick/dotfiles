return {
  "neovim/nvim-lspconfig",
  event = { "BufReadPre", "BufNewFile" },
  dependencies = {
    -- remove cmp-nvim-lsp in favor of coq_nvim
    { "antosha417/nvim-lsp-file-operations", config = true },
    { "folke/neodev.nvim", opts = {} },
  },
  config = function()
    -- import lspconfig plugin
    local lspconfig = require("lspconfig")
    -- Register Quint as a custom server
    local configs = require("lspconfig.configs")
    -- Import coq
    local coq = require("coq")

    if not configs.quint then
      configs.quint = {
      default_config = {
        cmd = { "quint-language-server", "--stdio" }, -- Start Quint LSP
        filetypes = { "quint" },
          root_dir = function(fname)
          return vim.fs.dirname(fname)
        end,
        single_file_support = true,
      },
    }
    end

    -- ✅ Now setup Quint LSP with COQ (autocomplete)
    lspconfig.quint.setup({
      cmd = { "quint-language-server", "--stdio" },
      filetypes = { "quint" },
      root_dir = function(fname)
        return vim.fs.dirname(fname)
      end,
    })

    -- import mason_lspconfig plugin
    local mason_lspconfig = require("mason-lspconfig")

    local keymap = vim.keymap -- for conciseness

    vim.api.nvim_create_autocmd("LspAttach", {
      group = vim.api.nvim_create_augroup("UserLspConfig", {}),
      callback = function(ev)
        -- Buffer local mappings.
        local opts = { buffer = ev.buf, silent = true }

        -- set keybinds
        opts.desc = "Show LSP references"
        keymap.set("n", "gR", "<cmd>Telescope lsp_references<CR>", opts)

        opts.desc = "Go to declaration"
        keymap.set("n", "gD", vim.lsp.buf.declaration, opts)

        opts.desc = "Show LSP definitions"
        keymap.set("n", "gd", "<cmd>Telescope lsp_definitions<CR>", opts)

        opts.desc = "Show LSP implementations"
        keymap.set("n", "gi", "<cmd>Telescope lsp_implementations<CR>", opts)

        opts.desc = "Show LSP type definitions"
        keymap.set("n", "gt", "<cmd>Telescope lsp_type_definitions<CR>", opts)

        opts.desc = "See available code actions"
        keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, opts)

        opts.desc = "Smart rename"
        keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)

        opts.desc = "Show buffer diagnostics"
        keymap.set("n", "<leader>D", "<cmd>Telescope diagnostics bufnr=0<CR>", opts)

        opts.desc = "Show line diagnostics"
        keymap.set("n", "<leader>d", vim.diagnostic.open_float, opts)

        opts.desc = "Go to previous diagnostic"
        keymap.set("n", "[d", vim.diagnostic.goto_prev, opts)

        opts.desc = "Go to next diagnostic"
        keymap.set("n", "]d", vim.diagnostic.goto_next, opts)

        opts.desc = "Show documentation for what is under cursor"
        keymap.set("n", "K", vim.lsp.buf.hover, opts)

        opts.desc = "Restart LSP"
        keymap.set("n", "<leader>rs", ":LspRestart<CR>", opts)
      end,
    })

    -- Change the Diagnostic symbols in the sign column (gutter)
    local signs = { Error = " ", Warn = " ", Hint = "󰠠 ", Info = " " }
    for type, icon in pairs(signs) do
      local hl = "DiagnosticSign" .. type
      vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
    end

    mason_lspconfig.setup_handlers({
      -- default handler for installed servers
      function(server_name)
        lspconfig[server_name].setup(coq.lsp_ensure_capabilities({}))
      end,
      ["svelte"] = function()
        -- configure svelte server
        lspconfig["svelte"].setup(coq.lsp_ensure_capabilities({
          on_attach = function(client, bufnr)
            vim.api.nvim_create_autocmd("BufWritePost", {
              pattern = { "*.js", "*.ts" },
              callback = function(ctx)
                client.notify("$/onDidChangeTsOrJsFile", { uri = ctx.match })
              end,
            })
          end,
        }))
      end,
      ["graphql"] = function()
        -- configure graphql language server
        lspconfig["graphql"].setup(coq.lsp_ensure_capabilities({
          filetypes = { "graphql", "gql", "svelte", "typescriptreact", "javascriptreact" },
        }))
      end,
      ["emmet_ls"] = function()
        -- configure emmet language server
        lspconfig["emmet_ls"].setup(coq.lsp_ensure_capabilities({
          filetypes = { "html", "typescriptreact", "javascriptreact", "css", "sass", "scss", "less", "svelte" },
        }))
      end,
      ["lua_ls"] = function()
        -- configure lua server (with special settings)
        lspconfig["lua_ls"].setup(coq.lsp_ensure_capabilities({
          settings = {
            Lua = {
              diagnostics = {
                globals = { "vim" },
              },
              completion = {
                callSnippet = "Replace",
              },
            },
          },
        }))
      end,
      -- Add the asm-lsp configuration
      ["asm_lsp"] = function()
        lspconfig["asm_lsp"].setup(coq.lsp_ensure_capabilities({
          filetypes = { "asm", "s" },
          root_dir = function(fname)
            return vim.fs.dirname(fname)
          end,
        }))
      end,
    })

 end,
}

