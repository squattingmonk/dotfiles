local opts = {
  -- Convenience
	mouse = "a", -- enable mouse

  -- Appearance
  termguicolors = true, -- use true color
  cursorline = true, -- highlight current line
  textwidth = 80, -- width text is expected to be
  colorcolumn = "+1", -- place line after 80th column
  wrap = false, -- diable wordwrap

  -- Folding
  foldenable = false, -- disable folding by default

  -- Window splits
  splitbelow = true, -- open new vertical splits on bottom
  splitright = true, -- open new horizontal splits to the right

  -- Scrolling
  scrolloff = 8, -- show x lines below cursor when scrolling
  sidescrolloff = 8, -- show x columns beyond cursor when scrolling

  -- Line numbers
  relativenumber = false, -- show relative lines numbers
  number = true, -- show line number of current line
  signcolumn = "yes", -- show the sign column

  -- Tab-key behavior
	shiftwidth = 2, -- number of spaces for each level of indentation
	tabstop = 2, -- number of spaces in a tab
	expandtab = true, -- replace tabs with spaces
  smartindent = true, -- nice autoindenting

  -- Search
  ignorecase = true, -- ignore case when searching
  smartcase = true, -- ...unless uppercase is used in search term
  hlsearch = false, -- do not highlight previous search term

  -- Clipboard
  clipboard = "unnamedplus", -- use system clipboard

  -- Special files
  backup = false, -- do not create a backup file
  swapfile = false, -- do not create a swapfile
  undofile = true, -- enable persistent undo

  -- Spell Checking
  -- medical spellfile from https://github.com/melvio/medical-spell-files
  spelllang = "en_us,medical", -- dictionaries for spell checking
  spellfile = os.getenv("HOME") .. "/Sync/vim/spell/en.utf-8.add", -- extra words

}

for key, val in pairs(opts) do
	vim.opt[key] = val
end
