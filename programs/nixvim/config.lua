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

-- Setup venv-selector

require("venv-selector").setup({})

-- Configure ESLint to search for a config

require("conform").formatters.eslint_d = {
    cwd = function(_, ctx)
        return vim.fs.root(ctx.filename, { "eslint.config.js" })
    end,
}

-- Auto-convert .ipynb to .py when opening

vim.api.nvim_create_autocmd("BufReadPost", {
  pattern = "*.ipynb",
  callback = function()
    local filename = vim.fn.expand("%:p")
    local py_file = filename:gsub("%.ipynb$", ".py")

    -- Convert notebook to .py format
    vim.fn.system(string.format("jupytext --to py:percent %s", vim.fn.shellescape(filename)))

    -- Open the .py file instead
    vim.cmd("edit " .. vim.fn.fnameescape(py_file))
    vim.cmd("filetype detect")
  end,
})

-- Auto-sync .py back to .ipynb on save

vim.api.nvim_create_autocmd("BufWritePost", {
  pattern = "*.py",
  callback = function()
    local py_file = vim.fn.expand("%:p")
    local ipynb_file = py_file:gsub("%.py$", ".ipynb")

    -- Only sync if corresponding .ipynb exists
    if vim.fn.filereadable(ipynb_file) == 1 then
      vim.fn.system(string.format("jupytext --to notebook --update %s", vim.fn.shellescape(py_file)))
    end
  end,
})
