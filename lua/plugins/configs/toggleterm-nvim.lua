local status, toggleterm = pcall(require, "toggleterm")
if (not status) then return end
require("toggleterm").setup {
  size = 6,
  open_mapping = [[<c-\>]],
  shade_terminals = true, -- NOTE: this option takes priority over highlights specified so if you specify Normal highlights you should set this to false
  shading_factor = 1, -- the degree by which to darken to terminal colour, default: 1 for dark backgrounds, 3 for light
  start_in_insert = true,
  persist_size = true,
  direction = 'horizontal',
  shell = "pwsh.exe -NoLogo";
}
