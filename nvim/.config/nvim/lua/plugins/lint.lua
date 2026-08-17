-- snacks.nvim renders GitHub issues/PRs into `markdown.gh` buffers that
-- soft-wrap by design (`wrap`/`linebreak` are on, see `Snacks.gh.config().wo`),
-- so every paragraph is one very long line. markdownlint has no idea and flags
-- all of them. Drop the rules that only make sense for hard-wrapped files we
-- actually own.
local gh_ignored_rules = {
  MD013 = true, -- line-length
}

-- gh buffers are tagged with `b:snacks_gh` by both `snacks.gh.buf` and the
-- picker's diff preview.
local function is_gh_buf(buf)
  return buf and vim.api.nvim_buf_is_valid(buf) and vim.b[buf].snacks_gh ~= nil
end

local function rule_of(diagnostic)
  return tostring(diagnostic.message):match("^(MD%d+)/")
end

return {
  {
    "mfussenegger/nvim-lint",
    opts = function(_, opts)
      -- Grab the pristine parser now: LazyVim's config swaps
      -- `lint.linters["markdownlint-cli2"]` for a merged copy containing the
      -- override below, so looking it up later would recurse.
      local parse = require("lint.linters.markdownlint-cli2").parser

      opts.linters = opts.linters or {}
      opts.linters["markdownlint-cli2"] =
        vim.tbl_deep_extend("force", opts.linters["markdownlint-cli2"] or {}, {
          parser = function(output, bufnr, cwd)
            local diagnostics = parse(output, bufnr, cwd)
            if not is_gh_buf(bufnr) then
              return diagnostics
            end
            return vim.tbl_filter(function(diagnostic)
              return not gh_ignored_rules[rule_of(diagnostic)]
            end, diagnostics)
          end,
        })
    end,
  },
}
