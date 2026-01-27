let mapleader=" "

map <C-s> :w<CR>
map <LEADER>q :q<CR>

nmap <C-j> 5j
nmap <C-k> 5k

noremap j gj
noremap k gk

imap <C-j> <Down>
imap <C-k> <Up>
imap <C-h> <Left>
imap <C-l> <Right>

inoremap jk <ESC>
xnoremap jk <ESC>
cnoremap jk <ESC>

map <LEADER>e :Vexplore<CR>
map <C-\\> :term<CR>

map <LEADER><CR> :nohlsearch<CR>

map <LEADER>sh :split<CR>
map <LEADER>sv :vsplit<CR>

map <LEADER>h <C-w>h
map <LEADER>j <C-w>j
map <LEADER>k <C-w>k
map <LEADER>l <C-w>l

map <LEADER>H <C-w>H
map <LEADER>J <C-w>J
map <LEADER>K <C-w>K
map <LEADER>L <C-w>L

map <up> :resize +2<CR>
map <down> :resize -2<CR>
map <right> :vertical resize +2<CR>
map <left> :vertical resize -2<CR>

map tc :tabe<CR>
map tmh :-tabmove<CR>
map tml :+tabmove<CR>

vnoremap <LEADER>y "+y
nnoremap <LEADER>p "*p
