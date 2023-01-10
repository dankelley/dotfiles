-- |  \/  \ \ / /\ \   / /_ _|  \/  |  _ \ / ___|
-- | |\/| |\ V /  \ \ / / | || |\/| | |_) | |
-- | |  | | | |    \ V /  | || |  | |  _ <| |___
-- |_|  |_| |_|     \_/  |___|_|  |_|_| \_\\____|
--
--
-- Author: @hongyuanjia
-- Last Modified: 2022-12-26 21:45

-- Basic Settings
local options = {
    backup = false,
    swapfile = false,
    writebackup = false,
    undofile = true,
    hidden = true,

    -- UI
    mouse = "a",
    cmdheight = 1,
    conceallevel = 0,
    pumheight = 10,
    showmode = false,
    showtabline = 2,
    cursorline = true,
    number = true,
    relativenumber = true,
    numberwidth = 4,
    signcolumn = "yes",
    wrap = false,
    scrolloff = 8,
    sidescrolloff = 8,
    termguicolors = true,
    laststatus = 3,
    list = true,
    listchars = "trail:~,tab:>-,nbsp:␣",--DEK "eol:↵,trail:~,tab:>-,nbsp:␣",
    confirm = true,

    -- search
    hlsearch = false, --DEK true,
    ignorecase = true,
    smartcase = true,

    -- split
    splitbelow = true,
    splitright = true,

    -- edit
    fileencoding = "utf-8",
    smartindent = false, --DEK true,
    clipboard = "unnamedplus",
    textwidth = 80,

    -- autocomplete
    completeopt = { "menu", "menuone", "noselect" },
    timeoutlen = 500,
    updatetime = 300,

    -- tabs
    smarttab = true,
    expandtab = true,
    shiftwidth = 4,
    tabstop = 4,
    softtabstop = 4,

    -- session
    sessionoptions = { "buffers", "curdir", "winsize", "localoptions" }
}

for k, v in pairs(options) do
    vim.opt[k] = v
end

if vim.fn.has("nvim-0.8") == 1 then
    vim.opt.spell = true
    vim.api.nvim_create_autocmd("TermOpen", {
        group = vim.api.nvim_create_augroup("SpellCheckOverwrite", {}),
        pattern = "*",
        callback = function()
            vim.opt.spell = false
        end
    })
end

-- disable line number in terminal
vim.api.nvim_create_autocmd("TermOpen", {
    group = vim.api.nvim_create_augroup("LinenumberOverwrite", {}),
    pattern = "*",
    callback = function()
        vim.opt.number = false
        vim.opt.relativenumber = false
    end
})


if vim.fn.has("nvim-0.9.0") == 1 then
    vim.opt.splitkeep = "screen"
end

-- disable intro
vim.opt.shortmess:append("I")

-- treat '-' as word separator
vim.opt.iskeyword:append("-")

-- avoid other file plugins to overwrite format options
vim.api.nvim_create_autocmd("FileType", {
    group = vim.api.nvim_create_augroup("FormatOptionsOverwrite", {}),
    pattern = "*",
    callback = function()
        -- do not add comment header
        vim.opt.formatoptions:remove("cro")
        -- do not insert spaces for multi bytes
        vim.opt.formatoptions:append("M")
        -- don't insert a space before or after a multi-byte when join
        vim.opt.formatoptions:append("B")
        -- multibyte line breaking
        vim.opt.formatoptions:append("m")
        -- remove a comment leader when joining
        vim.opt.formatoptions:append("j")
        -- don't auto format text
        vim.opt.formatoptions:remove("t")
    end
})

-- go to last loc when opening a buffer
vim.cmd([[
    autocmd BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | execute "normal! g`\"" | endif
]])

-- highlight on yank
vim.api.nvim_create_autocmd("TextYankPost", {
    group = vim.api.nvim_create_augroup("HighlightYank", {}),
    pattern = "*",
    callback = function()
        vim.highlight.on_yank({
            higroup = "IncSearch",
            timeout = 40
        })
    end
})

-- don't load builtin plugins
local builtins = {
    "gzip", "zip", "zipPlugin", "tar", "tarPlugin",
    "getscript", "getscriptPlugin", "vimball", "vimballPlugin",
    "2html_plugin", "matchit", "matchparen", "logiPat", "rrhelper",
    "netrw", "netrwPlugin", "netrwSettings", "netrwFileHandlers",
    "tutor"
}
for _, plugin in ipairs(builtins) do
    vim.g["loaded_" .. plugin] = 1
end

-- short name for printing
function _G.P(...)
    vim.pretty_print(...)
end

-- remap space as the leader key
vim.g.mapleader = " "
vim.g.maplocalleader = ","
vim.keymap.set("", "<Space>", "<Nop>")

-- keep the cursor always at the middle when jumping lines
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")

-- keep the cursor stay when joining lines
vim.keymap.set("n", "J", "mzJ`z")

-- remap j and k to move across display lines and not real lines
vim.keymap.set("n", "k", "gk")
vim.keymap.set("n", "gk", "k")
vim.keymap.set("n", "j", "gj")
vim.keymap.set("n", "gj", "j")

-- use <C-[UDLR]> for window resizing
vim.keymap.set("n", "<C-j>", "<cmd>resize -2<CR>")
vim.keymap.set("n", "<C-k>", "<cmd>resize +2<CR>")
vim.keymap.set("n", "<C-l>", "<cmd>vertical resize -2<CR>")
vim.keymap.set("n", "<C-h>", "<cmd>vertical resize +2<CR>")

-- stay in indent mode
vim.keymap.set("v", ">", ">gv")
vim.keymap.set("v", "<", "<gv")


-- move text up and down
--DEK vim.keymap.set("n", "<A-j>", ":m .+1<CR>==")
--DEK vim.keymap.set("v", "<A-j>", ":m '>+1<CR>gv=gv")
--DEK vim.keymap.set("i", "<A-j>", "<Esc>:m .+1<CR>==gi")
--DEK vim.keymap.set("n", "<A-k>", ":m .-2<CR>==")
--DEK vim.keymap.set("v", "<A-k>", ":m '<-2<CR>gv=gv")
--DEK vim.keymap.set("i", "<A-k>", "<Esc>:m .-2<CR>==gi")

-- jump to beginning or end using H and L
--DEK vim.keymap.set("n", "H", "^")
--DEK vim.keymap.set("n", "L", "$")
--DEK vim.keymap.set("v", "H", "^")
--DEK vim.keymap.set("v", "L", "$")

-- use Y to yank to the end of line
--DEK vim.keymap.set("n", "Y", "y$")
--DEK vim.keymap.set("v", "Y", "'+y")

-- buffer & tab navigation
vim.keymap.set("n", "]b", "<cmd>bnext<CR>")
vim.keymap.set("n", "[b", "<cmd>bprev<CR>")
vim.keymap.set("n", "]t", "<cmd>tabnext<CR>")
vim.keymap.set("n", "[t", "<cmd>tabprev<CR>")

-- <Leader>b[uffer]
vim.keymap.set("n", "<Leader>bd", "<cmd>bdelete<CR>")
vim.keymap.set("n", "<Leader>bn", "<cmd>bnext<CR>")
vim.keymap.set("n", "<Leader>bp", "<cmd>bprev<CR>")
vim.keymap.set("n", "<Leader>bN", "<cmd>enew <BAR> startinsert <CR>")

-- <Leader>f[ile]
vim.keymap.set("n", "<Leader>fs", "<cmd>update<CR>")
vim.keymap.set("n", "<Leader>fR", "<cmd>source $MYVIMRC<CR>")
vim.keymap.set("n", "<Leader>fv", "<cmd>e $MYVIMRC<CR>")

-- <Leader>o[pen]
vim.keymap.set("n", "<Leader>oq", "<cmd>qopen<CR>")
vim.keymap.set("n", "<Leader>ol", "<cmd>lopen<CR>")

-- <Leader>t[ab]
vim.keymap.set("n", "<Leader>tN", "<cmd>$tabnew<CR>")
vim.keymap.set("n", "<Leader>tc", "<cmd>tabclose<CR>", { noremap = true })
vim.keymap.set("n", "<Leader>to", "<cmd>tabonly<CR>", { noremap = true })
vim.keymap.set("n", "<Leader>tn", "<cmd>tabn<CR>", { noremap = true })
vim.keymap.set("n", "<Leader>tp", "<cmd>tabp<CR>", { noremap = true })
vim.keymap.set("n", "<leader>tmp", ":-tabmove<CR>", { noremap = true })
vim.keymap.set("n", "<leader>tmn", ":+tabmove<CR>", { noremap = true })

