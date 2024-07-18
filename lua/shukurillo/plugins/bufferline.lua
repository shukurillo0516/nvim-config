return {
    'akinsho/bufferline.nvim',
    version = "*",
    dependencies = 'nvim-tree/nvim-web-devicons',
    config = function ()
        local bufferline = require("bufferline")
        bufferline.setup({
            options = {
                mode = "buffers",
                numbers = "ordinal",
            }
        })
        vim.keymap.set("n", "gb", "<cmd>BufferLinePick <cr>")
        vim.keymap.set("n", "gD", "<cmd>BufferLinePickClose <cr>")
        vim.keymap.set("n", "<leader>bd", "<cmd>bdelete <cr>")
        vim.keymap.set("n", "<leader>bl", "<cmd>BufferLineCloseLeft <cr>")
        vim.keymap.set("n", "<leader>br", "<cmd>BufferLineCloseRight <cr>")

        vim.keymap.set("n", "<A-s>", "<cmd>BufferLineCycleNext <cr>")
        vim.keymap.set("n", "<A-a>", "<cmd>BufferLineCyclePrev <cr>")
        vim.keymap.set("n", "<C-s>", "<cmd>BufferLineMoveNext <cr>")
        vim.keymap.set("n", "<c-a>", "<cmd>BufferLineMovePrev <cr>")


        vim.keymap.set("n", "<leader>1", "<cmd>BufferLineGoToBuffer 1<cr>")
        vim.keymap.set("n", "<leader>2", "<cmd>BufferLineGoToBuffer 2<cr>")
        vim.keymap.set("n", "<leader>3", "<cmd>BufferLineGoToBuffer 3<cr>")
        vim.keymap.set("n", "<leader>4", "<cmd>BufferLineGoToBuffer 4<cr>")
        vim.keymap.set("n", "<leader>5", "<cmd>BufferLineGoToBuffer 5<cr>")
        vim.keymap.set("n", "<leader>6", "<cmd>BufferLineGoToBuffer 6<cr>")
        vim.keymap.set("n", "<leader>7", "<cmd>BufferLineGoToBuffer 7<cr>")
        vim.keymap.set("n", "<leader>8", "<cmd>BufferLineGoToBuffer 8<cr>")
        vim.keymap.set("n", "<leader>9", "<cmd>BufferLineGoToBuffer 9<cr>")
        vim.keymap.set("n", "<leader>$", "<cmd>BufferLineGoToBuffer -1<cr>")

    end,
}
