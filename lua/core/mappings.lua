local keymap = vim.keymap
local opts = { noremap = true, silent = true }
local function termcodes(str)
  return vim.api.nvim_replace_termcodes(str, true, true, true)
end

local M = {}
M.Lspsaga = {
  keymap.set('n', '<C-e>', '<Cmd>Lspsaga show_line_diagnostics<CR>', opts),
  keymap.set('n', '<leader>k', '<Cmd>Lspsaga hover_doc<CR>', opts),
  keymap.set('n', '<C-f>', '<Cmd>Lspsaga lsp_finder<CR>', opts),
  keymap.set('n', '<C-r>', '<Cmd>Lspsaga rename<CR>', opts),
  keymap.set('n', '<C-o>', '<Cmd>Lspsaga outline<CR>', opts),
  keymap.set('n', '<C-l>', '<Cmd>Lspsaga code_action<CR>', opts),
  keymap.set('n', ']]', '<Cmd>Lspsaga diagnostic_jump_next<CR>', opts),
  keymap.set('n', '[[', '<Cmd>Lspsaga diagnostic_jump_prev<CR>', opts),
}
M.general = {
  n = {
    keymap.set("n", "==", "<cmd>lua require('jc.jdtls').generate_toString()<CR>", opts),
    keymap.set("n", "--",
      "<cmd>lua require('jc.jdtls').generate_constructor(nil, nil, {default = false})<CR>", opts),
    keymap.set('n', 'te', ':tabedit'),
    keymap.set('n', 'ss', ':split<Return><C-w>w'),
    keymap.set('n', 'sv', ':vsplit<Return><C-w>w'),
    keymap.set('n', '<C-a>', 'gg<S-v>G'),
    keymap.set('', '<C-q>', ':q!<CR>'),
    keymap.set("n", "<Tab>", "<Cmd>BufferLineCycleNext<CR>", {}),
    keymap.set("n", "<S-Tab>", "<Cmd>BufferLineCyclePrev<CR>", {}),
    keymap.set('n', '<C-left>', 'b'),
    keymap.set('n', '<C-right>', 'w'),
    keymap.set('v', '<C-left>', 'b'),
    keymap.set('v', '<C-right>', 'w'),

    ["<C-s>"] = { "<cmd> w <CR>", "save file" },
    [",,"] = { "<cmd> bprevious <CR>", "Pre buffer" },
    [".."] = { "<cmd> bnext <CR>", "Next buffer" },
    ["tt"] = { "<cmd> bd <CR>", "exit tab" },
    ["<leader>l"] = { "<cmd> Gitsigns blame_line <CR>", "Blame_line" },
    ["<leader>dt"] = { "<cmd> Gitsigns diffthis <CR>", "Diff this" },
    ["<leader>rb"] = { "<cmd> Gitsigns reset_buffer <CR>", "Reset buffer" },
    ["<leader>f"] = { "<cmd> Gitsigns refresh <CR>", "Refresh" },

    -- line numbers
    ["<leader>n"] = { "<cmd> set nu! <CR>", "toggle line number" },
    ["<leader>rn"] = { "<cmd> set rnu! <CR>", "toggle relative number" },

    -- Allow moving the cursor through wrapped lines with j, k, <Up> and <Down>
    -- http://www.reddit.com/r/vim/comments/2k4cbr/problem_with_gj_and_gk/
    -- empty mode is same as using <cmd> :map
    -- also don't use g[j|k] when in operator pending mode, so it doesn't alter d, y or c behaviour
    ["j"] = { 'v:count || mode(1)[0:1] == "no" ? "j" : "gj"', opts = { expr = true } },
    ["k"] = { 'v:count || mode(1)[0:1] == "no" ? "k" : "gk"', opts = { expr = true } },
    ["<Up>"] = { 'v:count || mode(1)[0:1] == "no" ? "k" : "gk"', opts = { expr = true } },
    ["<Down>"] = { 'v:count || mode(1)[0:1] == "no" ? "j" : "gj"', opts = { expr = true } },

  },

  t = { ["<C-x>"] = { termcodes "<C-\\><C-N>", "escape terminal mode" } },

  v = {
    ["<Up>"] = { 'v:count || mode(1)[0:1] == "no" ? "k" : "gk"', opts = { expr = true } },
    ["<Down>"] = { 'v:count || mode(1)[0:1] == "no" ? "j" : "gj"', opts = { expr = true } },
  },

  x = {
    ["j"] = { 'v:count || mode(1)[0:1] == "no" ? "j" : "gj"', opts = { expr = true } },
    ["k"] = { 'v:count || mode(1)[0:1] == "no" ? "k" : "gk"', opts = { expr = true } },
    -- Don't copy the replaced text after pasting in visual mode
    -- https://vim.fandom.com/wiki/Replace_a_word_with_yanked_text#Alternative_mapping_for_paste
    ["p"] = { 'p:let @+=@0<CR>:let @"=@0<CR>', opts = { silent = true } },
  },
}

M.comment = {
  plugin = true,

  -- toggle comment in both modes
  n = {
    ["<leader>/"] = {
      function()
        require("Comment.api").toggle.linewise.current()
      end,
      "toggle comment",
    },
  },

  v = {
    ["<leader>/"] = {
      "<ESC><cmd>lua require('Comment.api').toggle.linewise(vim.fn.visualmode())<CR>",
      "toggle comment",
    },
  },
}

M.nvimtree = {
  plugin = true,

  n = {
    -- toggle
    ["<C-n>"] = { "<cmd> NvimTreeToggle <CR>", "toggle nvimtree" },
  },
}

M.telescope = {
  plugin = true,

  n = {
    -- find
    [";f"] = { "<cmd> Telescope find_files follow=true no_ignore=true hidden=true <CR>", "find all" },
    [";r"] = { "<cmd> Telescope live_grep <CR>", "live grep" },
    [";o"] = { "<cmd> Telescope oldfiles <CR>", "find oldfiles" },
    ["K"] = { "<cmd> Telescope keymaps <CR>", "show keys" },
    [";;"] = { "<cmd> Telescope lsp_document_symbols <CR>", "Find symbols" },
    [";e"] = { "<cmd> Telescope diagnostics <CR>", "Find error" },

    -- git
    ["<leader>cm"] = { "<cmd> Telescope git_commits <CR>", "git commits" },
    ["<leader>gt"] = { "<cmd> Telescope git_status <CR>", "git status" },
  },
}

M.gitsigns = {
  plugin = true,

  n = {
    -- Navigation through hunks
    ["]c"] = {
      function()
        if vim.wo.diff then
          return "]c"
        end
        vim.schedule(function()
          require("gitsigns").next_hunk()
        end)
        return "<Ignore>"
      end,
      "Jump to next hunk",
      opts = { expr = true },
    },

    ["[c"] = {
      function()
        if vim.wo.diff then
          return "[c"
        end
        vim.schedule(function()
          require("gitsigns").prev_hunk()
        end)
        return "<Ignore>"
      end,
      "Jump to prev hunk",
      opts = { expr = true },
    },

    -- Actions
    ["<leader>rh"] = {
      function()
        require("gitsigns").reset_hunk()
      end,
      "Reset hunk",
    },

    ["<leader>p"] = {
      function()
        require("gitsigns").preview_hunk()
      end,
      "Preview hunk",
    },

    ["td"] = {
      function()
        require("gitsigns").toggle_deleted()
      end,
      "Toggle deleted",
    },
  },
}
return M
