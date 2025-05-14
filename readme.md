## 介绍
neovim当前行添加前缀

## 安装
使用lazy.nvim
`
    {
        "zzejone/telescope-custom-prefix.nvim",
        name = "telescope-custom-prefix",
        dependencies = { "nvim-telescope/telescope.nvim", "nvim-lua/plenary.nvim" },
        config = function()
            require("telescope-custom-prefix").setup {
                prefixes = { "TODO", "NOTE", "FIXME", "REVIEW", "OPTIMIZE" },
                keymap = "<leader>tp",
            }
        end,
    },
`
