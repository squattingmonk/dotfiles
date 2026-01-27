local util = require("lspconfig.util")
local configs = require("lspconfig.configs")

if not configs.nwscript then
  configs.nwscript = {
    default_config = {
      cmd = { "nwscriptd" },
      filetypes = { "nwscript" },
      root_dir = util.root_pattern("nasher.cfg", ".git"),
    },
  }
end

return {
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        nwscript = {
          settings = {
            ["nwscript-ee-lsp"] = {
              autoCompleteFunctionsWithParams = false,
              includeCommentsInFunctionsHover = true,
              formatter = {
                enabled = false,
              },
              compiler = {
                enabled = true,
                verbose = true,
                nwnHome = os.getenv("XDG_DATA_HOME") .. "/Neverwinter Nights",
                nwnInstallation = os.getenv("STEAM_PATH")
                  .. "/Neverwinter Nights",
              },
            },
          },
        },
      },
    },
  },
}
