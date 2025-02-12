local ok, wk = pcall(require, "which-key")
if not ok then
  return
end

local org = require("configs.org")
local map = require("helpers").map

wk.setup({
  plugins = {
    marks = true, -- shows a list of your marks on ' and `
    registers = true, -- shows your registers on " in NORMAL or <C-r> in INSERT mode
    -- the presets plugin, adds help for a bunch of default keybindings in Neovim
    -- No actual key bindings are created
    presets = {
      operators = false, -- adds help for operators like d, y, ... and registers them for motion / text object completion
      motions = true, -- adds help for motions
      text_objects = true, -- help for text objects triggered after entering an operator
      windows = true, -- default bindings on <c-w>
      nav = true, -- misc bindings to work with windows
      z = true, -- bindings for folds, spelling and others prefixed with z
      g = true, -- bindings for prefixed with g
    },
  },
  operators = { gc = "Comments" },
  icons = {
    breadcrumb = "»", -- symbol used in the command line area that shows your active key combo
    separator = "➜", -- symbol used between a key and it's label
    group = "+", -- symbol prepended to a group
  },
  window = {
    border = "none", -- none, single, double, shadow
    position = "bottom", -- bottom, top
    margin = { 1, 0, 1, 0 }, -- extra window margin [top, right, bottom, left]
    padding = { 2, 2, 2, 2 }, -- extra window padding [top, right, bottom, left]
    winblend = 20,
  },
  layout = {
    height = { min = 4, max = 25 }, -- min and max height of the columns
    width = { min = 20, max = 50 }, -- min and max width of the columns
    spacing = 3, -- spacing between columns
  },
  ignore_missing = false, -- enable this to hide mappings for which you didn't specify a label
  hidden = { "<silent>", "<cmd>", "<Cmd>", "<CR>", "call", "lua", "^:", "^ " }, -- hide mapping boilerplate
  show_help = true, -- show help message on the command line when the popup is visible
  triggers = "auto", -- automatically setup triggers
})

