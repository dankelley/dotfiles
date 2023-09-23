-- Read the docs: https://www.lunarvim.org/docs/configuration
-- Video Tutorials: https://www.youtube.com/watch?v=sFA9kX-Ud_c&list=PLhoH5vyxr6QqGu0i7tt_XoVK9v-KvZ3m6
-- Forum: https://www.reddit.com/r/lunarvim/
-- Discord: https://discord.com/invite/Xb9B4Ny
--


vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.relativenumber = true
vim.opt.wrap = true
--lvim.colorscheme = "default"
-- lvim.colorscheme = "elford"
lvim.colorscheme = "torte"
lvim.plugins = {
    {"jalvesaq/R-Vim-runtime"},
    {"jalvesaq/Nvim-R"},
    {"folke/trouble.nvim"},
}
-- next could be nice but errors are red on magenta and I cannot read them
--vim.diagnostic.config({ virtual_text = false })

vim.g.maplocalleader = ","
vim.g.R_debug = 1
vim.g.r_indent_align_args = 0
vim.g.R_setwidth = -7
vim.opt.smartindent = true
vim.g.R_setwidth = -7
vim.nohlsearch = true
vim.keymap.set('n', '<esc>', ':nohlsearch <cr>')

-- popup background colour
vim.cmd([[highlight Pmenu guibg=DarkBlue]])
vim.cmd([[highlight Pmenu ctermbg=DarkBlue]])

