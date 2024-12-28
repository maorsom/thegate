vim.g.mapleader = " "
vim.g.maplocalleader = " "

vim.g.have_nerd_font = true

-- Make line number on the left
vim.opt.relativenumber = true
vim.opt.number = true

--Enable mouse
vim.opt.mouse = "a"

-- Disable show mode,  will be visibale on statusline
vim.opt.showmode = false

vim.opt.clipboard = "unnamedplus"

vim.opt.breakindent = true

vim.opt.undofile = true

vim.opt.ignorecase = true
vim.opt.smartcase = true

vim.opt.signcolumn = "yes"

vim.opt.updatetime = 250

vim.opt.timeoutlen = 300

vim.opt.splitright = true
vim.opt.splitbelow = true

--vim.opt.list = true
--vim.opt.listchars = { tab = "» ", trail = "·", nbsp = "␣" }

vim.opt.inccommand = "split"

vim.opt.cursorline = true

vim.opt.scrolloff = 10

vim.opt.tabstop = 2 -- spaces for tabs
vim.opt.shiftwidth = 2 -- space for indent width
vim.opt.expandtab = true -- expand tab to spaces
vim.opt.autoindent = true -- copy indent from current line when starting new line

vim.opt.wrap = false

vim.opt.swapfile = false

vim.opt.hlsearch = true

vim.filetype.add({ extension = { templ = "templ" } })
