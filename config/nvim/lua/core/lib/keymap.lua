local M = {}

function M.map(mode, lhs, rhs)
    local opts = { noremap = true, silent = true }
    vim.keymap.set(mode, lhs, rhs, opts)
end

function M.bufmap(bufnr)
    local opts = { noremap = true, silent = true, buffer = bufnr }

    return function(mode, lhs, rhs)
        vim.keymap.set(mode, lhs, rhs, opts)
    end
end

return M
