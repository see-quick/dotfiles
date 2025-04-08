return {
  "nvim-neo-tree/neo-tree.nvim",
  branch = "v3.x",
  lazy = false, -- Load on startup
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-tree/nvim-web-devicons",
    "MunifTanjim/nui.nvim",
    -- Optional for image preview
    -- { "3rd/image.nvim", opts = {} },
  },
  config = function()
    require("neo-tree").setup({
      close_if_last_window = true,
      enable_git_status = true,
      enable_diagnostics = true,
      use_libuv_file_watcher = true, -- auto refresh

      sources = { "filesystem", "buffers", "git_status", "document_symbols" },
      source_selector = {
        winbar = true, -- enable tab-like source switching in winbar
        statusline = false,
      },

      filesystem = {
        filtered_items = {
          visible = false,
          hide_dotfiles = true,
          hide_gitignored = true,
        },
        hijack_netrw_behavior = "open_current",
        follow_current_file = {
          enabled = true,
          leave_dirs_open = false,
        },
      },

      window = {
        position = "left",
        width = 30,
        mappings = {
          ["<space>"] = "toggle_node",
          ["<cr>"] = "open",
          ["S"] = "split_with_window_picker",
          ["s"] = "vsplit_with_window_picker",
          ["t"] = "open_tabnew",
          ["P"] = {
            "toggle_preview",
            config = {
              use_float = true,
              title = "Neo-tree Preview",
              -- use_image_nvim = true, -- enable if image.nvim is installed
            },
          },
          ["q"] = "close_window",
        },
      },
    })

    require("nvim-web-devicons").setup({
      override_by_extension = {
        ["lua"] = {
          icon = "",
          color = "#51a0cf",
          name = "Lua",
        },
      },
    })
  end,
}
