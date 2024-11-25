local utils = require("utils.functions")

return {
  plugins = {
    conform = {
      -- https://github.com/stevearc/conform.nvim
      enable = true,
      event = { "BufReadPre", "BufNewFile", "InsertLeave" },
      disable_autoformat = false,
      config_function = function(opts)
        local conform = require("conform")
        conform.setup(opts)
        conform.formatters.shfmt = {
          prepend_args = { "-i", "2" }, -- 2 spaces instead of tab
        }
        conform.formatters.stylua = {
          prepend_args = { "--indent-type", "Spaces", "--indent-width", "2" }, -- 2 spaces instead of tab
        }
        conform.formatters.yamlfmt = {
          prepend_args = { "-formatter", "indent=2,include_document_start=true,retain_line_breaks_single=true" },
        }
        vim.g.disable_autoformat = vim.g.config.plugins.conform.disable_autoformat
        vim.api.nvim_create_user_command("ToggleAutoformat", function()
          utils.notify("Toggling autoformat", vim.log.levels.INFO, "conform.nvim")
          vim.g.disable_autoformat = vim.g.disable_autoformat == false and true or false
        end, { desc = "Toggling autoformat" })
        vim.keymap.set("n", "<leader>tF", "<cmd>ToggleAutoformat<cr>", { desc = "Toggle format on save" })
      end,
      opts = {
        format_on_save = function()
          -- Disable with a global variable
          if vim.g.disable_autoformat then
            return
          end
          return { async = false, timeout_ms = 500, lsp_fallback = false }
        end,
        -- log_level = vim.log.levels.TRACE,
        formatters_by_ft = {
          go = {  "gofumpt", "goimports-reviser", "golines" },
          javascript = { "prettier" },
          json = { "prettier" },
          lua = { "stylua" },
          markdown = { "prettier" },
          python = { "isort", "ruff_format" },
          sh = { "shfmt" },
          terraform = { "terraform_fmt" },
          ["terraform-vars"] = { "terraform_fmt" },
          tex = { "latexindent" },
          toml = { "taplo" },
          typst = { "typstfmt" },
          yaml = { "yamlfmt" },
        },

        formatters = {
        -- Golang
        ["goimports-reviser"] = {
            prepend_args = { "-rm-unused" },
        },
        golines = {
            prepend_args = { "--max-len=80" },
        },
        -- Lua
        stylua = {
            prepend_args = {
                "--column-width", "80",
                "--line-endings", "Unix",
                "--indent-type", "Spaces",
                "--indent-width", "4",
                "--quote-style", "AutoPreferDouble",
            },
          },
        },
      },
    },
  },
}
