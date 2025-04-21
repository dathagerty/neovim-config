return {
    {
        "williamboman/mason.nvim",
        opts = {}
    },
    {
        "williamboman/mason-lspconfig.nvim",
        config = function() end,
    },
    {
        "mrcjkb/rustaceanvim",
        version = "^6",
        lazy = false,
    },
    {
        "saghen/blink.cmp",
        event = "InsertEnter",
        dependencies = {
            "rafamadriz/friendly-snippets",
            "fang2hou/blink-copilot",
        },
        version = "*",
        opts = {
            completion = { documentation = { auto_show = true, }, },
            sources = {
                default = { "copilot" },
                providers = {
                    copilot = {
                        name = "copilot",
                        module = "blink-copilot",
                        score_offset = 100,
                        async = true,
                    },
                    path = {
                        enabled = function()
                            return vim.bo.filetype ~= "copilot-chat"
                        end,
                    },
                },
            },
        },
    },
    {
        "rachartier/tiny-inline-diagnostic.nvim",
        event = "LspAttach",
        priority = 1000, -- needs to be loaded in first
        config = function()
            require("tiny-inline-diagnostic").setup({ preset = "powerline" })
            vim.diagnostic.config({ virtual_text = false })
        end,
        opts = {
            show_source = { enabled = true },
            use_icons_from_diagnostic = true,
        },
    },
    {
        "neovim/nvim-lspconfig",
        lazy = false,
        dependencies = {
            { "b0o/schemastore.nvim" },
        },
        opts = function(_, opts)
            return vim.list_extend(opts or {}, {
                codelens = {
                    enabled = true,
                },
            })
        end,
        config = function(_, opts)
            vim.diagnostic.config({
                underline = true,
                update_in_insert = false,
                severity_sort = true,
                signs = {
                    text = {
                        [vim.diagnostic.severity.ERROR] = "",
                        [vim.diagnostic.severity.WARN] = "",
                        [vim.diagnostic.severity.HINT] = "",
                        [vim.diagnostic.severity.INFO] = "",
                    },
                },
            })

            local servers = {
                gopls = {
                    settings = {
                        gopls = {
                            experimentalPostfixCompletions = true,
                            templateExtensions = { "gotmpl" },
                            codelenses = {
                                test = true,
                                vulncheck = true,
                            },
                            usePlaceholders = true,
                            analyses = {
                                shadow = true,
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
                },
                lua_ls = {
                    settings = {
                        Lua = {
                            runtime = { version = "Lua 5.1" },
                            diagnostics = {
                                globals = { "bit", "vim", "it", "describe", "before_each", "after_each" },
                            },
                            workspace = {
                                checkThirdParty = false,
                            },
                            codeLens = {
                                enable = true,
                            },
                            completion = {
                                callSnippet = "Replace",
                            },
                            doc = {
                                privateName = { "^_" },
                            },
                            hint = {
                                enable = true,
                                setType = false,
                                paramType = true,
                                paramName = "Disable",
                                semicolon = "Disable",
                                arrayIndex = "Disable",
                            },
                        }
                    },
                },
                yamlls = {
                    settings = {
                        yaml = {
                            schemaStore = {
                                enable = false,
                                url = "",
                            },
                            schemas = require("schemastore").yaml.schemas()
                        },
                    },
                },
                jsonls = {
                    settings = {
                        json = {
                            schemas = require("schemastore").json.schemas(),
                            validate = { enable = true },
                        },
                    },
                },
            }

            for server, config in pairs(servers) do
                vim.lsp.enable(server)
                config.capabilities = require("blink.cmp").get_lsp_capabilities(config.capabilities)
                vim.lsp.config(server, config)
            end

            -- Global mappings.
            -- See `:help vim.diagnostic.*` for documentation on any of the below functions
            vim.keymap.set("n", "<space>m", vim.cmd.Mason, { desc = "open mason" })

            vim.keymap.set("n", "[d", function()
                vim.diagnostic.jump({ count = -1 })
            end, { desc = "previous diagnostic" })
            vim.keymap.set("n", "]d", function()
                vim.diagnostic.jump({ count = 1 })
            end, { desc = "next diagnostic" })

            vim.keymap.set("n", "<space>cdl", vim.diagnostic.setloclist, { desc = "add diagnostics to location list" })
            vim.keymap.set("n", "<space>cdq", vim.diagnostic.setqflist, { desc = "add diagnostics to location list" })

            -- Use LspAttach autocommand to only map the following keys
            -- after the language server attaches to the current buffer
            vim.api.nvim_create_autocmd("LspAttach", {
                group = vim.api.nvim_create_augroup("UserLspConfig", {}),
                callback = function(ev)
                    -- Enable completion triggered by <c-x><c-o>
                    vim.bo[ev.buf].omnifunc = "v:lua.vim.lsp.omnifunc"
                    local client = vim.lsp.get_client_by_id(ev.data.client_id)
                    if client and client.server_capabilities.inlayHintProvider then
                        vim.lsp.inlay_hint.enable()
                    end

                    -- Buffer local mappings.
                    -- See `:help vim.lsp.*` for documentation on any of the below functions
                    vim.keymap.set("n", "gD", vim.lsp.buf.declaration, { buffer = ev.buf, desc = "go to declaration" })
                    vim.keymap.set("n", "gd", vim.lsp.buf.definition, { buffer = ev.buf, desc = "go to definition" })
                    vim.keymap.set("n", "K", vim.lsp.buf.hover, { buffer = ev.buf, desc = "show hover docs" })
                    vim.keymap.set("n", "gi", vim.lsp.buf.implementation,
                        { buffer = ev.buf, desc = "go to implementation" })
                    vim.keymap.set("n", "<C-k>", vim.lsp.buf.signature_help,
                        { buffer = ev.buf, desc = "show signature help" })
                    vim.keymap.set("n", "<space>wa", vim.lsp.buf.add_workspace_folder,
                        { buffer = ev.buf, desc = "add folder to workspace" })
                    vim.keymap.set("n", "<space>wr", vim.lsp.buf.remove_workspace_folder,
                        { buffer = ev.buf, desc = "remove folder from workspace" })
                    vim.keymap.set("n", "<space>D", vim.lsp.buf.type_definition,
                        { buffer = ev.buf, desc = "go to type definition" })
                    vim.keymap.set("n", "gr", vim.lsp.buf.references, { buffer = ev.buf, desc = "list references" })
                    vim.keymap.set({ "n", "v" }, "<space>ca", vim.lsp.buf.code_action,
                        { buffer = ev.buf, desc = "code actions" })
                    vim.keymap.set({ "n", "v" }, "<space>cr", vim.lsp.buf.rename, { buffer = ev.buf, desc = "rename" })

                    vim.keymap.set("n", "<space>cf", function()
                        vim.lsp.buf.format { async = true }
                    end, { buffer = ev.buf, desc = "format buffer" })
                    vim.keymap.set("n", "<space>wl", function()
                        print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
                    end, { buffer = ev.buf, desc = "list workspace folders" })
                end,
            })
        end
    }
}
