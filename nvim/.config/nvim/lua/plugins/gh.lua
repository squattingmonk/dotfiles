-- snacks.nvim renders GitHub issues/PRs into `markdown.gh` buffers that
-- soft-wrap by design, but Neovim can only wrap at the window edge -- see
-- `:h 'wrap'`, "lines longer than the width of the window will wrap". Nothing
-- breaks a line at 'textwidth' without inserting a real <EOL>, so instead pin
-- the window to that many columns and park a blank filler window to its right.
--
-- no-neck-pain.nvim was the obvious candidate, but it halves the leftover
-- columns into its side buffers, so with only one side enabled (what
-- left-aligning needs) the centred window can never get narrower than about
-- half the screen -- ~94 columns of text on a 200 column terminal.

local GH_FILETYPE = "markdown.gh"
local PAD_FILETYPE = "ghpad"

local function textwidth()
  return vim.o.textwidth > 0 and vim.o.textwidth or 80
end

---@return integer[] windows in this tabpage, floats excluded
local function windows()
  return vim.tbl_filter(function(win)
    return vim.api.nvim_win_get_config(win).relative == ""
  end, vim.api.nvim_tabpage_list_wins(0))
end

-- Floats are skipped so the picker's own gh preview -- also a `markdown.gh`
-- buffer -- can't drag the filler open behind it.
local function win_by_ft(filetype)
  for _, win in ipairs(windows()) do
    if vim.bo[vim.api.nvim_win_get_buf(win)].filetype == filetype then
      return win
    end
  end
end

local function open_pad()
  local buf = vim.api.nvim_create_buf(false, true)
  vim.bo[buf].filetype = PAD_FILETYPE
  vim.bo[buf].bufhidden = "wipe"
  -- `win = -1` splits the full height of the tabpage, so the filler always
  -- lands at the far right rather than inside the current column.
  local win = vim.api.nvim_open_win(buf, false, { split = "right", win = -1 })
  for opt, value in pairs({
    number = false,
    relativenumber = false,
    signcolumn = "no",
    foldcolumn = "0",
    statuscolumn = "",
    colorcolumn = "",
    cursorline = false,
    list = false,
    wrap = false,
    spell = false,
  }) do
    vim.api.nvim_set_option_value(opt, value, { win = win, scope = "local" })
  end
  return win
end

-- Reentrancy guard: every window we open, close or resize below fires the very
-- autocmds that call this.
local syncing = false

-- Narrower than this and a filler is just stealing columns from the issue.
local MIN_PAD_WIDTH = 12

local function drop_pad(pad)
  if not pad then
    return
  end
  if #windows() > 1 then
    vim.api.nvim_win_close(pad, true)
  else
    -- Closing the last window would quit; hand it a normal buffer instead.
    vim.api.nvim_win_call(pad, function()
      vim.cmd("enew")
    end)
  end
end

local function sync()
  if syncing then
    return
  end
  syncing = true
  local ok, err = pcall(function()
    local gh = win_by_ft(GH_FILETYPE)
    local pad = win_by_ft(PAD_FILETYPE)

    local info = gh and vim.fn.getwininfo(gh)[1]
    if not info then
      return drop_pad(pad)
    end

    -- On a terminal too narrow to hold the text plus a worthwhile filler, back
    -- off entirely: full width wrapping at the window edge beats an 80 column
    -- column squeezed further by a sliver of padding.
    local target = textwidth() + info.textoff
    local fixed = vim.o.columns >= target + MIN_PAD_WIDTH
    vim.api.nvim_set_option_value(
      -- Holding the width through `equalalways` redistribution is what makes a
      -- split alongside take its columns from the filler, not from the issue.
      "winfixwidth",
      fixed,
      { win = gh, scope = "local" }
    )
    if not fixed then
      return drop_pad(pad)
    end

    -- Without something to its right there is nothing to absorb the slack: a
    -- lone window always fills the screen no matter what width we ask for.
    if not pad and #windows() == 1 then
      open_pad()
    end

    if info.width ~= target then
      vim.api.nvim_win_set_width(gh, target)
    end
  end)
  syncing = false
  if not ok then
    vim.notify("gh reading width: " .. tostring(err), vim.log.levels.WARN)
  end
end

return {
  {
    -- Only meaningful alongside snacks' gh buffers, so hang it off that spec.
    "folke/snacks.nvim",
    optional = true,
    init = function()
      vim.api.nvim_create_autocmd({
        "BufWinEnter",
        "BufWinLeave",
        "WinNew",
        "WinClosed",
        "TabEnter",
        "VimResized",
      }, {
        group = vim.api.nvim_create_augroup(
          "gh_reading_width",
          { clear = true }
        ),
        -- Deferred: on BufWinLeave/WinClosed the window is still listed, so
        -- the lookups above would read stale state.
        callback = vim.schedule_wrap(sync),
      })
    end,
  },
}
