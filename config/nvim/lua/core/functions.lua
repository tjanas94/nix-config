function P(v)
    print(vim.inspect(v))
    return v
end

RELOAD = require('plenary.reload').reload_module

function R(name)
    RELOAD(name)
    return require(name)
end
