local map = require("utils").map

-- Non-plugin keymaps
vim.g.mapleader = "\\"

-- Quickly quit, with or without saving
map("n", "<leader>q", ":confirm quit<cr>")
map("n", "<leader>Q", ":quitall!<cr>")

-- Make j and k move by rows instead of lines (for wrapped text) unless a
-- count is given. We also disable in operator-pending mode to ensure d, y,
-- and c behave as normal.
map({}, "j", 'v:count || mode(1)[0:1] == "no" ? "j" : "gj"', { expr = true })
map({"n", "x", "o"}, "k", 'v:count || mode(1)[0:1] == "no" ? "k" : "gk"', { expr = true })
map("", "<Down>", 'v:count || mode(1)[0:1] == "no" ? "j" : "gj"', { expr = true })
map("", "<Up>", 'v:count || mode(1)[0:1] == "no" ? "k" : "gk"', { expr = true })

-- Use jj and kk as escape
map("i", "jj", "<Esc>")
map("i", "kk", "<Esc>")

-- Use <Esc> to turn off search highlighting
map("n", "<Esc>", ":noh<CR>")

-- Add lines above or below in normal mode
map("n", "go", "o<Esc>k")
map("n", "gO", "O<Esc>j")

-- Better window navigation
map("n", "<C-h>", "<C-w>h")
map("n", "<C-j>", "<C-w>j")
map("n", "<C-k>", "<C-w>k")
map("n", "<C-l>", "<C-w>l")

-- Resize with arrows
map("n", "<C-Up>", ":resize -2<CR>")
map("n", "<C-Down>", ":resize +2<CR>")
map("n", "<C-Left>", ":vertical resize -2<CR>")
map("n", "<C-Right>", ":vertical resize +2<CR>")

-- Navigate buffers
map("n", "<S-l>", ":bnext<CR>")
map("n", "<S-h>", ":bprevious<CR>")

-- Move text up and down
map("n", "<A-j>", "<Esc>:m .+1<CR>==")
map("n", "<A-k>", "<Esc>:m .-2<CR>==")

-- Stay in visual mode after indenting
map("v", "<", "<gv")
map("v", ">", ">gv")

-- Move text up and down
map("v", "<A-j>", ":m .+1<CR>==")
map("v", "<A-k>", ":m .-2<CR>==")

-- Move text up and down
map("x", "J", ":move '>+1<CR>gv-gv")
map("x", "K", ":move '<-2<CR>gv-gv")

-- Keep copied text when pasting in visual mode
map("v", "p", '"_dP')






-- Plugin-related keymaps
-- TODO: split into separate files

-- Packer
map("n", "<leader>ps", ":PackerSync<cr>")

-- Telescope
map("n", "<leader>ff", ":Telescope find_files<cr>")
map("n", "<leader>fa", ":Telescope find_files follow=true no_ignore=true hidden=true<cr>")
map("n", "<leader>fb", ":Telescope buffers<cr>")

-- Tree-sitter
map("n", "<leader>tp", ":TSPlaygroundToggle<cr>")
map("n", "<leader>th", ":TSHighlightCapturesUnderCursor<cr>")

-- Neogen
map("n", "<leader>nf", ":lua require('neogen').generate()<cr>")

-- Neotree
map("n", "<leader>e", ":Neotree toggle<cr>")

-- Color scheme
map("n", "<leader>cc", ":lua require('plugins.nordic').setup()<cr>")

map({"n", "x"}, "ga", "<Plug>(EasyAlign)", { noremap = false })
