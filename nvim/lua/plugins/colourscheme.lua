return {
  "catppuccin/nvim",
  name = "catppuccin",
  priority = 1000,
  config = function()
    require("catppuccin").setup({
      flavour = "mocha", -- Choose from latte, frappe, macchiato, mocha
      integrations = {
        cmp = true,
        gitsigns = true,
        nvimtree = true,
        telescope = true,
        treesitter = true,
        lsp_saga = true,
        mason = true,
        dashboard = true,
        notify = true,
        noice = true,
        indent_blankline = {
          enabled = true,
          scope_color = "lavender",
        },
      },
    })
    vim.cmd.colorscheme("catppuccin")
  end,
}
