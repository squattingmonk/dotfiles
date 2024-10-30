-- Most options are set automatically by LazyVim.

vim.g.mapleader = "\\"
vim.g.localmapleader = "\\"

-- Show gutter after column 80
vim.opt.textwidth = 80
vim.opt.colorcolumn = "+1"

-- Spelling
-- medical spellfile from https://github.com/melvio/medical-spell-files
vim.opt.spelllang = { "en_us", "medical" }
vim.opt.spellfile = os.getenv("HOME") .. "/Sync/vim/spell/en.utf-8.add" -- extra words
vim.opt.spelloptions = "camel" -- Split camelCase words when spellchecking

vim.lsp.inlay_hint.enable(false, nil)
