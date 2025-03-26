return {
    {
        "neovim/nvim-lspconfig",
        lazy = false,
        priority = 800,
        dependencies = {
            "b0o/schemastore.nvim",
            "williamboman/mason.nvim",
            "williamboman/mason-lspconfig.nvim",
            "neovim/nvim-lspconfig",
            "hrsh7th/nvim-cmp",
            "hrsh7th/cmp-nvim-lsp",
            "hrsh7th/cmp-buffer",
            "hrsh7th/cmp-path",
            "petertriho/cmp-git",
            "hrsh7th/cmp-nvim-lua",
            "saadparwaiz1/cmp_luasnip",
            {
                'L3MON4D3/LuaSnip',
                version = 'v2.*',
                build = 'make install_jsregexp'
            },
        },
        config = function()
            local mason = require("mason")
            local mason_config = require("mason-lspconfig")
            local lspconfig = require("lspconfig")
            local cmp_lsp = require("cmp_nvim_lsp")
            local capabilities = cmp_lsp.default_capabilities()

            vim.diagnostic.config({
                underline = true,
                update_in_insert = false,
                severity_sort = true,
                virtual_text = {
                    spacing = 4,
                    source = "if_many",
                    prefix = "●",
                },
                signs = {
                    text = {
                        [vim.diagnostic.severity.ERROR] = "",
                        [vim.diagnostic.severity.WARN] = "",
                        [vim.diagnostic.severity.HINT] = "",
                        [vim.diagnostic.severity.INFO] = "",
                    },
                },
                -- float = {},
            })

            mason.setup({})
            mason_config.setup({
                ensure_installed = {
                    "gopls",
                    "rust_analyzer",
                    "lua_ls",
                    "jsonls",
                    "yamlls",
                },
                automatic_installation = false,
                handlers = {
                    function (server_name)
                        lspconfig[server_name].setup({
                            capabilities = capabilities
                        })
                    end,
                    gopls = function ()
                        lspconfig.gopls.setup({
                            capabilities = capabilities,
                            settings = {
                                gopls = {
                                    experimentalPostfixCompletions = true,
                                    templateExtensions = { "gotmpl" },
                                    codelenses = {
                                        gc_details = true,
                                    },
                                    usePlaceholders = true,
                                    analyses = {
                                        unusedparams = true,
                                        shadow = true,
                                        unusedvariable = true,
                                        useany = true,
                                    },
                                    staticcheck = true,
                                    vulncheck = "Imports",
                                    hints = {
                                        assignVariableTypes = true,
                                        compositeLiteralFields = true,
                                        compositeLiteralTypes = true,
                                        constantValues = true,
                                        functionTypeParameters = true,
                                        parameterNames = true,
                                        rangeVariableTypes = true,
                                    },

                                },
                            },
                            init_options = {
                                usePlaceholders = true,
                            },
                        })
                    end,
                    rust_analyzer = function ()
                        lspconfig.rust_analyzer.setup({
                            capabilities = capabilities,
                            settings = {
                                ['rust-analyzer'] = {
                                    cargo = {
                                        allFeatures = true,
                                    },
                                    imports = {
                                        group = {
                                            enable = false,
                                        },
                                    },
                                    completion = {
                                        postfix = {
                                            enable = false,
                                        },
                                    },
                                },
                            },
                        })
                    end,
                    lua_ls = function ()
                        lspconfig.lua_ls.setup({
                            capabilities = capabilities,
                            settings = {
                                Lua = {
                                    runtime = { version = "Lua 5.1" },
                                    diagnostics = {
                                        globals = { "bit", "vim", "it", "describe", "before_each", "after_each" },
                                    }
                                }
                            },
                        })
                    end,
                    jsonls = function ()
                        lspconfig.jsonls.setup({
                            capabilities = capabilities,
                            settings = {
                                json = {
                                    schemas = require("schemastore").json.schemas(),
                                    validate = { enable = true },
                                },
                            },
                        })
                    end,
                    yamlls = function ()
                        lspconfig.yamlls.setup({
                            capabilities = capabilities,
                            settings = {
                                yaml = {
                                    schemaStore = {
                                        enable = false,
                                        url = "",
                                    },
                                    schemas = require("schemastore").yaml.schemas(),
                                },
                            },
                        })
                    end,
                },
            })

            -- Global mappings.
            -- See `:help vim.diagnostic.*` for documentation on any of the below functions
            vim.keymap.set("n", "<space>m", vim.cmd.Mason, { desc = "open mason" })
            vim.keymap.set("n", "<space>cd", vim.diagnostic.open_float, { desc = "open diagnostics" })
            -- TODO: move to trouble?
            -- vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, { desc = "previous diagnostic" })
            -- vim.keymap.set("n", "]d", vim.diagnostic.goto_next, { desc = "next diagnostic" })
            vim.keymap.set("n", "<space>q", vim.diagnostic.setloclist, { desc = "add diagnostics to location list" })

            -- Use LspAttach autocommand to only map the following keys
            -- after the language server attaches to the current buffer
            vim.api.nvim_create_autocmd("LspAttach", {
                group = vim.api.nvim_create_augroup("UserLspConfig", {}),
                callback = function(ev)
                    -- Enable completion triggered by <c-x><c-o>
                    vim.bo[ev.buf].omnifunc = "v:lua.vim.lsp.omnifunc"
                    local client = vim.lsp.get_client_by_id(ev.data.client_id)
                    if client.server_capabilities.inlayHintProvider then
                        vim.lsp.inlay_hint.enable()
                    end

                    -- Buffer local mappings.
                    -- See `:help vim.lsp.*` for documentation on any of the below functions
                    vim.keymap.set("n", "gD", vim.lsp.buf.declaration, { buffer = ev.buf, desc = "go to declaration" })
                    vim.keymap.set("n", "gd", vim.lsp.buf.definition, { buffer = ev.buf, desc = "go to definition" })
                    vim.keymap.set("n", "K", vim.lsp.buf.hover, { buffer = ev.buf, desc = "show hover docs" })
                    vim.keymap.set("n", "gi", vim.lsp.buf.implementation, { buffer = ev.buf, desc = "go to implementation" })
                    vim.keymap.set("n", "<C-k>", vim.lsp.buf.signature_help, { buffer = ev.buf, desc = "show signature help" })
                    vim.keymap.set("n", "<space>wa", vim.lsp.buf.add_workspace_folder, { buffer = ev.buf, desc = "add folder to workspace" })
                    vim.keymap.set("n", "<space>wr", vim.lsp.buf.remove_workspace_folder, { buffer = ev.buf, desc = "remove folder from workspace" })
                    vim.keymap.set("n", "<space>D", vim.lsp.buf.type_definition, { buffer = ev.buf, desc = "go to type definition" })
                    vim.keymap.set("n", "gr", vim.lsp.buf.references, { buffer = ev.buf, desc = "list references" })
                    vim.keymap.set({ "n", "v" }, "<space>ca", vim.lsp.buf.code_action, { buffer = ev.buf, desc = "code actions" })
                    vim.keymap.set({"n", "v"}, "<space>cr", vim.lsp.buf.rename, { buffer = ev.buf, desc = "rename" })

                    vim.keymap.set("n", "<space>cf", function()
                        vim.lsp.buf.format { async = true }
                    end, { buffer = ev.buf, desc = "format buffer" })
                    vim.keymap.set("n", "<space>wl", function()
                        print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
                    end, { buffer = ev.buf, desc = "list workspace folders" })
                end,
            })

            local luasnip = require("luasnip")
            local cmp = require("cmp")
            cmp.setup({
                snippet = {
                    expand = function(args)
                        luasnip.lsp_expand(args.body)
                    end,
                },
                mapping = cmp.mapping.preset.insert({
                    ["<C-b>"] = cmp.mapping.scroll_docs(-4),
                    ["<C-f>"] = cmp.mapping.scroll_docs(4),
                    ["<C-Space>"] = cmp.mapping.complete(),
                    ["<C-e>"] = cmp.mapping.abort(),
                    -- Accept currently selected item.
                    -- Set `select` to `false` to only confirm explicitly selected items.
                    ["<CR>"] = cmp.mapping(function(fallback)
                        if cmp.visible() then
                            if luasnip.expandable() then
                                luasnip.expand()
                            else
                                cmp.confirm({ select = true })
                            end
                        else
                            fallback()
                        end
                    end),
                    ["<Tab>"] = cmp.mapping(function(fallback)
                        if cmp.visible() then
                            cmp.select_next_item()
                        elseif luasnip.locally_jumpable(1) then
                            luasnip.jump(1)
                        else
                            fallback()
                        end
                    end, { "i", "s" }),
                    ["<S-Tab>"] = cmp.mapping(function(fallback)
                        if cmp.visible() then
                            cmp.select_prev_item()
                        elseif luasnip.locally_jumpable(-1) then
                            luasnip.jump(-1)
                        else
                            fallback()
                        end
                    end, { "i", "s" }),
                }),
                sources = cmp.config.sources({
                    { name = "nvim_lsp" },
                    { name = "luasnip" },
                    { name = "supermaven" },
                }, {
                        { name = "path" },
                        { name = "buffer" }
                    }),

                experimental = {
                    ghost_text = true,
                },
            })
            -- Enable completing paths in :
            cmp.setup.cmdline(":", {
                sources = cmp.config.sources({
                    { name = "path" }
                },
                    {
                        { name = "cmdline" }
                    }),
                matching = { disallow_symbol_nonprefix_matching = false }
            })
            cmp.setup.cmdline({ "/", "?" }, {
                sources = {
                    { name = "buffer" }
                }
            })


            cmp.setup.filetype("lua", {
                sources = cmp.config.sources({
                    { name = "nvim_lsp" },
                    { name = "luasnip" },
                    { name = "nvim_lua" }
                })
            })
            cmp.setup.filetype("gitcommit", {
                sources = cmp.config.sources({
                    { name = "git" },
                }, {
                        { name = "buffer" },
                    })
            })
        end
    },
}
