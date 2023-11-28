require("core.theme")
require("core.options")
require("core.keymaps")

local lazy = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazy) then
    print("Installing lazy.nvim ....")
    vim.fn.system({ "git", "clone", "https://github.com/folke/lazy.nvim.git", "--branch=stable", lazy })
end
vim.opt.rtp:prepend(vim.env.LAZY or lazy)

require("lazy").setup {
    spec = {
        require("plugins.autolist"),
        require("plugins.diffview"),
        require("plugins.flash"),
        require("plugins.fzf"),
        require("plugins.gitsigns"),
        require("plugins.indent-blankline"),
        require("plugins.lualine"),
        require("plugins.markdown"),
        require("plugins.neogen"),
        require("plugins.nvim-surround"),
        require("plugins.nvim-tree"),
        require("plugins.smart-pairs"),
        require("plugins.todo-comments"),
        require("plugins.toggleterm"),
        require("plugins.vim-visual-multi"),
        require("plugins.which-key"),
        require("plugins.nvim-treesitter"),
        require("lsp.LuaSnip"),
        require("lsp.nvim-cmp"),
        require("lsp.nvim-lspconfig"),
        -- require("plugins.coc"),
    },
    defaults = { lazy = false },
    checker = { enabled = false },
    change_detection = { enabled = true, notify = false, },
    git = { log = { "-8" }, timeout = 120, filter = true, },
    ui = {
        wrap = true,
        border = "single",
        rtp = {
            disabled_plugins = {
                "gzip", "tutor", "tohtml", "rplugin", "tarPlugin", "zipPlugin"
            }
        }
    }
}
