-- Forum: https://www.reddit.com/r/lunarvim/
-- Discord: https://discord.com/invite/Xb9B4Ny

-- https://www.youtube.com/watch?v=lUssfjNzGNg {
lvim.builtin.treesitter.ensure_installed = {
    "python",
}
local formatters = require "lvim.lsp.null-ls.formatters"
formatters.setup { { name = "black" }, }
local linters = require "lvim.lsp.null-ls.linters"
linters.setup { { command = "flake8", args = { "--ignore=E501,E203" }, filetypes = { "python" }}}
-- } https://www.youtube.com/watch?v=lUssfjNzGNg

vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.relativenumber = true
vim.opt.wrap = true
vim.opt.textwidth = 70
-- to try out colourschemes, use ' sc'
-- lvim.colorscheme = "default"
-- lvim.colorscheme = "torte"
-- lvim.colorscheme = "elford"
-- lvim.colorscheme = "darkplus"
--lvim.colorscheme = "evening"
lvim.colorscheme = "slate" -- my preference as of june 2024
vim.g.maplocalleader = ","
lvim.plugins = {
    {
        "lunarvim/colorschemes"
    },
    {
        "R-nvim/R.nvim",
        lazy = false,
        R_assign = 2,
        --maplocalleader = ","
    },
    {
        "folke/trouble.nvim",
        keys = {
            {
                "<leader>xx",
                "<cmd>Trouble diagnostics toggle<cr>",
                desc = "Diagnostics (Trouble)",
            },
        },
        opts = {},
    },
}
-- vim.g.R_debug = 1
-- vim.g.r_indent_align_args = 0
-- vim.g.R_setwidth = -7
-- vim.g.R_setwidth = -7
-- vim.g.R_assign = 2

vim.opt.smartindent = true
vim.nohlsearch = true
vim.keymap.set('n', '<esc>', ':nohlsearch <cr>')

-- set popup background colour
vim.cmd([[highlight Pmenu guibg=DarkBlue]])
vim.cmd([[highlight Pmenu ctermbg=DarkBlue]])

-- set format timeout to 60 seconds
-- This failed: vim.lsp.buf.format({ timeout_ms = 10000 })
-- Next worked; see https://github.com/LunarVim/LunarVim/discussions/2767
lvim.builtin.which_key.mappings["l"]["f"] = {
    function()
        require("lvim.lsp.utils").format { timeout_ms = 60000 }
    end,
    "Format",
}
