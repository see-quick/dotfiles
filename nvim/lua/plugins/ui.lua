return {
  "nvim-lualine/lualine.nvim",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  config = function()
    require("lualine").setup({
      options = {
        theme = "catppuccin",
        section_separators = { left = "", right = "" }, -- Bubble-style separators
        component_separators = { left = "", right = "" }, -- Small separators
      },
    })
  end,
}
