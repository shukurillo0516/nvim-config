return {
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v3.x",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
      "MunifTanjim/nui.nvim",
      -- "3rd/image.nvim", -- Optional image support in preview window: See `# Preview Mode` for more information
    },
    init = function ()
        if vim.fn.argc(-1) == 1 then
            local stat = vim.loop.fs_stat(vim.fn.argv(0))
            if stat and stat.type == "directory" then
              require("neo-tree").setup({
                filesystem = {
                  hijack_netrw_behavior = "open_current",
                },
              })
            end
        end 
    end,
    config = function ()
       local nvimTree = require("neo-tree")
       vim.keymap.set('n', '<leader>e', "<cmd>Neotree left toggle reveal <cr>")
       vim.keymap.set('i', '<A-e>', "<cmd>Neotree left toggle reveal <cr>")
    end
}
