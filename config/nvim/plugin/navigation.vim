nnoremap <C-k> :cnext<cr>zz
nnoremap <C-j> :cprev<cr>zz
nnoremap <leader>k :lnext<cr>zz
nnoremap <leader>j :lprev<cr>zz
nnoremap <C-q> :call ToggleQFList(1)<cr>
nnoremap <leader>q :call ToggleQFList(0)<cr>

nnoremap <leader>gll :let g:_search_term = expand("%")<cr><bar>:Gclog -- %<cr>:call search(g:_search_term)<cr>
nnoremap <leader>gln :cnext<cr>:call search(_search_term)<cr>
nnoremap <leader>glp :cprev<cr>:call search(_search_term)<cr>

let g:the_primeagen_qf_l = 0
let g:the_primeagen_qf_g = 0

fun! ToggleQFList(global)
    if a:global
        if g:the_primeagen_qf_g == 1
            cclose
        else
            copen
        end
    else
        echo 'toggle locallist'
        if g:the_primeagen_qf_l == 1
            lclose
        else
            lopen
        end
    endif
endfun

fun! SetQFControlVariable()
    if getwininfo(win_getid())[0]['loclist'] == 1
        let g:the_primeagen_qf_l = 1
    else
        let g:the_primeagen_qf_g = 1
    end
endfun

fun! UnsetQFControlVariable()
    if getwininfo(win_getid())[0]['loclist'] == 1
        let g:the_primeagen_qf_l = 0
    else
        let g:the_primeagen_qf_g = 0
    end
endfun

augroup fixlist
    autocmd!
    autocmd BufWinEnter quickfix call SetQFControlVariable()
    autocmd BufWinLeave * call UnsetQFControlVariable()
augroup END
