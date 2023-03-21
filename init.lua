-- Source vimrc
local dot_vim_cfg_path = vim.fn.expand('$HOME/.config/nvim/vimrc')
vim.cmd('source ' .. dot_vim_cfg_path)

-- Helper functions
--
-- Copy path of current file relative to working directory
vim.api.nvim_create_user_command("Cppath", function()
    local path = vim.fn.expand("%:.")
    vim.fn.setreg("+", path)
    vim.notify('Copied "' .. path .. '" to the clipboard.')
end, {}) 

-- Copy github URL to current line
vim.api.nvim_create_user_command("Cpgh", function ()
    -- get relative path to file
    local path = vim.fn.expand("%:.")
    -- get remote url
    local git_remote_handle = io.popen("git remote get-url origin")
    local remote_url_base = git_remote_handle:read("*a"):gsub("^%s*(.-).git%s*$", "%1")
    git_remote_handle:close()
    -- get commit hash
    local git_rev_parse_handle = io.popen("git rev-parse HEAD")
    local git_hash = git_rev_parse_handle:read("*a"):gsub("%s+", "")
    git_rev_parse_handle:close()
    -- get line number of cursor
    local line_num, col_num = unpack(vim.api.nvim_win_get_cursor(0))
    -- combine them
    -- https://github.com/ch-robinson-internal/MLOps.Platform.SDK/blob/6dee160a0b26c99e8672c680b08c465b772728ec/mlops_platform_sdk/helm/put.py#L47
    local remote_url = (remote_url_base .. "/blob/" .. git_hash .. "/" .. path .. "#L" .. line_num)
    vim.fn.setreg("+", remote_url)
    -- log message
    vim.notify('Copied "' .. remote_url .. '" to the clipboard.')
    -- possible improvements:
    -- * use git repo that file is in, instead of git repo of cwd
    -- * multiple-line links when multiple lines selected
end, {})

-- Configure LSP (installed alongside all other plugins in vimrc)
--
-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
local on_attach = function(client, bufnr)
  -- Enable completion triggered by <c-x><c-o>
  vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

  -- Mappings.
  -- See `:help vim.lsp.*` for documentation on any of the below functions
  local bufopts = { noremap=true, silent=true, buffer=bufnr }
  vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, bufopts)
  vim.keymap.set('n', 'gd', vim.lsp.buf.definition, bufopts)
  vim.keymap.set('n', 'K', vim.lsp.buf.hover, bufopts)
  vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, bufopts)
  -- vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, bufopts)
  vim.keymap.set('n', '<Leader>wa', vim.lsp.buf.add_workspace_folder, bufopts)
  vim.keymap.set('n', '<Leader>wr', vim.lsp.buf.remove_workspace_folder, bufopts)
  vim.keymap.set('n', '<Leader>wl', function()
    print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
  end, bufopts)
  vim.keymap.set('n', '<Leader>D', vim.lsp.buf.type_definition, bufopts)
  vim.keymap.set('n', '<Leader>rn', vim.lsp.buf.rename, bufopts)
  vim.keymap.set('n', '<Leader>ca', vim.lsp.buf.code_action, bufopts)
  vim.keymap.set('n', 'gr', vim.lsp.buf.references, bufopts)
  vim.keymap.set('n', '<Leader>f', function() vim.lsp.buf.format { async = true } end, bufopts)
end
-- Configure pylsp
require'lspconfig'.pylsp.setup{
  cmd = { "pylsp", "--verbose" },
  on_attach = on_attach,
  settings = {
    pylsp = {
      plugins = {
        flake8 = {enabled = false},
        pycodestyle = {enabled = false}
      }
    }
  }
}

-- Telescope keymaps
local telescope_builtin = require('telescope.builtin')
local telescope_keymaps = {
  {lhs = '<leader>ff', rhs = telescope_builtin.find_files},
  {lhs = '<leader>fF', rhs = telescope_builtin.git_files},
  {lhs = '<leader>fg', rhs = telescope_builtin.live_grep},
  {lhs = '<leader>fB', rhs = telescope_builtin.buffers},
  {lhs = '<leader>fb', rhs = function () telescope_builtin.git_branches {show_remote_tracking_branches=false} end },
  {lhs = '<leader>Fb', rhs = telescope_builtin.git_branches},
  {lhs = '<leader>fh', rhs = telescope_builtin.help_tags},
  {lhs = '<leader>f/', rhs = telescope_builtin.current_buffer_fuzzy_find}
}
for _, keymap in ipairs(telescope_keymaps) do
  vim.keymap.set('n', keymap.lhs, keymap.rhs, {})
end
-- Git keymaps
local git_keymaps = {
  {lhs = '<leader>gs', rhs = ':Git<CR>'},
  {lhs = '<leader>gcc', rhs = ':Git commit -v<CR>'},
  {lhs = '<leader>gca', rhs = ':Git commit -v --amend<CR>'},
  {lhs = '<leader>gfo', rhs = ':Git fetch origin<CR>'},
  {lhs = '<leader>gpp', rhs = ':Git push<CR>'},
  {lhs = '<leader>gpf', rhs = ':Git push --force<CR>'},
  {lhs = '<leader>glg', rhs = ':Git log -50<CR>'},
  {lhs = '<leader>gbl', rhs = ':Git blame<CR>'},
}
for _, keymap in ipairs(git_keymaps) do
  vim.keymap.set('n', keymap.lhs, keymap.rhs, {})
end

-- tree-sitter
require'nvim-treesitter.configs'.setup {
  highlight = {
    enable = true
  }
}

-- code folding via tree-sitter
-- https://www.jmaguire.tech/posts/treesitter_folding/
vim.opt.foldmethod = "expr"
vim.opt.foldexpr = "nvim_treesitter#foldexpr()"
