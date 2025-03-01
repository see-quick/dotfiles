return {
  {
    "ms-jpq/coq_nvim",
    branch = "coq",
    dependencies = {
      { "ms-jpq/coq.artifacts", branch = "artifacts" }, -- Snippets & extra sources
      { "ms-jpq/coq.thirdparty", branch = "3p" },       -- Third-party integrations
    },
    config = function()
      -- Load COQ
      vim.g.coq_settings = {
        auto_start = "shut-up",  -- Auto-start without messages
        keymap = {
          jump_to_mark = "<C-q>",
        },
        clients = {
          lsp = { enabled = true },
          snippets = { enabled = true },
        },
      }
      require("coq")

      vim.api.nvim_create_autocmd("FileType", {
        pattern = "c",
        callback = function()
          vim.cmd("COQnow")
        end,
      })

    end,
  },
}
