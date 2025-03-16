local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end

vim.opt.termguicolors = true
vim.opt.rtp:prepend(lazypath)
-- this is basically for quint formal specification language because Mason theer is no such as `quint`
vim.cmd [[
    au BufNewFile,BufReadPost *.qnt runtime syntax/quint.vim
]]
vim.cmd [[
  au BufRead,BufNewFile *.qnt setfiletype quint
]]
vim.g.coq_settings = {
  auto_start = 'shut-up', -- Automatically starts COQ in the background
  clients = {
    lsp = { enabled = true },
    snippets = { enabled = true },
  },
}
vim.lsp.set_log_level("debug")


require("lazy").setup({ { import = "plugins" }, { import = "plugins.lsp" } }, {
  checker = {
    enabled = true,
    notify = false,
  },
  change_detection = {
    notify = false,
  },
})
