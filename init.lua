local dot_vim_cfg_path = vim.fn.expand('$HOME/.config/nvim/vimrc')
vim.cmd('source ' .. dot_vim_cfg_path)
require'lspconfig'.pyright.setup{}
