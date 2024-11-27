return {
  plugins = {
    alpha = {
      header = "banners.graffiti",
    },
    chatgpt = {
      enable = false,
      opts = {
        api_key_cmd = "op read op://private/ChatGPT/password",
      },
    },
    copilot = {
      enable = false,
    },
    supermaven = {
      enabled = true,
    },
    emoji = {
      enable = true,
      enable_cmp_integration = true,
      plugin_path = vim.fn.expand("$HOME/workspace/github.com/allaman/"),
    },
    lf = {
      enable = false,
    },
    git = {
      merge_conflict_tool = "",
    },
    gopher = {
      enable = true,
    },
    gp = {
      enabled = false,
      opts = {
        openai_api_key = { "op read op://private/ChatGPT/password" },
        providers = {
          openai = {
            disable = false,
          },
          anthropic = {
            disable = false,
            endpoint = "https://api.anthropic.com/v1/messages",
            secret = { "bash", "-c", "cat $HOME/.secrets/anthropic-gp-nvm-token" },
          },
        },
      },
    },
    harpoon = {
      enabled = true,
    },
    indent_blankline = {
      enable = true,
      enable_scope = false,
    },
    kustomize = {
      dev = true,
      opts = {
        enable_lua_snip = true,
        kinds = {
          show_filepath = true,
          show_line = true,
        },
        run = {
          trivy = {
            cmd = "trivy",
            args = { "-q", "fs" },
          },
          deprecations29 = {
            cmd = "kubent",
            args = { "-t", "1.29", "-c=false", "--helm3=false", "-l=error", "-e", "-f" },
          },
          deprecations30 = {
            cmd = "kubet",
            args = { "-t", "1.29", "-c=false", "--helm3=false", "-l=error", "-e", "-f" },
          },
        },
      },
    },
    lazy = {
      dev = {
        path = "~/workspace/github.com/allaman/",
      },
      disabled_neovim_plugins = {
        "gzip",
        "netrwPlugin",
        "tarPlugin",
        "tohtml",
        "tutor",
        "zipPlugin",
      },
      lockfile = "~/.lazy-lock.json",
    },
    typst_preview = {
      enabled = true,
    },
    ltex = {
      additional_lang = "de-DE",
    },
    lualine = {
      opts = {
        theme = "catppuccin",
        extensions = { "fugitive", "lazy", "neo-tree", "nvim-dap-ui", "quickfix", "symbols-outline", "toggleterm" },
      },
    },
    markdown_preview = {
      enabled = true,
    },
    oil = {
      enable = false,
    },
    overseer = {
      enable = true,
    },
    symbol_usage = {
      opts = {
        vt_position = "end_of_line",
        disable = { filetypes = { "dockerfile" } },
      },
    },
    telescope = {
      show_untracked_files = true,
      fzf_native = true,
    },
    todo_comments = {
      enabled = true,
    },
    trouble = {
      enabled = true,
    },
    zenmode = {
      enable = true,
    },
    yazi = {
      enabled = false,
    },
    codeium = {
      enabled = true,
    },
    snap = {
      enabled = true,
    },
  },
}
