## 介绍
neovim当前行添加前缀

## 安装
使用lazy.nvim
`
    {
        "zzejone/telescope-custom-prefix.nvim",
        dependencies = { "nvim-telescope/telescope.nvim", "nvim-lua/plenary.nvim" },
        opts = {
            prefixes = { "TODO", "NOTE", "FIXME", "HACK", "WARN" },
            keymap = "<leader>tp",
            telescope = {
                layout_config = {
                  width = 0.5,
                  height = 0.4,
                },
            },
        },
    },
`
