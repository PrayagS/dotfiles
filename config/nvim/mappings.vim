" Remap splits navigation to just CTRL + hjkl
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l

" Set better keybindings for tabs
nnoremap th :tabprev<CR>
nnoremap tl :tabnext<CR>
nnoremap tw :tabclose<CR>
nnoremap tn :tabnew<CR>

if exists('g:vscode')
    nnoremap tn :Tabnew<CR>
endif

" Best keybindings ever; Source: ThePrimeagen
" nnoremap Y y$
" nnoremap <leader>y "+y
" vnoremap <leader>y "+y
" nmap <leader>Y "+Y
" xnoremap <leader>p "_dP
" nnoremap <leader>d "_d
" vnoremap <leader>d "_d
" nnoremap n nzzzv
" nnoremap N Nzzzv
inoremap , ,<c-g>u
inoremap . .<c-g>u
inoremap ! !<c-g>u
inoremap ? ?<c-g>u
" vnoremap J :m '>+1<CR>gv=gv
" vnoremap K :m '<-2<CR>gv=gv
" nnoremap <leader>j :m .+1<CR>==
" nnoremap <leader>k :m .-2<CR>==

nmap <leader>P <Plug>yankstack_substitute_older_paste
nnoremap <leader>f <cmd>Files<cr>
nnoremap <leader>F <cmd>GFiles<cr>
nmap s <Plug>Lightspeed_s
nmap S <Plug>Lightspeed_S

# Disable arrow keys
map <Up> <Nop>
map <Left> <Nop>
map <Right> <Nop>
map <Down> <Nop>
