-- Show diagnostic text when hovering

vim.api.nvim_create_autocmd("CursorHold", {
    callback = function()
        vim.diagnostic.open_float(nil, { focusable = true })
    end,
})

-- Add border to LSP hover box

vim.keymap.set('n', 'K', function()
    vim.lsp.buf.hover({ border = 'rounded' })
end)

-- Auto-refresh Neo-tree/Gitsigns

vim.api.nvim_create_autocmd({ 'FocusGained', 'BufWritePost', 'TermLeave' }, {
    callback = function()
        require('neo-tree.sources.manager').refresh('filesystem')
        vim.cmd('Gitsigns refresh')
    end,
})

-- Configure ESLint to search for a config

require("conform").formatters.eslint_d = {
    cwd = function(_, ctx)
        return vim.fs.root(ctx.filename, { "eslint.config.js" })
    end,
}