-- https://github.com/mhinz/vim-galore#saner-behavior-of-n-and-n
vim.keymap.set("n", "n", "'Nn'[v:searchforward]", { expr = true })
vim.keymap.set("x", "n", "'Nn'[v:searchforward]", { expr = true })
vim.keymap.set("o", "n", "'Nn'[v:searchforward]", { expr = true })
vim.keymap.set("n", "N", "'nN'[v:searchforward]", { expr = true })
vim.keymap.set("x", "N", "'nN'[v:searchforward]", { expr = true })
vim.keymap.set("o", "N", "'nN'[v:searchforward]", { expr = true })

-- save in insert mode
--DEK vim.keymap.set("i", "<C-s>", "<cmd>:w<cr><esc>")

-- <Leader>t[oggle]
function _G.toggle_colorcolumn()
    if vim.wo.colorcolumn ~= "" then
        vim.wo.colorcolumn = ""
    else
        vim.wo.colorcolumn = "120"
    end
end
function _G.toggle_linenumber()
    vim.cmd[[
        execute {
            \ '00': 'set relativenumber   | set number',
            \ '01': 'set norelativenumber | set number',
            \ '10': 'set norelativenumber | set nonumber',
            \ '11': 'set norelativenumber | set number'
            \ }[&number . &relativenumber]
    ]]
end
function _G.toggle_slash()
    local line = vim.api.nvim_get_current_line()
    local first = string.match(line, "[/\\]")
    if first == nil then return end
    local oppsite = first == "\\" and "/" or "\\"
    line = string.gsub(line, first, oppsite)
    vim.api.nvim_set_current_line(line)
end
--DEK vim.keymap.set("n", "<Leader>tC", toggle_colorcolumn)
--DEK vim.keymap.set("n", "<Leader>tL", toggle_linenumber)
--DEK vim.keymap.set("n", "<Leader>t\\", toggle_slash)

-- <Leader>q[uit]
--DEK vim.keymap.set("n", "<Leader>q", "<cmd>q<CR>")
--DEK vim.keymap.set("n", "<Leader>Q", "<cmd>qa!<CR>")

-- <Leader>s[earch]
--DEK vim.keymap.set("n", "<Leader>sn", "<cmd>nohlsearch<CR>")

-- <Leader>w[indow]
vim.keymap.set("n", "<Leader>ww", "<C-w>w")
vim.keymap.set("n", "<Leader>wc", "<C-w>c")
vim.keymap.set("n", "<Leader>w-", "<C-w>s")
vim.keymap.set("n", "<Leader>w|", "<C-w>v")
vim.keymap.set("n", "<Leader>wh", "<C-w>h")
vim.keymap.set("n", "<Leader>wj", "<C-w>j")
vim.keymap.set("n", "<Leader>wl", "<C-w>l")
vim.keymap.set("n", "<Leader>wk", "<C-w>k")
vim.keymap.set("n", "<Leader>wH", "<C-w>5<")
vim.keymap.set("n", "<Leader>wL", "<C-w>5>")
vim.keymap.set("n", "<Leader>wJ", "<cmd>resize +5<CR>")
vim.keymap.set("n", "<Leader>wK", "<cmd>resize -5<CR>")
vim.keymap.set("n", "<Leader>w=", "<C-w>=")
vim.keymap.set("n", "<Leader>wv", "<C-w>v")
vim.keymap.set("n", "<Leader>ws", "<C-w>s")
vim.keymap.set("n", "<Leader>wo", "<cmd>only<CR>")
vim.keymap.set("n", "<Leader>wp", "<C-w><C-p>")

vim.keymap.set("t", "<Esc>", [[<C-\><C-n>]])
vim.keymap.set("t", "jk",    [[<C-\><C-n>]])
vim.keymap.set("t", "<C-h>", [[<C-\><C-n><C-W>h]])
vim.keymap.set("t", "<C-j>", [[<C-\><C-n><C-W>j]])
vim.keymap.set("t", "<C-k>", [[<C-\><C-n><C-W>k]])
vim.keymap.set("t", "<C-l>", [[<C-\><C-n><C-W>l]])

-- File type specific settings
vim.api.nvim_create_autocmd(
    { "BufEnter", "BufWinEnter" },
    {
        group = vim.api.nvim_create_augroup("AutoHotkeyComment", {}),
        pattern = { "*.ahk", "*.ahk2" },
        callback = function()
            vim.bo.commentstring = ";%s"
            vim.bo.comments = "s1:/*,mb:*,ex:*/,:;"
        end
    }
)

-- Plugins
-- automatically bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
    if vim.fn.executable("git") == 0 then
        print "Git was not installed. Please install Git first. All plugins will be not installed."
        return
    end
    vim.fn.system({
        "git", "clone", "--filter=blob:none", "--single-branch",
        "https://github.com/folke/lazy.nvim.git",
        lazypath
    })
end
vim.opt.runtimepath:prepend(lazypath)

-- stop loading plugin configs if lazy is not installed
local lazy_status_ok, lazy = pcall(require, "lazy")
if not lazy_status_ok then
    return
end

