-- Forum: https://www.reddit.com/r/lunarvim/
-- Discord: https://discord.com/invite/Xb9B4Ny
--


vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.relativenumber = true
vim.opt.wrap = true
--lvim.colorscheme = "default"
--lvim.colorscheme = "torte"
lvim.colorscheme = "elford"
lvim.plugins = {
    --{"quarto-dev/quarto-nvim"},
    { "jalvesaq/R-Vim-runtime" },
    { "jalvesaq/Nvim-R" },
    { "folke/trouble.nvim" },
    { "lunarvim/colorschemes" }
    --    {"github/copilot.vim"},
}
-- next could be nice but errors are red on magenta and I cannot read them
--vim.diagnostic.config({ virtual_text = false })

-- R things
vim.g.maplocalleader = ","
vim.g.R_debug = 1
vim.g.r_indent_align_args = 0
vim.g.R_setwidth = -7
vim.g.R_setwidth = -7
-- indentation (not sure what this does)
vim.opt.smartindent = true
-- Search colourizes matches, but <esc> turns colour off.
vim.nohlsearch = true
vim.keymap.set('n', '<esc>', ':nohlsearch <cr>')

-- set popup background colour
vim.cmd([[highlight Pmenu guibg=DarkBlue]])
vim.cmd([[highlight Pmenu ctermbg=DarkBlue]])

-- set timeout to 10 seconds
--vim.lsp.buf.format({ timeout_ms = 10000 })
-- https://github.com/LunarVim/LunarVim/discussions/2767
lvim.builtin.which_key.mappings["l"]["f"] = {
  function()
    require("lvim.lsp.utils").format { timeout_ms = 10000 }
  end,
  "Format",
}
