local M = {}

M.map = function(mode, keys, command, opt)
  local options = { silent = true, noremap = true }
  if opt then
    options = vim.tbl_extend("force", options, opt)
  end

  -- Valid modes for mappings. See :h map-modes
  local modes = { "", "n", "v", "s", "x", "o", "!", "i", "l", "c", "t" }

  -- helper function for M.map
  -- can gives multiple modes and keys
  local function map_wrapper(sub_mode, lhs, rhs, sub_options)
    if type(lhs) == "table" then
      for _, key in ipairs(lhs) do
        map_wrapper(sub_mode, key, rhs, sub_options)
      end
    else
      if type(sub_mode) == "table" then
        for _, m in ipairs(sub_mode) do
          map_wrapper(m, lhs, rhs, sub_options)
        end
      else
        if vim.tbl_contains(modes, sub_mode) and lhs and rhs then
          vim.api.nvim_set_keymap(sub_mode, lhs, rhs, sub_options)
        else
          sub_mode, lhs, rhs = sub_mode or "", lhs or "", rhs or ""
          print(
            "Cannot set mapping [ mode = '" .. sub_mode .. "' | key = '" .. lhs .. "' | cmd = '" .. rhs .. "' ]"
          )
        end
      end
    end
  end

   map_wrapper(mode, keys, command, options)
 end

return M
