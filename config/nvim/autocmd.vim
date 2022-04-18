" Compile .c files on save
autocmd BufWritePost *.c !gcc "%" -o "%:r"

" Show shellcheck report on save
autocmd BufWritePost *.sh !shellcheck "%"

" Set scripts to be executable from the shell
autocmd BufWritePost * if getline(1) =~ "^#!" | if getline(1) =~ "/bin/" | silent !chmod +x "%" | endif | endif

" Remove trailing whitespace on save
autocmd BufWritePre * %s/\s\+$//e

" Wrap gitcommit to 50 for first line and 72 for the rest
augroup gitsetup
        autocmd!

        " Only set these commands up for git commits
        autocmd FileType gitcommit
                \  hi def link gitcommitOverflow Error
                \| autocmd CursorMoved,CursorMovedI *
                        \  let &l:textwidth = line('.') == 1 ? 50 : 72
augroup end
