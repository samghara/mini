local Core = require("core")
local utils = require("core.utils")
local opts = { noremap = true, silent = true }

Core.setKeyMaps {
    { { "i", "v", "s" }, "jk",         "<Esc>",                   opts },
    { "t",               "jk",         "<C-\\><C-n>",             opts }, -- in terminal switch TERMINAL mode to NORMAL mode
    { "n",               "<M-2>",      "@q",                      opts },
    { { "n", "i", "v" }, "<Home>",     utils.Home,                opts },
    { { "i", "v" },      "<M-i>",      utils.Home,                opts },
    { { "i", "v" },      "<M-a>",      "<End>",                   opts },
    { { "n", "i" },      "<C-s>",      "<Cmd>w<CR>",              opts },
    { { "n", "i" },      "<C-z>",      "<Cmd>undo<CR>",           opts },
    { { "n", "i" },      "<C-y>",      "<Cmd>redo<CR>",           opts },
    { "n",               "Q",          "<Cmd>bdelete<CR>",        opts },
    { "n",               "<Tab>",      "<Cmd>bnext<CR>",          opts },
    { "n",               "<S-Tab>",    "<Cmd>bprevious<CR>",      opts },
    { "v",               "<Tab>",      ">gv",                     opts },
    { "v",               "<S-Tab>",    "<gv",                     opts },
    { "i",               "<S-Tab>",    "<C-d>",                   opts },
    { "i",               "<M-h>",      "<Left>",                  opts },
    { "i",               "<M-l>",      "<Right>",                 opts },
    { "n",               "<leader>q",  "<Cmd>qa<CR>",             opts },
    { "n",               "<leader>h",  "gd",                      opts },
    { "n",               "<leader>nh", "<Cmd>noh<CR>",            opts },
    { "n",               "<C-a>",      "ggVG",                    opts }, -- VISUAL mode select all
    { "n",               "<M-a>",      "<C-o>",                   opts },
    { "n",               "<M-d>",      "<C-i>",                   opts },
    { { "n", "t" },      "<Leader>wh", "<Cmd>wincmd h<CR>",       opts },
    { { "n", "t" },      "<Leader>wj", "<Cmd>wincmd j<CR>",       opts },
    { { "n", "t" },      "<Leader>wk", "<Cmd>wincmd k<CR>",       opts },
    { { "n", "t" },      "<Leader>wl", "<Cmd>wincmd l<CR>",       opts },
    { "n",               "<M-j>",      ":move .+1<CR>",           opts }, -- move current line down
    { "n",               "<M-k>",      ":move .-2<CR>",           opts }, -- move current line up
    { "n",               "<M-J>",      ":copy .<CR>",             opts }, -- copy current line down
    { "n",               "<M-K>",      ":copy .-1<CR>",           opts }, -- copy current line up
    { "v",               "<M-j>",      ":move '>+1<CR>gv",        opts }, -- move select block down
    { "v",               "<M-k>",      ":move '<-2<CR>gv",        opts }, -- move select block up
    { "v",               "<M-J>",      ":copy '<-1<CR>gv",        opts }, -- copy select block down
    { "v",               "<M-K>",      ":copy '><CR>gv",          opts }, -- copy select block up
    { { "n", "i", "v" }, "<C-_>",      utils.CommentLine,         opts }, -- line-comment
    { { "n", "i", "v" }, "<C-/>",      utils.CommentLine,         opts }, -- line-comment
    { { "n", "i", "v" }, "<M-A>",      utils.CommentHunk,         opts }, -- hunk-comment
}
