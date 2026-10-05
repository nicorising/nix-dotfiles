-- Show diagnostic text when hovering.

vim.api.nvim_create_autocmd("CursorHold", {
    callback = function()
        -- Don't show if another float is already open
        for _, win in ipairs(vim.api.nvim_list_wins()) do
            if vim.api.nvim_win_get_config(win).relative ~= "" then
                return
            end
        end

        vim.diagnostic.open_float(nil, { focusable = true })
    end,
})

-- Add border to LSP hover box.

vim.keymap.set('n', 'K', function()
    vim.lsp.buf.hover({ border = 'rounded' })
end)

-- Check for buffers changed on disk.
vim.api.nvim_create_autocmd({ 'FocusGained', 'BufEnter', 'CursorHold', 'TermLeave' }, {
    callback = function()
        if vim.fn.mode() ~= 'c' and vim.fn.getcmdwintype() == '' then
            vim.cmd('checktime')
        end
    end,
})

-- Refresh Neo-Tree and Gitsigns and notify when the buffer was reloaded.
vim.api.nvim_create_autocmd('FileChangedShellPost', {
    callback = function()
        require('neo-tree.sources.manager').refresh('filesystem')
        vim.cmd('Gitsigns refresh')
        vim.notify('File changed on disk, buffer reloaded', vim.log.levels.WARN)
    end,
})

-- Configure ESLint to search for a config.

require("conform").formatters.eslint_d = {
    cwd = function(_, ctx)
        return vim.fs.root(ctx.filename, { "eslint.config.js" })
    end,
    require_cwd = true,
}

-- TODO: Delete once neovim handles in 0.13

vim.filetype.add({
    pattern = {
        ['.*'] = {
            function(_, bufnr)
                local line = vim.api.nvim_buf_get_lines(bufnr, 0, 1, false)[1] or ''
                if vim.regex([[^#!.*\<uv\s\+run\>]]):match_str(line) then
                    return 'python'
                end
            end,
            { priority = -math.huge },
        },
    },
})