local vopts = {
  mode = "v", -- VISUAL mode
  prefix = "<leader>",
  buffer = nil, -- Global mappings. Specify a buffer number for buffer local mappings
  silent = true, -- use `silent` when creating keymaps
  noremap = true, -- use `noremap` when creating keymaps
  nowait = true, -- use `nowait` when creating keymaps
}
local vmappings = {
  c = {
    name = "Comment",
    ["l"] = { "<Plug>(comment_toggle_linewise_visual)", "Comment Blockwise" },
    ["<space>"] = { "<Plug>(comment_toggle_blockwise_visual)", "Comment Blockwise" },
  },
}
local mappings = {
  ["/"] = {
    "<cmd>lua require('telescope.builtin').live_grep({ additional_args = function() return { '--glob=!package-lock.json' } end })<cr>",
    "Search project",
  },
  ["b"] = { "<cmd>NvimTreeToggle<cr>", "Toggle Explorer" },
  ["%"] = { "<cmd>luafile %<cr>", "Run luafile" },
  c = {
    name = "Comment",
    ["l"] = { "<Plug>(comment_toggle_linewise_current)", "Comment Line" },
    ["<space>"] = { "<Plug>(comment_toggle_blockwise_current)", "Comment Line" },
  },
  d = {
    name = "+Debug",
    b = { "<cmd>lua require'dap'.step_back()<cr>", "Step Back" },
    c = { "<cmd>lua require'dap'.continue()<cr>", "Continue" },
    C = { "<cmd>lua require'dap'.run_to_cursor()<cr>", "Run To Cursor" },
    D = { "<cmd>lua require'dap'.disconnect()<cr>", "Disconnect" },
    g = { "<cmd>lua require'dap'.session()<cr>", "Get Session" },
    i = { "<cmd>lua require'dap'.step_into()<cr>", "Step Into" },
    o = { "<cmd>lua require'dap'.step_over()<cr>", "Step Over" },
    O = { "<cmd>lua require'dap'.step_out()<cr>", "Step Out" },
    p = { "<cmd>lua require'dap'.pause.toggle()<cr>", "Pause" },
    q = { "<cmd>lua require'dap'.close()<cr>", "Quit" },
    r = { "<cmd>lua require'dap'.repl.toggle()<cr>", "Toggle Repl" },
    s = { "<cmd>lua require'dap'.continue()<cr>", "Start" },
    t = { "<cmd>lua require'dap'.toggle_breakpoint()<cr>", "Toggle Breakpoint" },
    u = { "<cmd>lua require'dapui'.toggle()<cr>", "Toggle DAPui" },
  },
  e = {
    name = "+Quick edit files",
    a = { "<cmd>:e $HOME/.config/awesome/rc.lua<cr>", "Edit Awesome rc.lua" },
    p = { "<cmd>:e $HOME/dotfiles/nvim/lua/plugins.lua<cr>", "Edit Plugfile" },
    t = { "<cmd>:e $HOME/dotfiles/wezterm/wezterm.lua<cr>", "Edit Terminal Config" },
    v = { "<cmd>:e $HOME/.config/nvim/init.lua<cr>", "Edit Vimrc" },
    w = { "<cmd>:e $HOME/dotfiles/nvim/lua/configs/which-key.lua<cr>", "Edit Which Key" },
    z = { "<cmd>:e $HOME/dotfiles/zshrc<cr>", "Edit zshrc" },
  },
  g = {
    name = "+Git",
    b = { "<cmd>Telescope git_branches<cr>", "Checkout branch" },
    B = { "<cmd>Git blame<cr>", "Git blame" },
    c = { "<cmd>Telescope git_commits<cr>", "Checkout commit" },
    C = { "<cmd>Telescope git_bcommits<cr>", "Checkout commit(for current file)" },
    d = { "<cmd>Git diff<cr>", "Git diff" },
    g = { "<CMD>lua _G.__floating_tui('lazygit')<CR>", "Lazygit" },
    j = { "<cmd>NextHunk<cr>", "Next Hunk" },
    k = { "<cmd>PrevHunk<cr>", "Prev Hunk" },
    l = { "<cmd>lua require 'gitsigns'.blame_line()<cr>", "Blame Line" },
    o = { "<cmd>Telescope git_status<cr>", "Git Status" },
    p = { "<cmd>PreviewHunk<cr>", "Preview Hunk" },
    r = { "<cmd>ResetHunk<cr>", "Reset Hunk" },
    R = { "<cmd>ResetBuffer<cr>", "Reset Buffer" },
    s = { "<cmd>Neogit kind=split<cr>", "Neogit Status" },
    u = { "<cmd>UndoStageHunk<cr>", "Undo Stage Hunk" },
  },
  h = {
    name = "+Help",
    b = { "<cmd>lua _G.__floating_tui('htop')<cr>", "Htop" },
    h = { "<cmd>Telescope help_tags<cr>", "Help Tags" },
    m = { "<cmd>Telescope man_pages<cr>", "Man Pages" },
  },
  l = {
    name = "+LSP",
    a = { "<cmd>lua vim.lsp.buf.code_action()<cr>", "Code Action" },
    d = { "<cmd>Telescope diagnostics bufnr=0 theme=get_ivy<cr>", "Buffer Diagnostics" },
    D = { "<cmd>TroubleToggle document_diagnostics<cr>", "Trouble Buffer Diagnostics" },
    f = { "<cmd>lua vim.lsp.buf.format()<cr>", "Format" },
    j = { "<cmd>lua vim.diagnostic.goto_next()<CR>", "Next Diagnostic" },
    k = { "<cmd>lua vim.diagnostic.goto_prev()<cr>", "Prev Diagnostic" },
    i = { "<cmd>LspInfo<cr>", "LSP Info" },
    l = { "<cmd>LspLog<cr>", "LSP Log" },
    q = { "<cmd>lua vim.diagnostic.set_loclist()<cr>", "Quickfix" },
    r = { "<cmd>lua vim.lsp.buf.rename()<cr>", "Rename" },
    s = { "<cmd>LspStart<cr>", "LSP Start" },
    S = { "<cmd>LspStop<cr>", "LSP Stop" },
    w = { "<cmd>Telescope diagnostics<cr>", "Diagnostics" },
    W = { "<cmd>TroubleToggle workspace_diagnostics<cr>", "Trouble Diagnostics" },
  },
  m = {
    name = "Language Mode",
  },
  n = {
    name = "+NvimTree",
    n = { "<cmd>NvimTreeToggle<cr>", "Toggle Explorer" },
    t = { "<cmd>NvimTreeFindFile<cr>", "Find at file" },
  },
  p = {
    name = "+Project",
    b = { "<cmd>Telescope buffers<cr>", "Find open Buffers" },
    f = { "<cmd>Telescope find_files<cr>", "Find file in project" },
    p = {
      name = "Lazy",
      i = { "<cmd>Lazy install<cr>", "Install" },
      s = { "<cmd>Lazy sync<cr>", "Sync" },
      p = { "<cmd>Lazy profile<cr>", "Profile" },
      u = { "<cmd>Lazy update<cr>", "Update" },
    },
    q = { "<cmd>TodoQuickFix<cr>", "Send TODOs to QuickFix List" },
    s = { "<cmd>Telescope grep_string<cr>", "Search string under cursor" },
    t = { "<cmd>TodoTelescope<cr>", "Search TODOs" },
  },
  s = {
    name = "+Search",
    c = { "<cmd>nohlsearch<cr>", "Clear Search Highlighting" },
  },
  t = {
    name = "+Todo",
    l = { "<cmd>TodoTrouble<cr>", "Send TODOs to Trouble List" },
    t = { "<cmd>lua _G.__floating_tui('taskwarrior-tui')<CR>", "Taskwarrior TUI" },
  },
  w = {
    name = "Vim Wiki",
    b = { "<cmd>Vimwiki2HTMLBrowse<cr>", "Export and Open" },
    h = { "<cmd>VimwikiAll2HTML<cr>", "Export all" },
  },
  y = {
    name = "+Youtrack",
    c = { "<cmd>lua require('youtrack').issues.comment()<cr>", "Comment on issue" },
    C = { "<cmd>lua require('youtrack').issues.create()<cr>", "Create issue" },
    i = { "<cmd>lua require('youtrack').issues.list()<cr>", "Get my issues" },
    I = { "<cmd>lua require('youtrack').issues.get()<cr>", "Get single issue" },
    p = { "<cmd>lua require('youtrack').projects.list()<cr>", "Get projects" },
    P = { "<cmd>lua require('youtrack').projects.get()<cr>", "Get single project" },
  },
}
local opts = {
  mode = "n", -- NORMAL mode
  prefix = "<leader>",
  buffer = nil, -- Global mappings. Specify a buffer number for buffer local mappings
  silent = true, -- use `silent` when creating keymaps
  noremap = true, -- use `noremap` when creating keymaps
  nowait = false, -- use `nowait` when creating keymaps
}

local mode_mappings = {
  org = org.which_key_mappings,
  go = {
    b = { "<cmd>!go test -bench=.<cr>", "Go Benchmark" },
    t = { "<cmd>GoTest<cr>", "Go Test" },
  },
}

local group = vim.api.nvim_create_augroup("Language mode", { clear = true })
vim.api.nvim_create_autocmd("FileType", {
  pattern = { "go", "org" },
  callback = function()
    local type = vim.fn.expand("<amatch>")
    vim.schedule(function()
      map("n", "<C-CR>", "<cmd>lua require('orgmode').action('org_mappings.insert_heading_respect_content')<cr>", {})
      map("i", "<C-CR>", "<cmd>lua require('orgmode').action('org_mappings.insert_heading_respect_content')<cr>", {})
      mappings["m"] = mode_mappings[type]
      opts["buffer"] = 0
      wk.register(mappings, opts)
    end)
  end,
  group = group,
})

wk.register(mappings, opts)
wk.register(vmappings, vopts)
