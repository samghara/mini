return {
    source = "https://github.com/neovim/nvim-lspconfig",
    depends = {
        "https://github.com/williamboman/mason.nvim",
        "https://github.com/hrsh7th/cmp-nvim-lsp",
    },
    config = function()
        Core.setHighlights {
            ["DiagnosticError"]          = { fg = C.DRed },
            ["DiagnosticUnderlineWarn"]  = { fg = C.Yellow, ui = S.Underline },
            ["DiagnosticUnderlineError"] = { fg = C.DRed,   ui = S.Underline },
        }

        Core.linkHighlights {
            ["LspInlayHint"] = "Comment",
        }

        Core.createAutoCommand("FileType", "qf", function ()
            local bn = vim.fn.bufnr("%")
            local OpenAndCloseQF = string.format("<CR><Cmd>%dbdelete<CR>", bn)
            Core.setKeyMaps {
                { "n", "<CR>", OpenAndCloseQF, { buffer = bn } },
                { "n",  "o",   OpenAndCloseQF, { buffer = bn } },
                { "n",  "j",   "j<CR><C-w>j",  { buffer = bn } },
                { "n",  "k",   "k<CR><C-w>j",  { buffer = bn } },
            }
        end)

        -- Core.setKeyMaps {
        --     {
        --         "n", "<leader>le", vim.diagnostic.open_float,
        --         { desc = "LSP: Show diagnostics in a floating window" }
        --     },
        --     {
        --         "n", "<leader>ln", vim.diagnostic.goto_next,
        --         { desc = "LSP: Move to the next diagnostic" }
        --     },
        --     {
        --         "n", "<leader>lp", vim.diagnostic.goto_prev,
        --         { desc = "LSP: Move to the prev diagnostic" }
        --     },
        --     {
        --         "n", "<leader>ll", vim.diagnostic.setloclist,
        --         { desc = "LSP: Add buffer diagnostics to the location list" }
        --     },
        -- }

        Core.createAutoCommand("LspAttach", nil, function(ev)
            -- local client = vim.lsp.get_client_by_id(ev.data.client_id)
            -- if client and client.server_capabilities.inlayHintProvider then
            --     vim.lsp.inlay_hint.enable(true)
            -- end

            vim.bo[ev.buf].omnifunc = "v:lua.vim.lsp.omnifunc"
            Core.setKeyMaps {
                {
                    "n", "gd", vim.lsp.buf.definition,
                    { buffer = ev.buf, desc = "LSP: Jumps to the definition" }
                },
                {
                    "n", "gD", vim.lsp.buf.declaration,
                    { buffer = ev.buf, desc = "LSP: Jumps to the declaration" }
                },
                {
                    "n", "gr", vim.lsp.buf.references,
                    { buffer = ev.buf, desc = "LSP: List all the references" }
                },
                -- {
                --     { "n", "v" }, "<leader>la", vim.lsp.buf.code_action,
                --     { buffer = ev.buf, desc = "LSP: Code Action" }
                -- },
                -- {
                --     "n", "<leader>rn", vim.lsp.buf.rename,
                --     { buffer = ev.buf, desc = "LSP: Renames all references" }
                -- },
                {
                    { "n", "v" }, "<M-F>", function() vim.lsp.buf.format { async = true } end,
                    { buffer = ev.buf, desc = "LSP: Formats a buffer" }
                }
            }
        end)

        local lspconfig = require("lspconfig")
        local capabilities = require("cmp_nvim_lsp").default_capabilities()

        -- gopls
        lspconfig.gopls.setup { capabilities = capabilities }
        lspconfig.gopls.setup {
            settings = {
                gopls = {
                    gofumpt = true,
                    usePlaceholders = true,
                    completeUnimported = true,
                }
            }
        }

        -- clangd
        lspconfig.clangd.setup { capabilities = capabilities }
        lspconfig.clangd.setup {
            cmd = { "clangd", "--clang-tidy" },
            init_options = {
                clangdFileStatus = true,
                usePlaceholders = true,
                completeUnimported = true,
                semanticHighlighting = false,
                snippetSupport = false,
            },
            settings = {}
        }

        -- rust-analyzer
        -- https://www.andersevenrud.net/neovim.github.io/lsp/configurations/rust_analyzer/
        lspconfig.rust_analyzer.setup { capabilities = capabilities }
        lspconfig.rust_analyzer.setup {
            settings = {
                ["rust-analyzer"] = {
                    -- cargo = { allFeatures = true }
                    checkOnSave = {
                        enable = true,
                        allFeatures = true,
                        command = "clippy",
                        extraArgs = { "--no-deps" },
                    },
                    procMacro = {
                        enable = true,
                        ignored = {
                            ["async-trait"] = { "async_trait" },
                            ["napi-derive"] = { "napi" },
                            ["async-recursion"] = { "async_recursion" },
                        },
                    },
                }
            }
        }

        -- lua-language-server
        lspconfig.lua_ls.setup { capabilities = capabilities }
        lspconfig.lua_ls.setup {
            settings = {
                Lua = {
                    semantic = { enable = false },
                    runtime = { version = "LuaJIT" },
                    workspace = {
                        checkThirdParty = false,
                        library = { vim.env.VIMRUNTIME }
                    }
                }
            }
        }

        -- cmake-language-server
        lspconfig.cmake.setup { capabilities = capabilities }
        lspconfig.cmake.setup {
            settings = {}
        }

        -- jsonls
        lspconfig.jsonls.setup { capabilities = capabilities }
        lspconfig.jsonls.setup {
            cmd = { "vscode-json-language-server", "--stdio" },
            filetypes = { "json" },
            init_options = { provideFormatter = true },
            single_file_support = true
        }
    end
}
