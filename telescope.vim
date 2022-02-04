" Default Mappings
" <C-n>/<Down>	Next item
" <C-p>/<Up>	Previous item
" j/k	Next/previous (in normal mode)
" H/M/L	Select High/Middle/Low (in normal mode)
" 'gg/G'	Select the first/last item (in normal mode)
" <CR>	Confirm selection
" <C-x>	Go to file selection as a split
" <C-v>	Go to file selection as a vsplit
" <C-t>	Go to a file in a new tab
" <C-u>	Scroll up in preview window
" <C-d>	Scroll down in preview window
" <C-/>	Show mappings for picker actions (insert mode)
" ?	Show mappings for picker actions (normal mode)
" <C-c>	Close telescope
" <Esc>	Close telescope (in normal mode)
" <Tab>	Toggle selection and move to next selection
" <S-Tab>	Toggle selection and move to prev selection
" <C-q>	Send all items not filtered to quickfixlist (qflist)
" <M-q>	Send all selected items to qflist

nnoremap <leader>f <cmd>lua require('telescope.builtin').find_files()<cr>
nnoremap <leader>G <cmd>lua require('telescope.builtin').live_grep()<cr>
nnoremap <leader>b <cmd>lua require('telescope.builtin').buffers()<cr>
nnoremap <leader>h <cmd>lua require('telescope.builtin').help_tags()<cr>