lazy.setup({
    -- vim.keymap.set("n", "Q", "gq}", { noremap = true }), --DEK

    "nvim-lua/popup.nvim",
    "nvim-lua/plenary.nvim",

    -- colorscheme
    {
       "tomasr/molokai", --DEK "folke/tokyonight.nvim",
        --DEK init = function()
        --DEK     vim.cmd.colorscheme("tokyonight")
        --DEK end,
        --DEK config = true
    },

    -- chezmoi for dot file management
    { "alker0/chezmoi.vim", lazy = false },

    -- start tim profile
    { "tweekmonster/startuptime.vim", cmd = "StartupTime" },

    -- UI
    {
        "anuvyklack/windows.nvim",
        dependencies = {
            "anuvyklack/middleclass",
            "anuvyklack/animation.nvim"
        },
        event = "WinEnter",
        init = function()
            -- <Leader>w[indows]
            vim.keymap.set("n", "<Leader>wm", "<cmd>WindowsMaximize<CR>")
            vim.keymap.set("n", "<Leader>wV", "<cmd>WindowsMaximizeVertically<CR>")
            vim.keymap.set("n", "<Leader>wH", "<cmd>WindowsMaximizeHorizontally<CR>")
            vim.keymap.set("n", "<Leader>w=", "<cmd>WindowsEqualize<CR>")
            vim.keymap.set("n", "<Leader>wC", "<cmd>WindowsToggleAutowidth<CR>")
        end,
        config = function()
            vim.o.winwidth = 10
            vim.o.winminwidth = 10
            vim.o.equalalways = false
            require("windows").setup({
                ignore = {
                    filetype = { "NvimTree", "DiffviewFiles" }
                }
            })
        end
    },
    { "kyazdani42/nvim-web-devicons", config = { default = true } },
    {
        "nanozuki/tabby.nvim",
        event = "VeryLazy",
        init = function()
            vim.keymap.set("n", "<Leader>tR", function()
                vim.ui.input(
                    {
                        prompt = "Tab Name > ",
                        default = nil
                    },
                    function(input)
                        if input and input ~= "" then
                            vim.cmd.TabRename(input)
                        end
                    end
                )
            end)
        end,
        config = true
    },
    {
        "nvim-lualine/lualine.nvim",
        event = "VeryLazy",
        dependencies = "SmiteshP/nvim-navic",
        config = function()
            require("lualine").setup({
                options = {
                    theme = "powerline_dark", --DEK "auto",
                    component_separators = { left = "", right = "" },
                    section_separators = { left = "", right = "" },
                    globalstatus = true,
                    disabled_filetypes = {
                        statusline = { "alpha", "NvimTree", "Outline" },
                        winbar = {  "alpha", "NvimTree", "toggleterm" }
                    },
                },
                sections = {
                    lualine_a = { "mode" },
                    lualine_b = {
                        {
                            "branch",
                            icons_enabled = true,
                            icon = "",
                        },
                        {
                            "diagnostics",
                            sources = { "nvim_diagnostic" },
                            sections = { "error", "warn" },
                            symbols = { error = " ", warn = " " },
                            colored = true,
                        }
                    },
                    lualine_c = {
                        {
                            function()
                                local navic = require("nvim-navic")
                                local ret = navic.get_location()
                                return ret:len() > 2000 and "navic error" or ret
                            end,
                            cond = function()
                                local navic = require("nvim-navic")
                                return navic.is_available()
                            end
                        }
                    },
                    lualine_x = {
                        {
                            "diff",
                            colored = false,
                            symbols = { added = " ", modified = " ", removed = " " },
                            cond = function()
                                return vim.fn.winwidth(0) > 80
                            end
                        }
                    },
                    --DEK lualine_y = { "encoding", "filetype" }
                    lualine_y = { "progress", "filetype" }
                }
            })
        end
    },
    { "tiagovla/scope.nvim", event = "VeryLazy", config = true },
    {
        "RRethy/vim-illuminate",
        event = "BufReadPost",
        keys = {
            { "]]", function() require("illuniate").goto_next_reference(false) end },
            { "[[", function() require("illuniate").goto_prev_reference(false) end }
        },
        config = function()
            require("illuminate").configure({ delay = 200 })
        end
    },
    {
        "moll/vim-bbye",
        cmd = "Bdelete",
        keys = { { "<Leader>bd", "<cmd>Bdelete<CR>" } }
    },
    {
        "lukas-reineke/indent-blankline.nvim",
        event = "BufReadPre",
        config = {
            buftype_exclude = { "terminal", "nofile" },
            filetype_exclude = {
                "help", "checkhealth", "dashboard", "NvimTree", "Trouble"
            },
            use_treesitter_scope = false
        }
    },
    { "norcalli/nvim-colorizer.lua", event = "BufReadPre", config = true },
    {
        "akinsho/toggleterm.nvim",
        keys = { "<Leader>tf", "<Leader>th", "<Leader>tv" },
        config = function()
            require("toggleterm").setup({
                size = function(term)
                    if term.direction == "vertical" then
                        return vim.o.columns * 0.3
                    else
                        return 20
                    end
                end,
                float_opts = {
                    border = "curved",
                    winblend = 0,
                    highlights = {
                        border = "Normal",
                        background = "Normal"
                    }
                }
            })

            local shell = vim.o.shell
            if string.lower(jit.os) == "windows" then
                if vim.fn.executable("pwsh") == 1 then
                    shell = "pwsh -NoLogo"
                else
                    shell = "powershell -NoLogo"
                end
            end
            _G.toggle_terminal = function(cmd, direction)
                local terminal = require("toggleterm.terminal").Terminal:new({ cmd = cmd, direction = "horizontal" })
                terminal.direction = direction
                terminal:toggle()
            end

            -- <Leader>t[erminal]
            vim.keymap.set("n", "<Leader>tf", function() toggle_terminal(shell, "float") end)
            vim.keymap.set("n", "<Leader>th", function() toggle_terminal(shell, "horizontal") end)
            vim.keymap.set("n", "<Leader>tv", function() toggle_terminal(shell, "vertical") end)

            if vim.fn.executable("lazygit") == 1 then
                vim.keymap.set("n", "<Leader>g=", function() toggle_terminal("lazygit", "float") end)
            end
        end
    },
    {
        "goolord/alpha-nvim",
        event = "VimEnter",
        config = function()
            local alpha = require("alpha")
            local dashboard = require("alpha.themes.dashboard")

            dashboard.section.footer = {
                type = "text",
                val = {
                    os.date("%Y-%m-%d %H:%M"),
                    "Plugin: " .. require("lazy").stats().count
                },
                opts = { position = "center", hl = "Comment" }
            }

            dashboard.section.buttons.val = {
                dashboard.button("SPC b N", "  New file"),
                dashboard.button("SPC s f", "  Find file"),
                dashboard.button("SPC p s", "  Find project"),
                dashboard.button("SPC f r", "  Recently used files"),
                dashboard.button("SPC s g", "  Find text"),
                dashboard.button("SPC S l", "  Load Session"),
                dashboard.button("SPC f v", "  Configuration"),
                dashboard.button("SPC Q",   "  Quit Neovim")
            }

            dashboard.config.layout = {
                { type = "padding", val = 2 },
                dashboard.section.header,
                { type = "padding", val = 2 },
                dashboard.section.buttons,
                { type = "padding", val = 2 },
                dashboard.section.footer
            }

            dashboard.config.opts = {
                margin = 5,
                setup = function()
                    vim.api.nvim_create_autocmd("User", {
                        pattern = "AlphaReady",
                        desc = "Disable status and tabline for alhpa",
                        callback = function()
                            vim.opt.showtabline = 0
                        end
                    })

                    vim.api.nvim_create_autocmd("BufUnload", {
                        buffer = 0,
                        desc = "Enable status and tabline after alhpa",
                        callback = function()
                            vim.opt.showtabline = 2
                        end
                    })
                end
            }

            alpha.setup(dashboard.config)

            -- <Leader>b[uffer]
            vim.keymap.set("n", "<Leader>ba", "<cmd>Alpha<CR>")
        end
    },
    {
        "b0o/incline.nvim",
        event = "BufReadPre",
        config = function()
            require("incline").setup({
                window = {
                    margin = {
                        vertical = 0,
                        horizontal = 1,
                    },
                },
                render = function(props)
                    local filename = vim.fn.fnamemodify(vim.api.nvim_buf_get_name(props.buf), ":t")
                    local icon, color = require("nvim-web-devicons").get_icon_color(filename)
                    return {
                        { icon, guifg = color },
                        { " " },
                        { filename },
                    }
                end,
            })
        end
    },
    {
        "simrat39/symbols-outline.nvim",
        cmd = "SymbolsOutline",
        keys = {
            -- <Leader>l[ist]
            { "<Leader>lo", "<cmd>SymbolsOutline<CR>" }
        },
        config = true
    },
    {
        "tkmpypy/chowcho.nvim",
        keys = {
            { "-", function() require("chowcho").run() end, "n", { remap = true } }
        },
        config = { icon_enabled = true, border_style = "rounded" }
    },
    {
        "sindrets/winshift.nvim",
        cmd = "WinShift",
        keys = {
            -- use <Leader>wS to change window position
            { "<Leader>wS", "<cmd>WinShift<CR>" }
        },
        config = { focused_hl_groups = "Search" }
    },

    -- session management
    {
        "natecraddock/sessions.nvim",
        cmd = { "SessionsLoad", "SessionsStop", "SessionsSave" },
        init = function()
            vim.keymap.set("n", "<Leader>Ss", function()
                -- detect if an R terminal is started by NVim-R
                if vim.g.rplugin and vim.g.rplugin.R_bufname then
                    -- quite R sessions
                    vim.call("RQuit", "nosave")
                    local rbuf = vim.g.rplugin.R_bufname

                    -- delete the buffer
                    for i, buf in ipairs(vim.api.nvim_list_bufs()) do
                        if vim.api.nvim_buf_get_name(buf) == rbuf then
                            vim.cmd("bdelete " .. buf)
                        end
                    end
                end
                vim.ui.input(
                    {
                        prompt = "Session Name > ",
                        default = nil
                    },
                    function(input)
                        if input and input ~= "" then
                            require("sessions").save(input)
                        end
                    end
                )
            end)
            vim.keymap.set("n", "<Leader>Sl", function() require("sessions").load() end)
        end,
        config = {
            session_filepath = vim.fn.expand(vim.fn.stdpath("data") .. "/sessions"),
            absolute = true
        }
    },
    {
        "natecraddock/workspaces.nvim",
        init = function()
            vim.keymap.set("n", "<Leader>pa", function()
                vim.ui.input(
                    {
                        prompt = "Project Name > ",
                        default = nil
                    },
                    function(input)
                        if input and input ~= "" then
                            require("workspaces").add(nil, input)
                        end
                    end
                )
            end)
            vim.keymap.set("n", "<Leader>pl", function() require("workspaces").list() end)
            vim.keymap.set("n", "<Leader>ps", function() require("telescope").extensions.workspaces.workspaces() end )
        end,
        config = function()
            require("workspaces").setup({
                hooks = {
                    open = function()
                        if not require("sessions").load(nil, { silent = true }) then
                            require("telescope.builtin").find_files()
                        end
                    end,
                }
            })
            require("telescope").load_extension("workspaces")
        end
    },

    -- autocompletion
    {
        "hrsh7th/nvim-cmp",
        event = "InsertEnter",
        dependencies = {
            -- completion sources
            "hrsh7th/cmp-buffer",
            "hrsh7th/cmp-path",
            "hrsh7th/cmp-cmdline",
            "hrsh7th/cmp-nvim-lsp",
            "hrsh7th/cmp-nvim-lsp-signature-help",
            "petertriho/cmp-git",
            "uga-rosa/cmp-dictionary",
            "jalvesaq/cmp-nvim-r",

            -- snippets
            "saadparwaiz1/cmp_luasnip",
            "L3MON4D3/LuaSnip",
            "rafamadriz/friendly-snippets",

            -- Chinese input method
            "yehuohan/cmp-im",
            "yehuohan/cmp-im-zh"
        },
        config = function()
            local cmp = require("cmp")
            local compare = require("cmp.config.compare")
            local luasnip = require("luasnip")

            require("cmp_im").setup({
                tables = require("cmp_im_zh").tables({ "wubi", "pinyin" })
            })
            require("cmp_git").setup()

            require("cmp_dictionary").setup({
                dic = {
                    ["*"] = vim.fn.expand(vim.fn.stdpath("data") .. "/dictionary/en.dict")
                },
                async = true
            })
            require("cmp_dictionary").update()

            vim.keymap.set({"n", "v", "c", "i"}, "<M-;>", function()
                vim.notify(string.format("IM is %s", require("cmp_im").toggle() and "enabled" or "disabled"))
            end)

            local has_words_before = function()
                local line, col = unpack(vim.api.nvim_win_get_cursor(0))
                return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
            end

            -- load snippets
            require("luasnip/loaders/from_vscode").lazy_load()

            cmp.setup({
                snippet = {
                    expand = function(args)
                        luasnip.lsp_expand(args.body)
                    end
                },
                mapping = {
                    ['<C-p>'] = cmp.mapping.select_prev_item(),
                    ['<C-n>'] = cmp.mapping.select_next_item(),
                    ["<C-b>"] = cmp.mapping(cmp.mapping.scroll_docs(-4), { "i", "c" }),
                    ["<C-f>"] = cmp.mapping(cmp.mapping.scroll_docs( 4), { "i", "c" }),
                    ["<C-Space>"] = cmp.mapping(cmp.mapping.complete(), { "i", "c" }),
                    ["<C-y>"] = cmp.mapping(cmp.mapping.complete(), { "i", "c" }),
                    ["<C-e>"] = cmp.mapping({
                        i = cmp.mapping.abort(),
                        c = cmp.mapping.close()
                    }),
                    ["<CR>"] = cmp.mapping.confirm({ select = false }),
                    ["<Tab>"] = cmp.mapping(function(fallback)
                        if cmp.visible() then
                            cmp.select_next_item()
                        elseif luasnip.expand_or_jumpable() then
                            luasnip.expand_or_jump()
                        elseif has_words_before() then
                            cmp.complete()
                        else
                            fallback()
                        end
                    end, { "i", "s" }),
                    ["<S-Tab>"] = cmp.mapping(function(fallback)
                        if luasnip.jumpable(-1) then
                            luasnip.jump(-1)
                        elseif cmp.visible() then
                            cmp.select_prev_item()
                        else
                            fallback()
                        end
                    end, { "i", "s" }),
                    ['<Space>'] = cmp.mapping(require("cmp_im").select(), { 'i' })
                },
                sources = cmp.config.sources({
                    { name = "IM"},
                    { name = "cmp_nvim_r" },
                    { name = "nvim_lsp" },
                    { name = "nvim_lsp_signature_help" },
                    { name = "luasnip" },
                    { name = "nvim_lua" },
                    { name = "git" },
                    { name = "dictionary", keyword_length = 2 },
                    { name = "buffer" },
                    { name = "path" }
                }),
                formatting = {
                    fields = { "kind", "abbr", "menu" },
                    format = function(entry, vim_item)
                        local kind_icons = {
                            Text = "",
                            Method = "m",
                            Function = "",
                            Constructor = "",
                            Field = "",
                            Variable = "",
                            Class = "",
                            Interface = "",
                            Module = "",
                            Property = "",
                            Unit = "",
                            Value = "",
                            Enum = "",
                            Keyword = "",
                            Snippet = "",
                            Color = "",
                            File = "",
                            Reference = "",
                            Folder = "",
                            EnumMember = "",
                            Constant = "",
                            Struct = "",
                            Event = "",
                            Operator = "",
                            TypeParameter = "",
                        }
                        vim_item.kind = string.format("%s", kind_icons[vim_item.kind])
                        vim_item.menu = ({
                            nvim_lsp = "[LSP]",
                            luasnip = "[Snippet]",
                            buffer = "[Buffer]",
                            path = "[Path]",
                            IM = "[IM]",
                        })[entry.source.name]
                        return vim_item
                    end
                },
                sorting = {
                    priority_weight = 2,
                    comparators = {
                        compare.sort_text,
                        compare.kind,
                        compare.offset,
                        compare.exact,
                        compare.score,
                        compare.recently_used,
                        compare.locality,
                        compare.length,
                        compare.order
                    }
                },
                experimental = {
                    ghost_text = { hl_group = "LspCodeLens" },
                    native_menu = false
                }
            })

            cmp.setup.cmdline("/", {
                mapping = cmp.mapping.preset.cmdline(),
                sources = {
                    { name = "buffer" }
                }
            })

            cmp.setup.cmdline(":", {
                mapping = cmp.mapping.preset.cmdline(),
                sources = cmp.config.sources({
                    { name = "path" },
                    { name = "cmdline" }
                })
            })
        end
    },

    -- lsp
    {
        "jose-elias-alvarez/null-ls.nvim",
        config = function()
            require("null-ls").setup({
                sources = {
                    require("null-ls").builtins.completion.spell,
                    require("null-ls").builtins.code_actions.gitsigns
                }
            })
        end
    },
    {
        "SmiteshP/nvim-navic",
        config = function()
            vim.g.navic_silence = true
            require("nvim-navic").setup({ separator = " ", highlight = true, depth_limit = 5 })
        end,
    },
    { "williamboman/mason.nvim", config = true },
    { "williamboman/mason-lspconfig.nvim", config = true },
    {
        "neovim/nvim-lspconfig",
        event = "BufReadPre",
        dependencies = {
            "simrat39/rust-tools.nvim",
            "hrsh7th/cmp-nvim-lsp"
        },
        config = function()
            require("mason").setup()
            require("mason-lspconfig").setup({
                ensure_installed = { "sumneko_lua" }
            })
            local lspconfig = require("lspconfig")

            -- update diagnostic config
            local signs = { Error = "" , Warn = "" , Hint = "" , Info = "" }
            for type, icon in pairs(signs) do
                local hl = "DiagnosticSign" .. type
                vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
            end

            -- use virtual text
            vim.diagnostic.config({
                underline = true,
                update_in_insert = false,
                virtual_text = { spacing = 4, prefix = "●" },
                severity_sort = true,
            })

            vim.lsp.handlers["workspace/diagnostic/refresh"] = function(_, _, ctx)
                local ns = vim.lsp.diagnostic.get_namespace(ctx.client_id)
                pcall(vim.diagnostic.reset, ns)
                return true
            end

            local on_attach = function(client, bufnr)
                require("nvim-navic").attach(client, bufnr)
                vim.keymap.set("n", "gD", vim.lsp.buf.declaration, { buffer = bufnr })
                vim.keymap.set("n", "gd", vim.lsp.buf.definition, { buffer = bufnr })
                vim.keymap.set("n", "gi", vim.lsp.buf.implementation, { buffer = bufnr })
                vim.keymap.set("n", "gh", vim.lsp.buf.signature_help, { buffer = bufnr })
                vim.keymap.set("n", "gR", vim.lsp.buf.rename, { buffer = bufnr })
                vim.keymap.set("n", "gr", vim.lsp.buf.references, { buffer = bufnr })
                vim.keymap.set("n", "ga", vim.lsp.buf.code_action, { buffer = bufnr })
                vim.keymap.set("n", "gl", function() vim.diagnostic.open_float(nil, { scope = "line" }) end, { buffer = bufnr })
                vim.keymap.set("n", "K",  vim.lsp.buf.hover, { buffer = bufnr })
                vim.keymap.set("n", "[d", function() vim.diagnostic.goto_prev({ border = 'rounded' }) end, { buffer = bufnr })
                vim.keymap.set("n", "]d", function() vim.diagnostic.goto_next({ border = 'rounded' }) end, { buffer = bufnr })

                -- <Leader>l[sp]
                vim.keymap.set("n", "<Leader>li", "<cmd>LspInfo<CR>", { buffer = bufnr })
                vim.keymap.set("n", "<Leader>lI", "<cmd>LspInstallInfo<CR>", { buffer = bufnr })
                vim.keymap.set("n", "<Leader>lj", function() vim.diagnostic.goto_next({ border = 'rounded' }) end, { buffer = bufnr })
                vim.keymap.set("n", "<Leader>lk", function() vim.diagnostic.goto_prev({ border = 'rounded' }) end, { buffer = bufnr })
                vim.keymap.set("n", "<Leader>ll", vim.lsp.codelens.run, { buffer = bufnr })
                vim.keymap.set("n", "<Leader>la", vim.lsp.buf.code_action, { buffer = bufnr })
                vim.keymap.set("n", "<Leader>lF", vim.lsp.buf.format, { buffer = bufnr })
                vim.keymap.set("n", "<Leader>lr", vim.lsp.buf.rename, { buffer = bufnr })
            end


            -- add lsp auto-completion source
            require("lspconfig.util").default_config = vim.tbl_extend(
                "force",
                require("lspconfig.util").default_config,
                {
                    capabilities = require("cmp_nvim_lsp").default_capabilities()
                }
            )
            require("mason-lspconfig").setup_handlers({
                function(server_name)
                    require("lspconfig")[server_name].setup({ on_attach = on_attach })
                end,

                -- r
                ["r_language_server"] = function()
                    lspconfig.r_language_server.setup({
                        on_attach = on_attach,
                        settings = {
                            r = {
                                lsp = {
                                    diagnostics = true
                                }
                            }
                        }
                    })
                end,

                -- lua
                ["sumneko_lua"] = function()
                    lspconfig.sumneko_lua.setup({
                        on_attach = on_attach,
                        settings = {
                            Lua = {
                                runtime = {
                                    version = "LuaJIT",
                                    special = {
                                        reload = "require"
                                    }
                                },
                                diagnostics = {
                                    globals = { "vim" }
                                },
                                workspace = {
                                    library = {
                                        vim.fn.expand("$VIMRUNTIME")
                                    },
                                    maxPreload = 5000,
                                    preloadFileSize = 10000
                                }
                            }
                        }
                    })
                end,

                -- rust
                ["rust_analyzer"] = function()
                    require('rust-tools').setup({ server = { on_attach = on_attach } })
                end
            })
        end
    },
    { "m-demare/hlargs.nvim", event = "VeryLazy", config = true },
    {
        "folke/trouble.nvim",
        keys = {
            -- <Leader>t[oggle]
            { "<Leader>tt", "<cmd>TroubleToggle<CR>" },

            -- use trouble to replace gr
            { "gr", "<cmd>TroubleToggle lsp_references<CR>" },

            -- <Leader>l[ist]
            { "<Leader>ld", "<cmd>TroubleToggle document_diagnostics<CR>" },
            { "<Leader>lw", "<cmd>TroubleToggle workspace_diagnostics<CR>" },

            -- <Leader>o[pen]
            { "<Leader>oq", "<cmd>TroubleToggle quickfix<CR>" },
            { "<Leader>ol", "<cmd>TroubleToggle loclist<CR>"}
        },
        config = { use_diagnostic_signs = true }
    },

    -- Telescope
    {
        "nvim-telescope/telescope.nvim",
        dependencies = {
            "nvim-lua/plenary.nvim",
            { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
            "tsakirist/telescope-lazy.nvim"
        },
        cmd = "Telescope",
        init = function()
            -- <Leader>sL[roject]
            vim.keymap.set("n", "<Leader>sL", function() require("telescope").extensions.lazy.lazy() end )

            -- <Leader>b[uffer]
            vim.keymap.set("n", "<Leader>bb", function() require("telescope.builtin").buffers() end)

            -- <Leader>f[ile]
            vim.keymap.set("n", "<Leader>ff", function() require("telescope.builtin").find_files() end)
            vim.keymap.set("n", "<Leader>fr", function() require("telescope.builtin").oldfiles() end)

            -- <Leader>g[it]
            vim.keymap.set("n", "<Leader>gS", function() require("telescope.builtin").git_status() end)
            vim.keymap.set("n", "<Leader>gB", function() require("telescope.builtin").git_branches() end)
            vim.keymap.set("n", "<Leader>gC", function() require("telescope.builtin").git_commits() end)

            -- <Leader>l[ist]
            vim.keymap.set("n", "<Leader>ld", function() require("telescope.builtin").diagnostics({ bufnr = 0 }) end)
            vim.keymap.set("n", "<Leader>lw", function() require("telescope.builtin").diagnostics() end)

            -- <Leader>s[earch]
            vim.keymap.set("n", "<Leader>sl", function() require("telescope.builtin").current_buffer_fuzzy_find() end)
            vim.keymap.set("n", "<Leader>sf", function() require("telescope.builtin").find_files(require("telescope.themes").get_dropdown{ previewer = false }) end)
            vim.keymap.set("n", "<Leader>sb", function() require("telescope.builtin").buffers(require("telescope.themes").get_dropdown{ previewer = false }) end)
            vim.keymap.set("n", "<Leader>sB", function() require("telescope.builtin").git_branches() end)
            vim.keymap.set("n", "<Leader>sC", function() require("telescope.builtin").colorscheme({ enable_preview = true }) end)
            vim.keymap.set("n", "<Leader>sh", function() require("telescope.builtin").help_tags() end)
            vim.keymap.set("n", "<Leader>sM", function() require("telescope.builtin").man_pages() end)
            vim.keymap.set("n", "<Leader>sr", function() require("telescope.builtin").oldfiles() end)
            vim.keymap.set("n", "<Leader>sR", function() require("telescope.builtin").registers() end)
            vim.keymap.set("n", "<Leader>sk", function() require("telescope.builtin").keymaps() end)
            vim.keymap.set("n", "<Leader>sc", function() require("telescope.builtin").commands() end)
            vim.keymap.set("n", "<Leader>s/", function() require("telescope.builtin").search_history() end)
            vim.keymap.set("n", "<Leader>sm", function() require("telescope.builtin").marks() end)
            vim.keymap.set("n", "<Leader>ss", function() require("telescope.builtin").lsp_document_symbols() end)
            vim.keymap.set("n", "<Leader>sS", function() require("telescope.builtin").lsp_workspace_symbols() end)
            vim.keymap.set("n", "<Leader>sP", function() require("telescope.builtin").resume() end)

            -- change comma input text into a lua table
            local input_to_table = function(txt)
                -- trim spaces
                local inputs = vim.fn.input(txt):gsub("^%s*(.-)%s*$", "%1")

                -- return nil if empty string
                if inputs == "" then return nil end

                -- accept comma-separated inputs
                local tbl = {}
                for m in string.gmatch(inputs, "[^,]+") do
                    local tmp = m
                    tmp = tmp:gsub("^%s*(.-)%s*$", "%1")
                    table.insert(tbl, tmp)
                end
                return tbl
            end

            vim.keymap.set("n", "<Leader>s*", function()
                require("telescope.builtin").grep_string({
                    search_dirs = input_to_table("Search Dirs > ")
                })
            end)
            vim.keymap.set("n", "<Leader>sg", function()
                require("telescope.builtin").live_grep({
                    search_dirs = input_to_table("Search Dirs > "),
                    glob_pattern = input_to_table("Globs > ")
                })
            end)
        end,
        config = function()
            -- use <Ctrl-l> to send selected to quickfix list
            local mappings = {
                i = {
                    ["<C-l>"] = "send_selected_to_qflist",
                    ["<C-d>"] = "delete_buffer",
                    ["<C-a>"] = "select_all",
                    ["<C-Down>"] = "cycle_history_next",
                    ["<C-Up>"] = "cycle_history_prev",
                },
                n = {
                    ["<C-l>"] = "send_selected_to_qflist",
                    ["<C-d>"] = "delete_buffer",
                    ["<C-a>"] = "select_all"
                }
            }

            -- use <Ctrl-o> to open all items with trouble
            local trouble = require("trouble.providers.telescope")

            vim.tbl_extend("force", mappings,
                {
                    i = { ["<C-o>"] = trouble.open_with_trouble },
                    n = { ["<C-o>"] = trouble.open_with_trouble }
                }
            )

            require("telescope").setup({
                defaults = {
                    mappings = mappings,
                    layout_strategy = "horizontal",
                    layout_config = {
                        prompt_position = "top"
                    },
                    sorting_strategy = "ascending"
                }
            })

            require("telescope").load_extension("fzf")
            require("telescope").load_extension("lazy")
        end
    },
    { "stevearc/dressing.nvim", event = "VeryLazy" },

    -- editing
    { "max397574/better-escape.nvim",
        event = "InsertEnter",
        config = {
            mapping = { "jk" }
        }
    },
    --DEK {
    --DEK     "windwp/nvim-autopairs",
    --DEK     event = "InsertEnter",
    --DEK     config = function()
    --DEK         local autopairs = require("nvim-autopairs")
    --DEK         autopairs.setup({
    --DEK             check_ts = true,
    --DEK             disable_filetype = { "TelescopePrompt" }
    --DEK         })

    --DEK         local cmp_autopairs = require("nvim-autopairs.completion.cmp")
    --DEK         local cmp_status_ok, cmp = pcall(require, "cmp")
    --DEK         if cmp_status_ok then
    --DEK             cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done({ map_char = { tex = "" } }))
    --DEK         end
    --DEK     end
    --DEK },
    { "terrortylor/nvim-comment",
        keys = { "gcc", "gc" },
        config = function()
            require('nvim_comment').setup()
        end
    },
    {
        "ggandor/leap.nvim",
        event = "VeryLazy",
        dependencies = {
            "ggandor/flit.nvim",
            "ggandor/leap-ast.nvim"
        },
        config = function()
            require("leap").set_default_keymaps()
            require("flit").setup({
                labeled_modes = "nv"
            })
            vim.keymap.set({"n", "x", "o"}, "M", function() require("leap-ast").leap() end)
        end
    },
    {
        "smjonas/inc-rename.nvim",
        cmd = "IncRename",
        config = function()
            require("inc_rename").setup()
        end,
    },
    { "kylechui/nvim-surround", event = "BufRead", config = { move_cursor = false } },
    {
        "ntpeters/vim-better-whitespace",
        cmd = {
            "EnableWhitespace",
            "DisableWhitespace",
            "StripWhitespace",
            "ToggleWhitespace",
            "ToggleStripWhitespaceOnSave"
        },
        keys = {
            -- <Leader>t[oggle]
            { "<Leader>tS", "<cmd>ToggleWhitespace<CR>" },
            { "<Leader>tx", "<cmd>StripWhitespace<CR>" },
            { "<Leader>tX", "<cmd>ToggleStripWhitespaceOnSave<CR>" }
        }
    },
    {
        "mg979/vim-visual-multi",
        keys = {
            { "<C-n>" }, { "<C-Up>" }, { "<C-Down>" }, { "g/" },
            {"<C-n>",    nil, "x"},
            {"<C-Up>",   nil, "x"},
            {"<C-Down>", nil, "x"},
            {"g/",       nil, "x"}
        }
    },
    { "chentoast/marks.nvim", config = true },
    {
        "wsdjeg/vim-fetch",
        keys = { "gF" }
    },
    {
        "windwp/nvim-spectre",
        dependencies = "nvim-lua/plenary.nvim",
        keys = {
            { "<Leader>s-", function() require("spectre").open() end }
        },
        config = true
    },
    {
        "mbbill/undotree",
        cmd = "UndotreeToggle" ,
        keys = {
            { "<Leader>tu", "<cmd>UndotreeToggle<CR>" }
        }
    },

    -- file management
    {
        "kyazdani42/nvim-tree.lua",
        cmd = { "NvimTree", "NvimTreeToggle", "NvimTreeFindFileToggle" },
        keys = {
            -- <Leader>f[iles]
            { "<Leader>fe", "<cmd>NvimTreeToggle<CR>" },
            { "<Leader>fl", "<cmd>NvimTreeFindFileToggle<CR>" },

            -- <Leader>t[oggle]
            { "<Leader>te", "<cmd>NvimTreeToggle<CR>" }
        },
        config = {
            hijack_netrw = true,
            hijack_cursor = true,

            sync_root_with_cwd = true,
            respect_buf_cwd = true,
            update_cwd = true,
            update_focused_file = {
                enable = true,
                update_cwd = true
            },

            diagnostics = { enable = false },
            actions = {
                open_file = {
                    quit_on_open = true
                }
            },
            view = {
                mappings = {
                    list = {
                        { key = "h", action = "close_node" },
                        { key = "l", action = "edit"}
                    }
                }
            }
        }
    },

    -- Treesitter
    {
        "nvim-treesitter/nvim-treesitter",
        event = "BufReadPost",
        dependencies = {
            "nvim-treesitter/nvim-treesitter-textobjects",
        },
        build = ":TSUpdate",
        config = function()
            require("nvim-treesitter.configs").setup({
                ensure_installed = {
                    "bash", "jsonc", "rust", "c", "cmake", "cpp", "css", "help",
                    "html", "javascript", "latex", "lua", "markdown", "python",
                    "r", "toml", "tsx", "typescript", "vue", "yaml"
                },
                sync_install = false,
                auto_install = false,
                additional_vim_regex_highlighting = false,
                highlight = { enable = true },
                autopairs = { enable = true },
                indent = { enable = true },
                incremental_selection = { enable = true },
                textobjects = {
                    select = {
                        enable = true,
                        -- automatically jump forward to textobj, similar to targets.vim
                        lookahead = true,
                        keymaps = {
                            -- capture groups defined in textobjects.scm
                            ["af"] = "@function.outer",
                            ["if"] = "@function.inner",
                            ["ac"] = "@class.outer",
                            ["ic"] = "@class.inner",
                            ["ai"] = "@conditional.outer",
                            ["ii"] = "@conditional.inner",
                            ["al"] = "@loop.outer",
                            ["il"] = "@loop.inner",
                            ["aa"] = "@parameter.outer",
                            ["ia"] = "@parameter.inner"
                        },
                    },
                    swap = {
                        enable = true,
                        swap_next = {
                            ["<Leader>an"] = "@parameter.inner"
                        },
                        swap_previous = {
                            ["<Leader>ap"] = "@parameter.inner"
                        }
                    },
                    move = {
                        enable = true,
                        set_jumps = true, -- whether to set jumps in the jumplist
                        goto_next_start = {
                            ["]f"] = "@function.outer",
                            ["]]"] = "@class.outer",
                            ["]i"] = "@conditional.outer",
                            ["]l"] = "@loop.outer"
                        },
                        goto_next_end = {
                            ["]F"] = "@function.outer",
                            ["]["] = "@class.outer",
                            ["]I"] = "@conditional.outer",
                            ["]L"] = "@loop.outer"
                        },
                        goto_previous_start = {
                            ["[f"] = "@function.outer",
                            ["[["] = "@class.outer",
                            ["[i"] = "@conditional.outer",
                            ["[l"] = "@loop.outer"
                        },
                        goto_previous_end = {
                            ["[F"] = "@function.outer",
                            ["[]"] = "@class.outer",
                            ["[I"] = "@conditional.outer",
                            ["[L"] = "@loop.outer"
                        }
                    }
                }
            })
        end
    },
    {
        "nvim-treesitter/nvim-treesitter-context",
        event = "BufReadPre",
        config = function()
            require("treesitter-context").setup()
        end,
    },
    {
        "andymass/vim-matchup",
        event = "BufReadPost",
        config = function()
            vim.g.matchup_matchparen_offscreen = { method = "status_manual" }
        end
    },

    -- Git
    {
        "lewis6991/gitsigns.nvim",
        event = "BufReadPre",
        dependencies = "nvim-lua/plenary.nvim",
        init = function()
            -- ][c to navigate hunks
            vim.keymap.set("n", "]c",
                function()
                    if vim.wo.diff then return ']c' end
                    vim.schedule(function() require("gitsigns").next_hunk({ preview = true }) end)
                    return '<Ignore>'
                end,
                { expr = true }
            )
            vim.keymap.set("n", "[c",
                function()
                    if vim.wo.diff then return '[c' end
                    vim.schedule(function() require("gitsigns").prev_hunk({ preview = true }) end)
                    return '<Ignore>'
                end,
                { expr = true }
            )

            -- <Leader>g[it]
            vim.keymap.set("n", "<Leader>gj", function() require("gitsigns").next_hunk({ preview = true }) end)
            vim.keymap.set("n", "<Leader>gk", function() require("gitsigns").prev_hunk({ preview = true }) end)
            vim.keymap.set("n", "<Leader>gs", function() require("gitsigns").stage_hunk() end)
            vim.keymap.set("v", "<Leader>gs", function() require("gitsigns").stage_hunk({vim.fn.line("."), vim.fn.line("v")}) end)
            vim.keymap.set("n", "<Leader>gr", function() require("gitsigns").reset_hunk() end)
            vim.keymap.set("v", "<Leader>gr", function() require("gitsigns").reset_hunk({vim.fn.line("."), vim.fn.line("v")}) end)
            vim.keymap.set("n", "<Leader>gl", function() require("gitsigns").setloclist() end)
            vim.keymap.set("n", "<Leader>gp", function() require("gitsigns").preview_hunk() end)
            vim.keymap.set("n", "<Leader>gu", function() require("gitsigns").undo_stage_hunk() end)
            vim.keymap.set("n", "<Leader>gR", function() require("gitsigns").reset_buffer() end)
            vim.keymap.set("n", "<Leader>gb", function() require("gitsigns").blame_line({ full = true }) end)

            -- ih for text object
            vim.keymap.set("o", "ih", function() require("gitsigns").select_hunk() end)
            vim.keymap.set("x", "ih", function() require("gitsigns").select_hunk() end)
        end,
        config = true
    },
    {
        "sindrets/diffview.nvim",
        cmd = { "DiffviewOpen", "DiffviewClose", "DiffviewToggleFiles", "DiffviewFocusFiles" },
        config = true
    },
    { "pwntester/octo.nvim", config = true, cmd = { "Octo" } },
    {
        "tpope/vim-fugitive",
        dependencies = "tpope/vim-rhubarb",
        cmd = { "Git", "Gdiffsplit", "Gwrite" },
        keys = {
            { "<Leader>gg", "<cmd>Git<CR>" },
            { "<Leader>gc", "<cmd>Git commit<CR>" },
            { "<Leader>gd", "<cmd>Gdiffsplit<CR>" },
            { "<Leader>gw", "<cmd>Gwrite<CR>" },
            { "<Leader>gP", "<cmd>Git push<CR>" }
        }
    },

    -- WhichKey
    {
        "folke/which-key.nvim",
        event = "VeryLazy",
        config = function()
            local whichkey = require("which-key")

            whichkey.setup({
                plugins = { spelling = { enable = true } },
                window = { border = "rounded" }
            })

            whichkey.register({
                b = {
                    name = "Buffer",
                    a = "Alpha",
                    b = "Search",
                    d = "Delete",
                    n = "Next",
                    p = "Previous",
                    N = "New",
                },
                f = {
                    name = "File",
                    f = "Search",
                    e = "NvimTree",
                    l = "Locate in NvimTree",
                    r = "Recent",
                    s = "Save",
                    R = "Source $MYVIMRC",
                    v = "Edit $MYVIMRC"
                },
                g = {
                    name = "Git",
                    c = "Commit",
                    g = "Status",
                    j = "Next Hunk",
                    k = "Prev Hunk",
                    s = "Stage Hunk",
                    r = "Reset Hunk",
                    p = "preview Hunk",
                    u = "Undo Hunk",
                    w = "Stage Buffer",
                    R = "Reset Buffer",
                    b = "Blame line",
                    d = "Diff",
                    S = "Status",
                    B = "Branches",
                    C = "Commits",
                    P = "Push",
                    l = "Changes to loclist"
                },
                l = {
                    name = "List",
                    a = "Code Action",
                    i = "Lsp Info",
                    I = "Lsp Install",
                    j = "Prev Diagnostic",
                    k = "Next Diagnostic",
                    l = "Codelens",
                    d = "Buffer Diagnostics",
                    w = "Workspace Diagnostics",
                    o = "Symbol Outline",
                    F = "Format Buffer",
                    r = "Rename in Buffer",
                },
                o = {
                    name = "Open",
                    q = "Quickfix",
                    l = "Location List"
                },
                s = {
                    name = "Search",
                    l = "Lines",
                    f = "Files",
                    b = "Buffers",
                    B = "Git Branches",
                    C = "Colorschemes",
                    h = "Help Tags",
                    M = "Manuals",
                    r = "Rencent Files",
                    R = "Registers",
                    k = "Key Maps",
                    c = "Commands",
                    g = "Live Grep",
                    n = "No Search Highlight",
                    m = "Marks",
                    P = "Resume",
                    s = "Symbols",
                    S = "Workspace Symbols",
                    ["/"] = "Search History",
                    ["*"] = "Grep String"
                },
                t = {
                    name = "Toggle",
                    e = "NvimTree",
                    c = "Colorcolumn",
                    s = "WhiteSpace",
                    t = "Trouble",
                    f = "Float Terminal",
                    h = "Horizontal Terminal",
                    v = "Vertical Terminal",
                    l = "Linenumber",
                    ["\\"] = "Path Slash",
                },
                w = {
                    name = "Windows",
                    w = "Next",
                    c = "Close",
                    ["-"] = "Split Horizontal",
                    ["|"] = "Split Vertical",
                    s = "Split Horizontal",
                    v = "Split Vertical",
                    h = "Left",
                    j = "Below",
                    l = "Right",
                    k = "Below",
                    o = "Only",
                    H = "Resize Left",
                    L = "Resize Right",
                    J = "Resize Above",
                    K = "Resize Below",
                    S = "Shift Window",
                    ["="] = "Resize Equally",
                },
                q = {
                    name = "Quit"
                }

            }, { prefix = "<leader>" })
        end
    },

    -- R
    {
        "jalvesaq/R-Vim-runtime",
        ft = { "r", "rmd", "rnoweb", "rout", "rhelp" }
    },
    {
        "jalvesaq/Nvim-R",
        event = "VeryLazy",
        dependencies = { "jalvesaq/R-Vim-runtime" },
        ft = { "r", "rmd", "rnoweb", "rout", "rhelp" },
        config = function()
            -- do not update $HOME on Windows since I set it manually
            if vim.fn.has("win32") == 1 then
                vim.g.R_set_home_env = 0
            end

            -- disable debugging support,
            vim.g.R_debug = 1
            -- do not align function arguments
            vim.g.r_indent_align_args = 0
            -- use two backticks to trigger the Rmarkdown chunk completion
            vim.g.R_rmdchunk = "``"
            -- use <Alt>- to insert assignment
            vim.g.R_assign_map = "<M-->"
            -- show hidden objects in object browser
            vim.g.R_objbr_allnames = 1
            -- show comments when sourced
            vim.g.R_commented_lines = 1
            -- use the same working directory as Vim
            vim.g.R_nvim_wd = 1
            -- highlight chunk header as R code
            vim.g.rmd_syn_hl_chunk = 1
            -- only highlight functions when followed by a parenthesis
            vim.g.r_syntax_fun_pattern = 1
            -- set encoding to UTF-8 when sourcing code
            vim.g.R_source_args = 'echo = TRUE, spaced = TRUE, encoding = "UTF-8"'
            -- number of columns to be offset when calculating R terminal width
            vim.g.R_setwidth = -7
            -- manually set the R path since scoop did not write registry entries about R
            if string.lower(jit.os) == "windows" then
                local scoop_r = require("plenary.path").new(vim.loop.os_homedir(), "scoop", "apps", "r")
                if scoop_r:exists() then
                    vim.g.R_path = scoop_r:joinpath("current", "bin").filename:gsub("\\", "/")
                end
            end

            -- auto quit R when close Vim
            vim.cmd[[
                autocmd VimLeave * if exists("g:SendCmdToR") && string(g:SendCmdToR) != "function('SendCmdToR_fake')" | call RQuit("nosave") | endif
            ]]

            -- helper function to detect if current buffer is an R terminal
            -- created by Nvim-R
            local IsRTerm = function(buffer)
                local buf = buffer == nil and 0 or buffer

                if vim.api.nvim_buf_get_option(buf, "buftype") == "terminal" then
                    local bufname = vim.api.nvim_buf_get_name(buf)
                    -- this is a R termial created by NVim-R
                    if string.find(bufname, "^term://.+//%d+:R%s?$") then
                        return true
                    else
                        return false
                    end
                else
                    return false
                end
            end

            -- assign and pipe
            local r_set_keymap_pipe = function (buffer)
                local buf = buffer == nil and 0 or buffer
                vim.keymap.set("i", "<M-->", "<C-v><Space><-<C-v><Space>", { buffer = buf })
                vim.keymap.set("i", "<M-=>", "<C-v><Space>%>%<C-v><Space>", { buffer = buf })
                vim.keymap.set("i", "<M-\\>", "<C-v><Space>|><C-v><Space>", { buffer = buf })
                vim.keymap.set("i", "<M-;>", "<C-v><Space>:=<C-v><Space>", { buffer = buf })
            end

            -- {targets}
            local r_set_keymap_targets = function (buffer)
                local buf = buffer == nil and 0 or buffer
                vim.keymap.set("n", "<LocalLeader>tm", "<cmd>RSend targets::tar_make()<CR>", { buffer = buf })
                vim.keymap.set("n", "<LocalLeader>tM", "<cmd>RSend targets::tar_make(callr_function = NULL)<CR>", { buffer = buf })
                vim.keymap.set("n", "<LocalLeader>tf", "<cmd>RSend targets::tar_make_future(workers = parallelly::availableCores() - 1L)<CR>", { buffer = buf })
            end

            -- debug
            local r_set_keymap_debug = function (buffer)
                local buf = buffer == nil and 0 or buffer
                vim.keymap.set("n", "<LocalLeader>tb", "<cmd>RSend traceback()<CR>", { buffer = buf })
                vim.keymap.set("n", "<LocalLeader>sq", "<cmd>RSend Q<CR>", { buffer = buf })
                vim.keymap.set("n", "<LocalLeader>sc", "<cmd>RSend c<CR>", { buffer = buf })
                vim.keymap.set("n", "<LocalLeader>sn", "<cmd>RSend n<CR>", { buffer = buf })
            end

            -- add keymap for quit R if current window is an R terminal
            vim.api.nvim_create_autocmd(
                { "BufEnter", "BufWinEnter" },
                {
                    group = vim.api.nvim_create_augroup("RTermSetup", {}),
                    pattern = "*",
                    callback = function(args)
                        -- if current buffer is an R terminal
                        if IsRTerm(args.buf) then
                            -- set keymap to quit R
                            vim.keymap.set("n", "<LocalLeader>rq", "<cmd>call RQuit('nosave')<CR>", { buffer = args.buf })

                            -- set other keymap
                            r_set_keymap_targets(args.buf)
                            r_set_keymap_debug(args.buf)
                        end
                    end
                }
            )

            vim.api.nvim_create_autocmd(
                { "BufEnter", "BufWinEnter" },
                {
                    group = vim.api.nvim_create_augroup("RCommonSetup", {}),
                    pattern = { "*.r", "*.R", "*.rmd", "*.Rmd", "*.qmd" },
                    callback = function()
                        -- set roxygen comment string
                        vim.opt_local.comments:append("b:#'")

                        -- insert current comment leader
                        vim.opt_local.formatoptions:append("r")

                        -- nvim-lspconfig set formatexpr to use lsp formatting,
                        -- which breaks gq for comments
                        vim.opt_local.formatexpr = nil
                    end
                }
            )

            -- keymaps for inserting pipes and debugging
            vim.api.nvim_create_autocmd(
                { "BufEnter", "BufWinEnter" },
                {
                    group = vim.api.nvim_create_augroup("RKeymapSetup", {}),
                    pattern = { "*.r", "*.R", "*.rmd", "*.Rmd", "*.qmd" },
                    callback = function()
                        vim.wo.colorcolumn = "150"
                        r_set_keymap_pipe()
                        r_set_keymap_targets()
                        r_set_keymap_debug()
                    end
                }
            )

            vim.api.nvim_create_autocmd(
                { "BufEnter", "BufWinEnter" },
                {
                    group = vim.api.nvim_create_augroup("RMarkdownSetup", {}),
                    pattern = { "*.rmd", "*.Rmd" },
                    callback = function()
                        -- wrap long lines
                        vim.wo.wrap = true

                        function RToggleRmdEnv()
                            -- get current value
                            local env = vim.g.R_rmd_environment

                            if env == ".GlobalEnv" then
                                env = "new.env()"
                            else
                                env = ".GlobalEnv"
                            end
                            vim.g.R_rmd_environment = env

                            print("Rmd will be rendered in an empty environment.")
                        end

                        vim.keymap.set("n", "<LocalLeader>re", RToggleRmdEnv, { buffer = 0 })
                    end
                }
            )
        end
    },
    {
        "mllg/vim-devtools-plugin",
        dependencies = "jalvesaq/Nvim-R",
        ft = { "r", "rmd", "rnoweb", "rout", "rhelp" },
        config = function()
            -- helper function to detect if current buffer is an R terminal
            -- created by Nvim-R
            local IsRTerm = function(buffer)
                local buf = buffer == nil and 0 or buffer

                if vim.api.nvim_buf_get_option(buf, "buftype") == "terminal" then
                    local bufname = vim.api.nvim_buf_get_name(buf)
                    -- this is a R termial created by NVim-R
                    if string.find(bufname, "^term://.+//%d+:R%s?$") then
                        return true
                    else
                        return false
                    end
                else
                    return false
                end
            end

            -- devtools
            local r_set_keymap_devtools = function(buffer)
                local buf = buffer == nil and 0 or buffer
                vim.keymap.set("n", "<LocalLeader>da", "<cmd>RLoadPackage<CR>", { buffer = buf })
                vim.keymap.set("n", "<LocalLeader>dd", "<cmd>RDocumentPackage<CR>", { buffer = buf })
                vim.keymap.set("n", "<LocalLeader>dt", "<cmd>RTestPackage<CR>", { buffer = buf })
                vim.keymap.set("n", "<LocalLeader>dc", "<cmd>RCheckPackage<CR>", { buffer = buf })
                vim.keymap.set("n", "<LocalLeader>dr", "<cmd>RSend devtools::build_readme()<CR>", { buffer = buf })
                vim.keymap.set("n", "<LocalLeader>dI", "<cmd>RInstallPackage<CR>", { buffer = buf })
            end

            -- keymap for package development
            vim.api.nvim_create_autocmd(
                { "BufEnter", "BufWinEnter" },
                {
                    group = vim.api.nvim_create_augroup("RDevtoolsSetup", {}),
                    pattern = { "*.r", "*.R" },
                    callback = function(args)
                        -- {devtools}
                        r_set_keymap_devtools(args.buf)

                        -- redefine test current file
                        vim.keymap.set("n", "<LocalLeader>df",
                            function()
                                local curfile = vim.fn.substitute(vim.fn.expand('%:p'), '\\', '/', "g")
                                if vim.bo.filetype ~= "r" then
                                    vim.fn['RWarningMsg']("Current file is not an R script.")
                                    return
                                end
                                vim.fn['devtools#send_cmd']('devtools::test_active_file("' .. curfile .. '")')
                            end,
                            { buffer = 0 }
                        )
                    end
                }
            )

            vim.api.nvim_create_autocmd(
                { "BufEnter", "BufWinEnter" },
                {
                    group = vim.api.nvim_create_augroup("RTermDevtoolsSetup", {}),
                    pattern = "*",
                    callback = function(args)
                        -- if current buffer is an R terminal
                        if IsRTerm(args.buf) then
                            -- {devtools}
                            r_set_keymap_devtools(args.buf)
                        end
                    end
                }
            )
        end
    }
},
{
    -- lazy load all plugins by default
    defaults = {
        lazy = true
    },

    --DEK install = {
    --DEK     colorscheme = { "tokyonight" }
    --DEK },

    performance = {
        rtp = {
            disabled_plugins = {
                "gzip", "matchit", "matchparen", "netrwPlugin", "tohtml",
                "tutor", "tarPlugin", "zipPlugin"
            }
        }
    }
}
)

