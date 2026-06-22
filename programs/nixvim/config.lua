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

-- Check for buffers changed on disk
vim.api.nvim_create_autocmd({ 'FocusGained', 'BufEnter', 'CursorHold', 'TermLeave' }, {
    callback = function()
        if vim.fn.mode() ~= 'c' and vim.fn.getcmdwintype() == '' then
            vim.cmd('checktime')
        end
    end,
})

-- Refresh Neo-Tree and Gitsigns and notify when the buffer was reloaded
vim.api.nvim_create_autocmd('FileChangedShellPost', {
    callback = function()
        require('neo-tree.sources.manager').refresh('filesystem')
        vim.cmd('Gitsigns refresh')
        vim.notify('File changed on disk, buffer reloaded', vim.log.levels.WARN)
    end,
})

-- Configure ESLint to search for a config

require("conform").formatters.eslint_d = {
    cwd = function(_, ctx)
        return vim.fs.root(ctx.filename, { "eslint.config.js" })
    end,
}
