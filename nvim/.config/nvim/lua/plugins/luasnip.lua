require("luasnip").config.set_config {
  history = true,
  updateevents = "TextChanged,TextChangedI",
}
require("luasnip.loaders.from_snipmate").lazy_load()