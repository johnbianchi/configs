" ---------------------------------------------------------------------------
" Plugins installed
"
" To refresh the list, uncomment the line below and hit command-E on it (see
" the <d-e> mapping in this file
" ---------------------------------------------------------------------------

" silent execute 'normal mzjV}kdk' | silent execute "read !ls ~/.vim/bundle" | silent execute "normal `zjV}k\<space>c\<space>'z0gcl'"
"Rename
"YouCompleteMe
"ZoomWin
"abolish
"ack.vim
"anzu
"clickable
"clickable-things
"coffee-script
"commentary
"ctrlp.vim
"ctrlspace
"delimitMate
"django.vim
"dragvisuals
"easymotion
"endwise
"extradite
"fugitive
"gitgutter
"glsl
"gundo
"html-entities
"indent-anything
"indentwise
"jison
"less
"match-tag
"matchit
"mru
"multiple-cursors
"mustache-handlebars
"nerd-tree
"nerdcommenter
"node
"over
"powerline
"qargs
"qlist
"repeat
"snippets
"splitjoin.vim
"stylus
"surround
"syntastic
"tabular
"test-runner
"textobj-entire
"textobj-lastpat
"ultisnips
"unimpaired
"vim-javascript
"vim-jsx
"vim-nerdtree-tabs
"vim-perl
"vim-project
"vim-script-runner
"vim-snippets
"vim-textobj-comment
"vim-textobj-function-perl
"vim-textobj-user
"vimproc.vim

" Dead plugins I have removed:
"choosewin
"vim-session
"scala
"vim-clojure
"coffee-script
"jira-completer
"pattern-complete " offers completions for last search pattern
"complete-helper
"lusty-juggler
"neocomplcache
"neosnippet
"ultisnips-snips
"snipmate-snippets
"rainbow_parentheses.vim
"tagbar
"vim-expand-region

" Shit I forget about from the above plugins
" ------------------------------------------
" Use gc or gcc for commenting motions from vim-commentary
" use vac or vic to select inside / around comments
" I set mark s for place-before-search
" from https://www.youtube.com/watch?v=3TX3kV3TICU use ctrl-a in insert to
"      repeat last typed text. use ctrl-x ctrl-p to complete sentences in some
"      magical way. ctrl-x ctrl-o is a bunch of bullshit to complete syntax
"      aware lke fn.<c-x><c-o> completion. I will never type this
" Use ]I and [I (and lowercase) to show lines containing word under cursor
" leader aa is for ack with out -i
" /%V is how you match only visual selection, since ranges are linewise and
"     vim is shit

" ---------------------------------------------------------------
" Custom setup
" ---------------------------------------------------------------

colorscheme vividchalk
set nocompatible

" Experimental to make command line completion easier?
set wildmenu

" Don't put two spaces after a period when joining lines with gq or J or
" whatever
set nojoinspaces

" Pathogen loading
filetype off
call pathogen#infect()
Helptags " Added to avoid having to manually install docs for plugins
filetype plugin indent on

" Fixing vim's awful bullshit, fucks up coloring of nerdtree if you call
" syntax on/enable. Use enable (more vim bullshit) because on will overwrite
" any defined colors
if !exists("g:syntax_on")
    syntax enable
endif

" Highlight column 80 and don't make it bright red like an idiot would (needs
" to be done after syntax set)
highlight ColorColumn guibg=#331111
set colorcolumn=80
set cursorline

" Always show vim's tab bar, garbage default is off
set showtabline=2

" Experimental and possibly terrible
highlight Cursor guibg=#FF92BB guifg=#fff
highlight iCursor guibg=red
set guicursor=n-c:ver30-Cursor/lCursor,ve:ver35-Cursor,o:hor50-Cursor,i-ci:ver25-iCursor/lCursor,r-cr:hor20-Cursor/lCursor,v-sm:block-Cursor

" Experimental make lines that wrap have same indenting as their parent
set breakindent

" Don't try to highlight lines longer than 800 characters.
set synmaxcol=800

" Always splits to the right and below, since Bram doesn't read left to right
set splitright
" this fucks up help opening above
"set splitbelow

" Custom file type syntax highlighting
au BufRead,BufNewFile *.djhtml set filetype=html
au BufRead,BufNewFile *.soy set filetype=clojure
au BufRead,BufNewFile .bash_config set ft=sh syntax=sh
au BufRead,BufNewFile .jshintrc set ft=javascript
au BufRead,BufNewFile .eslintrc set ft=javascript
au BufRead,BufNewFile *.json set ft=javascript

" Mojo templates
au BufRead,BufNewFile *.pc set filetype=html
au BufRead,BufNewFile Rexfile set filetype=perl

" Set Ctrl-P to show match at top of list instead of at bottom, which is so
" stupid that it's not default
let g:ctrlp_match_window_reversed = 0

" Tell Ctrl-P to keep the current VIM working directory when starting a
" search, another really stupid non default
let g:ctrlp_working_path_mode = 0

" Ctrl-P ignore target dirs so VIM doesn't have to! Yay!
let g:ctrlp_custom_ignore = {
    \ 'dir': 'public\-build$\|dist$\|\.git$\|\.hg$\|\.svn$\|target$\|built$\|.build$\|node_modules\|\.sass-cache\|locallib$\|log$|vendor$',
    \ 'file': '\.ttc$',
    \ }

let g:ctrlspace_ignored_files = '\v\.git$|\.hg$|\.svn$|target$|built$|.build$|node_modules|\.sass-cache|locallib$|log$'

" Fix ctrl-p's mixed mode https://github.com/kien/ctrlp.vim/issues/556
"let g:ctrlp_extensions = ['mixed']
nnoremap <c-p> :CtrlP<cr>

" Set up some custom ignores
"call unite#custom_source('file_rec,file_rec/async,file_mru,file,buffer,grep',
      "\ 'ignore_pattern', join([
      "\ '\.git\|\.hg\|\.svn\|target\|built\|.build\|node_modules\|\.sass-cache',
      "\ '\.ttc$',
      "\ ], '\|'))

" Open multiplely selected files in a tab by default
let g:ctrlp_open_multi = '10t'

" Powerline custom font. Why did I remove this?
if has('gui_running')
    "set guifont=Menlo\ for\ Powerline
endif

" Fix multiple cursors bullshit mdoe switching
let g:multi_cursor_exit_from_insert_mode=0
let g:multi_cursor_exit_from_visual_mode=0
" Fix no highlighting too
highlight multiple_cursors_cursor term=reverse cterm=reverse gui=reverse
highlight link multiple_cursors_visual Visual

function! FindAllMultipleCursors( type )

    " Yank the (w)ord under the cursor into reg z. If we (were) in visual mode,
    " use gv to re-select the last visual selection first
    if a:type == "v"
        norm! gv"zy
    else
        norm! "zyiw
    endif

    " Find how many occurrences of this word are in the current document, see
    " :h count-items. Redirect the output to register x silently otherwise it
    " spits out the search output
    redir @x | silent execute "%s/\\v" . @z . "/&/gn" | redir END

    " Get the first word in output ("n of n matches") which is count. Split
    " on non-word chars because output has linebreaks
    let s:count = split( @x, '\W' )[ 0 ]

    if s:count > 15
        call inputsave()
        let s:yn = input('There are ' . s:count . ' matches, and MultipleCurors is slow. Are you sure? (y/n) ')
        call inputrestore()
        redraw
        if s:yn != "y"
            echo "Aborted FindAllMultipleCursors."
            return
        endif
    endif

    execute "MultipleCursorsFind " . @z
endfunction

nnoremap <leader>fa :call FindAllMultipleCursors("")<cr>
vnoremap <leader>fa :call FindAllMultipleCursors("v")<cr>

" Called once right before you start selecting multiple cursors
function! Multiple_cursors_before()
    call youcompleteme#DisableCursorMovedAutocommands()
endfunction

" Called once only when the multiple selection is canceled (default <Esc>)
function! Multiple_cursors_after()
    call youcompleteme#EnableCursorMovedAutocommands()
endfunction

" ---------------------------------------------------------------
" Functions
" ---------------------------------------------------------------

" this is a good start but not quite there yet, it goes in a loop
function! FixJumpChangeList()
    redir @a
    silent changes
    redir end

    let s:current_line = line('.')
    let s:lines = reverse( split(@a, '\n') )
    let s:idx = 1
    let s:bail = min([ 10, len( s:lines ) ])
    while s:idx < s:bail
        let s:rows = split( s:lines[ s:idx ], '\s\+' )
        if abs( s:rows[ 1 ] - s:current_line ) > 1
            echo "Jumped to line " . s:rows[ 1 ] . " from " . s:current_line
            execute "normal " . s:rows[ 1 ] . "G"
            keepjumps execute "normal 0" . s:rows[ 2 ] . "l"
            break
        endif
        let s:idx = s:idx + 1
    endwhile
endfunction

nnoremap g; :call FixJumpChangeList()<cr>

" Attempt to show what folder files are in, but paths are too long on dojo
"function! MyTabLine()
    "let s = ''

    "let path = split(expand('%:p'), '/')
    "return path[-2] . '/' . path[-1]

    "return s
"endfunction
"set guitablabel=%!MyTabLine()

" Remove non visible buffers
" From http://stackoverflow.com/questions/1534835/how-do-i-close-all-buffers-that-arent-shown-in-a-window-in-vim
function! Wipeout()
    "From tabpagebuflist() help, get a list of all buffers in all tabs
    let tablist = []
    for i in range(tabpagenr('$'))
        call extend(tablist, tabpagebuflist(i + 1))
    endfor

    "Below originally inspired by Hara Krishna Dara and Keith Roberts
    "http://tech.groups.yahoo.com/group/vim/message/56425
    let nWipeouts = 0
    for i in range(1, bufnr('$'))
        if bufexists(i) && !getbufvar(i,"&mod") && index(tablist, i) == -1
            "bufno exists AND isn't modified AND isn't in the list of buffers
            "open in windows and tabs
            silent exec 'bwipeout' i
            let nWipeouts = nWipeouts + 1
        endif
    endfor
    echomsg nWipeouts . ' buffer(s) wiped out'
endfunction

" Fix vim's default shitty { } motions
" see http://stackoverflow.com/questions/1853025/make-and-ignore-lines-containing-only-whitespace
function! ParagraphMove(delta, visual, count)
    normal m'
    normal |
    if a:visual
        normal gv
    endif

    if a:count == 0
        let limit = 1
    else
        let limit = a:count
    endif

    let i = 0
    while i < limit
        if a:delta > 0
            " first whitespace-only line following a non-whitespace character
            let pos1 = search("\\S", "W")
            let pos2 = search("^\\s*$", "W")
            if pos1 == 0 || pos2 == 0
                let pos = search("\\%$", "W")
            endif
        elseif a:delta < 0
            " first whitespace-only line preceding a non-whitespace character
            let pos1 = search("\\S", "bW")
            let pos2 = search("^\\s*$", "bW")
            if pos1 == 0 || pos2 == 0
                let pos = search("\\%^", "bW")
            endif
        endif
        let i += 1
    endwhile
    normal |
endfunction

nnoremap <silent> } :<C-U>call ParagraphMove( 1, 0, v:count)<CR>
nnoremap <silent> { :<C-U>call ParagraphMove(-1, 0, v:count)<CR>

" Make all searches very magic. Also mark the position before you start
" searching to copy text back to
nnoremap / ms/\v
" do not use this awful shit, it makes it hard to type :%s//replace
"cnoremap %s/ %s/\v

" remove \v with keystroke
cnoremap <C-v> <C-f>02l"zyg_:q<cr>/<c-r>za

" When switching tabs, attempt to move cursor to a file and out of nerdtree,
" quickfix and help windows
function! FuckAllOfVim()

    for i in [1, 2, 3]
        let s:_ft = &filetype
        if s:_ft == "nerdtree" || s:_ft == "help" || s:_ft == "qf"
            execute "wincmd w"
        else
            break
        endif
    endfor

endfunction

autocmd FileType nerdtree cnoreabbrev <buffer> bd :echo "No you don't"<cr>
" If typing bd in quickfix, close it then close the main tab
autocmd FileType qf cnoreabbrev <buffer> bd :echo "No you don't"<cr>

function! EditConflictFiles()
    let filter = system('git diff --name-only --diff-filter=U')
    let conflicted = split( filter, '\n')
    let massaged = []

    for conflict in conflicted
        let tmp = substitute(conflict, '\_s\+', '', 'g')
        if len( tmp ) > 0
            call add( massaged, tmp )
        endif
    endfor

    call ProcessConflictFiles( massaged )
endfunction

function! EditConflitedArgs()
    call ProcessConflictFiles( argv() )
endfunction

" Experimental function to load vim with all conflicted files
function! ProcessConflictFiles( conflictFiles )
    " These will be conflict files to edit
    let conflicts = []

    " Read git attributes file into a string
    silent! let gitignore = readfile('.gitattributes')
    let ignored = []
    for ig in gitignore
        " Remove any extra things like -diff (this could be improved to
        " actually use some syntax to know which files ot ignore, like check
        " if [1] == 'diff' ?
        let spl = split( ig, ' ' )
        if len( spl ) > 0
            call add( ignored, spl[0] )
        endif
    endfor

    " Loop over each file in the arglist (passed in to vim from bash)
    for conflict in a:conflictFiles

        " If this file is not ignored in gitattributes (this could be improved)
        if index( ignored, conflict ) < 0

            " Grep each file for the starting error marker
            let cmd = system("grep -n '<<<<<<<' ".conflict)

            " Remove the first line (grep command) and split on linebreak
            let markers = split( cmd, '\n' )

            for marker in markers
                let spl = split( marker, ':' )

                " If this line had a colon in it (otherwise it's an empty line
                " from command output)
                if len( spl ) == 2

                    " Get the line number by removing the white space around it,
                    " because vim is a piece of shit
                    let line = substitute(spl[0], '\_s\+', '', 'g')
                    
                    " Add this file to the list with the data format for the quickfix
                    " window
                    call add( conflicts, {'filename': conflict, 'lnum': line, 'text': spl[1]} )
                endif
            endfor
        endif
        
    endfor

    " Set the quickfix files and open the list
    call setqflist( conflicts )
    execute 'copen'
    execute 'cfirst'

    " Highlight diff markers and then party until you shit
    highlight Conflict guifg=white guibg=red
    match Conflict /^=\{7}.*\|^>\{7}.*\|^<\{7}.*/
    echom "Use ]n or [n to navigate to conflict markers with vim-unimpaired"
endfunction

" Move current tab into the specified direction.
"
" @param direction -1 for left, 1 for right.
function! TabMove(direction)
    let s:current_tab = tabpagenr()
    let s:total_tabs = tabpagenr("$")

    " Wrap to end
    if s:current_tab == 1 && a:direction == -1
        tabmove
    " Wrap to start
    elseif s:current_tab == s:total_tabs && a:direction == 1
        tabmove 0
    " Normal move
    else
        execute (a:direction > 0 ? "+" : "-") . "tabmove"
    endif
    echo "Moved to tab " . tabpagenr() . " (previosuly " . s:current_tab . ")"
endfunction

" Move tab left or right
map <D-H> :call TabMove(-1)<CR>
map <D-L> :call TabMove(1)<CR>

function! JumpToWebpackError()
    let cmd = system("node ./find_webpack_error.js")
    let place = split( cmd, ' ' )
    exe ":tabe " . place[0]
endfunction

nnoremap <leader>fw :call JumpToWebpackError()<cr>

" Count number of splits in current buffer, ignoring nerd tree
function! GuiTabLabel()
    let label = ''
    let bufnrlist = tabpagebuflist(v:lnum)

    " Add '+' if one of the buffers in the tab page is modified
    for bufnr in bufnrlist
    if getbufvar(bufnr, "&modified")
        let label = '+'
        break
    endif
    endfor

    let panes = map(range(1, tabpagenr('$')), '[v:val, bufname(winbufnr(v:val))]')
    let wincount = tabpagewinnr(v:lnum, '$')
    echo join(panes, ':')

    for pane in panes
        if !empty(matchstr(pane[1], 'NERD\|/runtime/doc/')) || empty(pane[1])
            let wincount -= 1
        endif
    endfor

    " Append the number of windows in the tab page if more than one
    if wincount > 1
        let label .= '('.wincount.') '
    endif

    " Append the buffer name
    return label . fnamemodify(bufname(bufnrlist[tabpagewinnr(v:lnum) - 1]), ':t')
endfunction

function! HandleURI()
    let s:uri = matchstr(getline("."), '[a-z]*:\/\/[^ >,;:]*')
    echo s:uri
    if s:uri != ""
        exec "!open \"" . s:uri . "\""
    else
        echo "No URI found in line."
    endif
endfunction

function! ToggleRelativeAbsoluteNumber()
    if &number
    set relativenumber
    else
    set number
    endif
endfunction

function! Refactor()
    call inputsave()
    let @z=input("What do you want to rename '" . @z . "' to? ")
    call inputrestore()
endfunction

function! s:VSetSearch()
    let old = @"
    norm! gvy
    let @/ = '\V' . substitute(escape(@", '\'), '\n', '\\n', 'g')
    let @" = old
endfunction

" Visual ack, used to ack for highlighted text
function! s:VAck()
    let old = @"
    norm! gvy
    let @z = substitute(escape(@", '\'), '\n', '\\n', 'g')
    let @" = old
endfunction

" Jump to template definition
function! s:TemplateAck()
    let old = @"
    norm! gvy
    let list = split(@", "\\.")

    " not namespaced
    if len(list) == 1
        let @z = "'{template.\\." . list[0] . "}' --soy -1 --nocolor"
    " namespaced
    elseif
        let @z = "'^(?\\!.*namespace.*" . list[0] . ").*" . list[1] . "' --soy -1 --nocolor"
    end
    let @" = old

    redir => captured
    exe ":silent !ack " . @z
    redir END

    let lines = split(captured)
    let lineNo = split(lines[6], ":")[0]

    exe ":tabe " . lines[5]
    " Jump to line no
    exe "normal" . lineNo . "GV"
endfunction

" Jump to template definition
function! s:SSPAck()
    let old = @"
    norm! gvy

    " not namespaced
    let @z = '. -regex ".*' . @" . '.ssp"'
    let @" = old

    redir => captured
    exe ":silent !find " . @z
    redir END

    exe ":tabe " . split(captured)[4]
endfunction

" }}}
" Highlight Word {{{
"
" This mini-plugin provides a few mappings for highlighting words temporarily.
"
" Sometimes you're looking at a hairy piece of code and would like a certain
" word or two to stand out temporarily.  You can search for it, but that only
" gives you one color of highlighting.  Now you can use <leader>N where N is
" a number from 1-6 to highlight the current word in a specific color.

function! HiInterestingWord(n)
    " Save our location.
    normal! mz

    " Yank the current word into the z register.
    normal! "zyiw

    " Calculate an arbitrary match ID.  Hopefully nothing else is using it.
    let mid = 86750 + a:n

    " Clear existing matches, but don't worry if they don't exist.
    silent! call matchdelete(mid)

    " Construct a literal pattern that has to match at boundaries.
    let pat = '\V\<' . escape(@z, '\') . '\>'

    " Actually match the words.
    call matchadd("InterestingWord" . a:n, pat, 1, mid)

    " Move back to our original location.
    normal! `z
endfunction

" Clear all matches
function! GoShitHiInterestingWord()
    let mid = 86750
    silent! call matchdelete(mid + 1)
    silent! call matchdelete(mid + 2)
    silent! call matchdelete(mid + 3)
    silent! call matchdelete(mid + 4)
    silent! call matchdelete(mid + 5)
    silent! call matchdelete(mid + 6)
endfunction

hi def InterestingWord1 guifg=#000000 ctermfg=16 guibg=#ffa724 ctermbg=214
hi def InterestingWord2 guifg=#000000 ctermfg=16 guibg=#aeee00 ctermbg=154
hi def InterestingWord3 guifg=#000000 ctermfg=16 guibg=#8cffba ctermbg=121
hi def InterestingWord4 guifg=#000000 ctermfg=16 guibg=#b88853 ctermbg=137
hi def InterestingWord5 guifg=#000000 ctermfg=16 guibg=#ff9eb8 ctermbg=211
hi def InterestingWord6 guifg=#000000 ctermfg=16 guibg=#ff2c4b ctermbg=195

nnoremap <silent> <leader>h1 :call HiInterestingWord(1)<cr>
nnoremap <silent> <leader>h2 :call HiInterestingWord(2)<cr>
nnoremap <silent> <leader>h3 :call HiInterestingWord(3)<cr>
nnoremap <silent> <leader>h4 :call HiInterestingWord(4)<cr>
nnoremap <silent> <leader>h5 :call HiInterestingWord(5)<cr>
nnoremap <silent> <leader>h6 :call HiInterestingWord(6)<cr>
" Turn off above
nnoremap <silent> <leader>hx :call GoShitHiInterestingWord()<cr>
nnoremap <silent> <leader>h0 :call GoShitHiInterestingWord()<cr>
nnoremap <silent> <leader>hd :call GoShitHiInterestingWord()<cr>

" Remove enter from clickable action
let g:clickable_maps = '<2-LeftMouse>,<C-2-LeftMouse>,<S-2-LeftMouse>,<C-CR>,<S-CR>,<C-S-CR>'

" ---------------------------------------------------------------
" Key mappings
" ---------------------------------------------------------------

" change the mapleader from \ to ,
let mapleader = "\<Space>"
" experimental - enter to go into command mode (otherwise useless shortcut).
" See clickable_maps for preventing vim clickable from fucking this up. Also
" see :h <cr> which is duplicated by BOTH ctrl-m AND + lol
" I never ended up using this bullshit
" nmap <CR> :
" autocmd FileType vim,quickfix,qf nnoremap <buffer> <CR> <CR>
" todo: map tab to something? currently is same as <c-i>

" add mappings for q* because hitting q in nerdtree can make it shit
nnoremap <leader>: q:
nnoremap <leader>? q/

" Title case a line or selection (better)
vnoremap <Leader>ti :s/\%V\<\(\w\)\(\w*\)\>/\u\1\L\2/ge<cr>
nnoremap <Leader>ti :s/.*/\L&/<bar>:s/\<./\u&/g<cr>

" lets you do w!! to sudo write the file
nnoremap <Leader>ww :w !sudo tee % >/dev/null<cr>

" delete a line, but only copy a whitespace-trimmed version to " register
nnoremap <Leader>dd _yg_"_dd
nnoremap <Leader>yy _yg_

" Ray-Frame testing thingy
" nnoremap <Leader>x:tabe a.js<cr>GVggx"*p<cr>:%s/;/;\r/g<cr>:w<cr>

nnoremap <Leader>x :tabcl<cr>:call Wipeout()<cr>
nnoremap <D-w> :tabcl<cr>

" zg is the stupidest fucking shortcut and I hit it all the time
nnoremap zg z=

" underline a line with dashes or equals
nnoremap <Leader>r- :t.<cr>:norm 0vg_r-<cr>
nnoremap <Leader>r= :t.<cr>:norm 0vg_r=<cr>

" New tab
nnoremap <Leader>te :tabe 

" Gundo tree viewer
nnoremap <Leader>u :GundoToggle<CR>

nnoremap <Leader>op :call HandleURI()<CR>

" Clear search highlighting so you don't have to search for /asdfasdf
nnoremap <silent> <Leader>/ :nohlsearch<CR>

" Jump backwards to previous function, assumes code is indented (useful when inside function)
" Jump to top level function
" nnoremap <Leader>f ?^func\\|^[a-zA-Z].*func<CR>,/

" faster tab switching. I never use these cause macvim
"nnoremap <C-l> gt
"nnoremap <C-h> gT

" Fugitive
nnoremap <Leader>gs :Gstatus<CR>
nnoremap <Leader>gc :Gcommit<CR>
nnoremap <Leader>gd :Gdiff<CR>
nnoremap <Leader>gb :Gblame<CR>

" Extradite
nnoremap <Leader>gl :Extradite!<CR>

" Git Gutter colors
highlight SignColumn guibg=#111111
highlight GitGutterAdd guifg=#00ff00
highlight GitGutterChange guifg=#fff000 guibg=#111111
highlight GitGutterChangeDelete guifg=#fff000 guibg=#111111

let g:gitgutter_sign_column_always = 1
let g:gitgutter_sign_removed = '-'
let g:gitgutter_sign_removed_first_line = '-'
let g:gitgutter_sign_modified_removed = '-'
let g:gitgutter_sign_modified = '*'

function! ToggleQuickFix()
    if exists("g:qwindow")
        cclose
        execute "wincmd p"
        unlet g:qwindow
    else
        try
            copen
            execute "wincmd J"
            let g:qwindow = 1
        catch
            echo "Error!"
        endtry
    endif
endfunction

nnoremap <Leader>cx :call ToggleQuickFix()<CR>

" Ack
nnoremap <Leader>aw "zyiw:exe "Ack! ".@z.""<CR>
nnoremap <Leader>aW "zyiW:exe "Ack! ".@z.""<CR>

" Source vim when this file is updated
nnoremap <Leader>sv :source $MYVIMRC<cr>
nnoremap <silent> <Leader>so :source %<cr>
nnoremap <Leader>v :tabe $MYVIMRC<cr>
nnoremap <Leader>ss :tabe ~/.vim/delvarworld-snippets/javascript/javascript.snippets<cr>
nnoremap <Leader>hs :tabe /etc/hosts<cr>:setlocal noreadonly<cr>:setlocal autoread<cr>
nnoremap <Leader>js :tabe ~/.jsl<cr>

function! CopyPathOrNERDPath()
    let s:ft = &filetype
    if s:ft == "nerdtree"
        let s:n = g:NERDTreeFileNode.GetSelected()
        if s:n != {}
            let@*=s:n.path.str()
            echo "Copied file path to clipboard"
        endif
    else
        let @*=expand("%")
        echo "Copied file path to clipboard"
    endif
endfunction

" Copy current buffer path relative to root of VIM session to system clipboard
nnoremap <Leader>yp :call CopyPathOrNERDPath()<cr>
" Copy current filename to system clipboard
nnoremap <Leader>yf :let @*=expand("%:t")<cr>:echo "Copied file name to clipboard"<cr>
" Copy current buffer path without filename to system clipboard
nnoremap <Leader>yd :let @*=expand("%:h")<cr>:echo "Copied file directory to clipboard"<cr>

" select last yanked / pasted text
nnoremap <Leader>ht `[v`]

" select last paste in visual mode
nnoremap <expr> gb '`[' . strpart(getregtype(), 0, 1) . '`]'

" NerdTree
nnoremap <Leader>nt :NERDTreeTabsToggle<cr>

" by default nerdtreefind will IGNORE your cwd/pwd if nerdtree is closed, and
" open the tree with the root being the folder of the file you're in. I'm not
" kidding.
function! OpenNerdTreeAndFindThisBullshit()
  let s:open = exists("t:NERDTreeBufName") && bufwinnr(t:NERDTreeBufName) != -1
  if s:open
    5wincmd h
    normal R
    " hurrrggghhhh
    wincmd w
    NERDTreeFind
  else
    NERDTreeTabsToggle
    " omgggggg
    wincmd w
    NERDTreeFind
  endif
endfunction

" make nerdtree expand dir structure to show current file
nnoremap <silent> <Leader>nf :call OpenNerdTreeAndFindThisBullshit()<cr>

" Change to working directory of current file and echo new location
nnoremap cd :cd %:h<cr>:pwd<cr>

" Surround mappings, switch " and ' with c
nmap c' cs'"
nmap c" cs"'

" Prepare a file prefixed with the path of the current buffer
nmap <Leader>e :e <C-R>=expand("%:p:h") . "/" <CR>

" K is one of the dumber things in vim
map K k

" Swap two parameters in a function
nnoremap <Leader>- lF(ldWf)i, pF,dt)

" Strip one layer of nesting
nnoremap <Leader>sn [{mzjV]}k<]}dd`zdd

" MRU mappings, open most recent files list
nnoremap <Leader>ml :MRU<cr>
" Opens mru which lets files autocomplete
nnoremap <Leader>me :MRU 

" Alphabetize CSS rules if on mulitple lines
nnoremap <Leader>rs vi{:sort<cr>

" trim trailing whitespace
noremap <Leader>sw :let _s=@/<Bar>:%s/\s\+$//e<Bar>:let @/=_s<Bar>:nohl<CR>

" * and # search for next/previous of selected text when used in visual mode
vnoremap * :<C-u>call <SID>VSetSearch()<CR>/<CR>
vnoremap # :<C-u>call <SID>VSetSearch()<CR>?<CR>

" Ack for visual selection
vnoremap <Leader>av :<C-u>call <SID>VAck()<CR>:exe "Ack! ".@z.""<CR>
" Ack for word under cursor
nnoremap <Leader>av :Ack!<cr>
" Open Ack
nnoremap <Leader>ao :Ack! -i 
nnoremap <Leader>aa :Ack! 

nnoremap <Leader>at vi":<C-u>call <SID>TemplateAck()<CR>

nnoremap <Leader>as vi":<C-u>call <SID>SSPAck()<CR>

" tabularize around : or =
vnoremap <silent> <Leader>tt :Tabularize /:\zs/l0r1<CR>
vnoremap <silent> <Leader>t= :Tabularize /=\zs/l0r1<cr>
vnoremap <silent> <Leader>t, :Tabularize /,\zs/l0r1<cr>
nnoremap <silent> <Leader>tt :Tabularize<CR>

" Execute VIM colon command under cursor with <⌘-e>
nnoremap <D-e> yy:<C-r>"<backspace><cr>

" Locally (local to block) rename a variable
nnoremap <Leader>rf "zyiw:call Refactor()<cr>mx:silent! norm gd<cr>:silent! norm [{<cr>$V%:s/<C-R>//<c-r>z/g<cr>`x

" Copy line to last changed postition. This doesn't work or some shit??
nnoremap <silent> <Leader>t. :t'.<cr>
vnoremap <silent> <Leader>t. :t'.<cr>

" copy last changed line here
nnoremap <silent> <Leader>t; :'.t.<cr>
vnoremap <silent> <Leader>t; :'.t.<cr>

" Make Y yank till end of line
nnoremap Y y$

" In command line mode use ctrl-direction to move instead of arrow keys
cnoremap <C-j> <t_kd>
cnoremap <C-k> <t_ku>
cnoremap <C-a> <Home>
cnoremap <C-e> <End>

" See also https://github.com/tpope/vim-rsi
" Ctrl-e: Go to end of line like bash and command mode
inoremap <c-e> <esc>A

" Ctrl-a: Go to start of line like bash and command mode
"inoremap <c-a> <esc>I
" Commenting this out to try using ctlr-a for inserting last inserted text

" Ctrl-[hl]: Move left/right by word
cnoremap <c-h> <s-left>
cnoremap <c-l> <s-right>

" Same for insert mode, including up down
inoremap <c-h> <s-left>
inoremap <c-l> <s-right>
" Ctrl-j: Move cursor up
inoremap <expr> <c-j> pumvisible() ? "\<C-e>\<Down>" : "\<Down>"

" Ctrl-k: Move cursor up
inoremap <expr> <c-k> pumvisible() ? "\<C-e>\<Up>" : "\<Up>"

" Toggle relative / line number. I never use this garbage
"nnoremap <leader>rl :call ToggleRelativeAbsoluteNumber()<CR>

" use space to cycle between splits. I never use this garbage
"nmap <S-Space> <C-w>W

" Delete current buffer
nmap <Leader>db :bdelete<CR>

" :W is now :w (http://stackoverflow.com/questions/3878692/aliasing-a-command-in-vim)
cnoreabbrev <expr> W ((getcmdtype() is# ':' && getcmdline() is# 'W')?('w'):('W'))

function! FormatPerlObj()
    silent! exec '%s/\v\S+\s*\=\>\s*[^,]*,/\0\r'
    silent! exec '%s/\v\S+\s*\=\>\s*\{/\0\r'
    silent! exec '%s/\v[^{]\zs\},/\r\0'
    normal vie=
    exec 'set ft=perl'
endfunction

function! FormatJson()
    silent! exec '%s/\v\S+\s*:\s*[^,]*,/\0\r'
    silent! exec '%s/\v\S+\s*:\s*\{/\0\r'
    silent! exec '%s/\v[^{]\zs\},/\r\0'
    normal vie=
    exec 'set ft=javascript'
endfunction

function! FormatVarList()
    silent! exec '%s/\v\S+\s*\=\>\s*[^,]*,/\0\r'
    silent! exec '%s/\v\S+\s*\=\>\s*\{/\0\r'
    silent! exec '%s/\v[^{]\zs\},/\r\0'
    normal vie=
    exec 'set ft=perl'
endfunction

" ------------------------------------------------------------------------------------------
" VIM setup
" ------------------------------------------------------------------------------------------

" Make all line substituions /g
set gdefault

set sessionoptions+=winpos

" Paste toggle
set pastetoggle=<F2>

" Don't want no lousy .swp files in my directoriez
set backupdir=/tmp
set directory=/tmp

" hide buffers instead of closing, can do :e on an unsaved buffer
set hidden

" Adding A flag, which is the shitty swap file warning
set shortmess=filnxtToOA

" wildignore all of these when autocompleting
set wig=*.swp,*.bak,*.pyc,*.class,node_modules*,*.ipr,*.iws,built,locallib

" shiftround, always snap to multiples of shiftwidth when using > and <
set shiftround

" Testing out relative line number
setglobal relativenumber

" from http://jeffkreeftmeijer.com/2012/relative-line-numbers-in-vim-for-super-fast-movement/
au FocusLost * :set number
au FocusGained * :set relativenumber

" errors in modifiable off files so silent :( vim is a gargabe joke
silent! set ff=unix
set ic
set smartcase
set guioptions=mer

set tabstop=4
set shiftwidth=4
set smarttab
set et

set nocindent
set autoindent
set lbr

" highlight search results
set hlsearch

" incsearch is search while typing, shows matches before hitting enter
set incsearch

" set bottom indicator
set ruler
set showcmd

" Give one virtual space at end of line
set virtualedit=onemore

" Powerline symbols instead of letters
let g:Powerline_symbols = 'fancy'

" Always have statusline so powerline shows up on non-split windows
set laststatus=2

" Don't open nerdtree feature expander open on startup
let g:nerdtree_tabs_open_on_gui_startup=0

" Include $ in varibale names
set iskeyword=@,48-57,_,192-255,#,$

" Ignore syntastic warnings
" let g:syntastic_quiet_warnings=1
" Place error visual marker in gutter
let g:syntastic_enable_signs=1
let g:syntastic_perl_lib_path = [ './locallib/lib/perl5' ]
let g:syntastic_javascript_checkers = ['eslint']
let g:syntastic_always_populate_loc_list = 1

" Vim-script-unner
let g:script_runner_perl = "perl -Ilib -MData::Dumper -Mv5.10"
let g:script_runner_javascript = "node"

" Backspace: Act like normal backspace and go into insert mode
nnoremap <bs> i<bs>

" Hitting z= over a word will replace it with the closest dictionary word,
" even if spellcheck is not enabled, because vim is bad
function! FixVimSpellcheck()
    if &spell
        normal! 1z=
    else
        set spell
        normal! 1z=
        set nospell
    endif
endfunction

" Use the first suggestion for vim's text replace
nnoremap z= :call FixVimSpellcheck()<cr>

" Vimshell plugin settings
" VIMSHELL IS BULLSHIT FOREVER
"let g:vimshell_user_prompt = 'fnamemodify(getcwd(), ":~")'
"let g:vimshell_prompt =  '$ '

" Tern?
" TERN IS BULLSHIT FOREVER
"let g:tern_map_keys = 1
"let g:tern_show_argument_hints='on_hold'
"let g:tern#command = ['node', '/Users/DelvarWorld/configs/.vim/bundle/tern_for_vim/autoload/../node_modules/tern/bin/tern', '--verbose']

" Project?
set rtp+=~/.vim/bundle/vim-project/
let g:project_disable_tab_title = 1
"let g:project_enable_welcome = 0
let g:project_use_nerdtree = 1
" custom starting path
call project#rc("~/")

Project  '~/shader-studio'               , 'shader-studio'
Project  '~/runtime-shaderfrog'          , 'shaderfrog-runtime'
Project  '~/poopy-butts'                 , 'poopy-butts'
Project  '~/cats-react'                  , 'cats-react'
Project  '~/big-bubble'                  , 'bubble'
Project  '~/glsl2js'                     , 'parser'
Project  '~/mood-engine'                 , 'mood engine'
Project  '~/blog'                        , 'blog'
Project  '~/blag'                        , 'blag'

" Format a var declaration list using tabularize
function! FormatEquals()
    normal gg
    let @z=@/
    let @/='\v^((var.+\=.+;|import.+from.+|^)(\n^$))+(\n^((var.+\=.+require|import)@!|var.+createClass))'
endfunction

nnoremap <leader>= :call FormatEquals()<cr> <bar> Vn:Tabularize /\v(\=\|from)<cr> <bar> :let @/=@z<cr>

function! DojoSettings(tile) abort
    set tabstop=2
    set shiftwidth=2
endfunction

function! DojoReactTestOpen()
    let s:fname = expand("%")
    let s:matches = matchlist(s:fname, '\v(test|public\/app)\/react\/(views|components)\/(.+\.jsx?)')

    if s:matches[1] == "test"
        let s:dir = "public/app"
    else
        let s:dir = "test"
    endif

    execute "vnew " . s:dir . "/react/" . s:matches[2] . "/" . s:matches[3]
endfunction

function! MojoToDojo()

    " class > className
    silent! exec '%s/\vclass\s?\=\s?/className='

    " for > htmlFor
    silent! exec '%s/\vfor\s?\=\s?/htmlFor='

    " replace logo tag
    silent! exec '%s/\V{{ logo: {} }}/\<div className="student-logo center">\r  <img src="img\/studentSignup\/logo.png" \/>\r<\/div>'

    " remove html comments. trid this with /d but didn't delete multiline last
    " line
    silent! exec ':%s/\v^\s*\<\!\-\-(\_.){-}\-\-\>\n/'

    " Translate strings, remove empty interpolations
    silent! exec '%s/' .  '\v\{\{\s+%(html: )?[''"]([^''"]+)[''"]\s+\|\s+t\((\_.{-})?\)\s+\}\}' . '/\=TranslateMojoMatch(submatch(1), submatch(2))'

    " Replace simple onClick handlers
    silent! exec '%s/\v\vdata-bind\s?\=\s?[''"]\{\{\s?onClick:\s*(\w+)\(\)\s*\}\}[''"]\s*/onClick={this.\1} '

    " add react chrome
    " exec 'normal ggOvar React = require("react");var VIEW = React.createClass({  getInitialState:�� function()�� {},componentDidMount:�� function()�� {},componentWillUnmount:�� function()�� {},render:�� function()�� {d�kb  return (<div>j0maVG>..Go</div>);}});k<<j<<<<omodule.exports = VIEW;'

endfunction

function! TranslateMojoMatch(str, vars)
    let s:intent = system("node i18n-grab.js ". a:str)
    let s:output = '<T intent="' . s:intent . '" str="' . a:str . '"'
    if a:vars != ""
        let s:output .= ' vars={' . a:vars . '}'
    endif
    return s:output . ' />'
endfunction

nnoremap <leader>df :call DojoReactTestOpen()<cr>

" default starting path (the home directory)
call project#rc()

set path=.,/usr/include,$PWD

vmap  <expr>  <LEFT>   DVB_Drag('left')
vmap  <expr>  <RIGHT>  DVB_Drag('right')
vmap  <expr>  <DOWN>   DVB_Drag('down')
vmap  <expr>  <UP>     DVB_Drag('up')
vmap  <expr>  D        DVB_Duplicate()

"===============================================================================
" Unite
"===============================================================================

" Use the fuzzy matcher for everything
"call unite#filters#matcher_default#use(['matcher_fuzzy'])

" Use the rank sorter for everything
"call unite#filters#sorter_default#use(['sorter_rank'])

"nnoremap    [unite]   <Nop>

" Quickly switch lcd
"nnoremap <c-f><c-d> :Unite -buffer-name=change-cwd -default-action=lcd directory_mru<CR>

" General fuzzy search
"nnoremap <silent> [unite]<space> :<C-u>Unite
      "\ -buffer-name=files buffer file_mru bookmark file_rec/async<CR>

"nnoremap <C-p> :Unite file_rec/async<cr>

" Quick yank history
"nmap <c-y> [unite]y
"nnoremap <silent> [unite]y :<C-u>Unite -buffer-name=yanks history/yank<CR>

" Quick snippet
"nnoremap <silent> [unite]s :<C-u>Unite -buffer-name=snippets snippet<CR>

" Quick file search
"nmap <c-f><c-a> [unite]f
"nnoremap <silent> [unite]f :<C-u>Unite -buffer-name=files file_rec/async file/new<CR>

" Quick MRU search
"nmap <c-m> [unite]m
"nnoremap <silent> [unite]m :<C-u>Unite -buffer-name=mru file_mru<CR>

" Quick commands
"nnoremap <silent> [unite]c :<C-u>Unite -buffer-name=commands command<CR>

" Quick bookmarks
"nnoremap <silent> [unite]b :<C-u>Unite -buffer-name=bookmarks bookmark<CR>
"

let g:unite_source_history_yank_enable = 1
let g:unite_split_rule = "botright"
let g:unite_update_time = 200
let g:unite_enable_start_insert = 1

autocmd FileType unite call s:unite_my_settings()
function! s:unite_my_settings()
    " Overwrite settings.
    nmap <buffer> <ESC>      <Plug>(unite_exit)
endfunction

" Highlight trailing whitespace in vim on non empty lines, but not while
" typing in insert mode!
highlight ExtraWhitespace ctermbg=red guibg=Brown
au ColorScheme * highlight ExtraWhitespace guibg=red
au BufEnter * match ExtraWhitespace /\S\zs\s\+$/
au InsertEnter * match ExtraWhitespace /\S\zs\s\+\%#\@<!$/
au InsertLeave * match ExtraWhiteSpace /\S\zs\s\+$/

" Jump to last known cursor position when opening file
" WARNING: This appears to fuck up jump to line when opening a file with CtrlP
autocmd BufReadPost *
    \ if line("'\"") > 0 && line ("'\"") <= line("$") |
    \ exe "normal g'\"" |
    \ endif

" Resize splits when the window is resized
au VimResized * :wincmd =

" In commit edit turn on spell check, make diff bigger, and switch to other
" window in insertmode
au BufNewFile,BufRead COMMIT_EDITMSG setlocal spell | DiffGitCached

" Make Splat-v repeatable and not full of shit
inoremenu Edit.Paste <C-r><C-p>*

" More commands in q: q/ etc
set history=200

"TEMPORARYILY REMOVING THIS BULLSHIT
"let g:UltiSnipsExpandTrigger="<c-enter>"
"let g:UltiSnipsJumpForwardTrigger="<c-b>"
"let g:UltiSnipsJumpBackwardTrigger="<c-z>"

" Ultisnips OLD SHIT, RETRYING
" Trigger configuration. Do not use <tab> if you use https://github.com/Valloric/YouCompleteMe.
" let g:UltiSnipsExpandTrigger="<c-b>"
" See this disgusting bullshit https://github.com/Valloric/YouCompleteMe/issues/36#issuecomment-15451411
let g:UltiSnipsJumpBackwardTrigger='<c-z>'

let g:UltiSnipsSnippetDirectories=[ 'UltiSnips', 'delvarworld-snippets' ]

" If you want :UltiSnipsEdit to split your window.
let g:UltiSnipsEditSplit="vertical"

function! g:UltiSnips_Complete()
    call UltiSnips#ExpandSnippet()
    if g:ulti_expand_res == 0
        if pumvisible()
            return "\<C-n>"
        else
            call UltiSnips#JumpForwards()
            if g:ulti_jump_forwards_res == 0
               return "\<TAB>"
            endif
        endif
    endif
    return ""
endfunction

au BufEnter * exec "inoremap <silent> " . g:UltiSnipsExpandTrigger . " <C-R>=g:UltiSnips_Complete()<cr>"
let g:UltiSnipsJumpForwardTrigger="<tab>"
let g:UltiSnipsListSnippets="<c-e>"
" this mapping Enter key to <C-y> to chose the current highlight item and
" close the selection list, same as other IDEs.  CONFLICT with some plugins
" like tpope/Endwise
inoremap <expr> <CR> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
" END Ultisnips OLD SHIT, RETRYING END

" ----------------------------------------------------------------------
" ----------------------------------------------------------------------
" ---------------------- VIM IS SHIT -----------------------------------
" ----------------------------------------------------------------------
" ----------------------------------------------------------------------

" Someone should be permanently fired over this
nmap Q q

autocmd TabLeave * call FuckAllOfVim()

" vim is sooo baddddd http://vim.wikia.com/wiki/Automatically_quit_Vim_if_quickfix_window_is_the_last
au BufEnter * call QuickfixBullshit()
function! QuickfixBullshit()
    " if the window is quickfix go on
    if &buftype=="quickfix"
        " if this window is last on screen quit without warning
        if winbufnr(2) == -1
            quit!
        endif
    endif
endfunction

" If typing bd in nerdtree, switch to main file and close that instead
autocmd FileType nerdtree cnoreabbrev <buffer> bd :echo "No you don't"<cr>
" If typing bd in quickfix, close it then close the main tab
autocmd FileType qf cnoreabbrev <buffer> bd :echo "No you don't"<cr>

let NERDTreeIgnore=['pubilc-build']
 
function! s:DimInactiveWindows()
  for i in range(1, tabpagewinnr(tabpagenr(), '$'))
    let l:range = "80"
    if i != winnr()
      if &wrap
        " HACK: when wrapping lines is enabled, we use the maximum number
        " of columns getting highlighted. This might get calculated by
        " looking for the longest visible line and using a multiple of
        " winwidth().
        let l:width=256 " max
      else
        let l:width=winwidth(i)
      endif
      let l:range = join(range(1, l:width), ',')
    endif
    call setwinvar(i, '&colorcolumn', l:range)
  endfor
endfunction

augroup DimInactiveWindows
  au!
  au WinEnter * call s:DimInactiveWindows()
augroup END

" LOL VIM LITERALLY CAN'T INDENT HTML AND THERE'S NO HELP FOR THIS VARIABLE
" LOOOOOL BUT LOOK AT :h html-indent **OBVIOUSLY**
let g:html_indent_inctags = "body,head,tbody,p"
" This does not work, obviously, it should make anything inside html tags not
" indented. myabe a plugin conflict?
let g:html_indent_autotags = "html"

" you have to call the below function IN THE HTML BUFFER after setting the
" global variables. Jesus, vim.
" call HtmlIndent_CheckUserSettings()

" Delimit Mate plugin config
let delimitMate_expand_space = 1 " Make typing space after (| convert to ( | )
let delimitMate_balance_matchpairs = 1

" ------------------------------------------------------------------------------------------
" I no spell gud
" ------------------------------------------------------------------------------------------

ab bototm bottom
ab funcion function
ab funicton function
ab funciton function
ab fucntion function
ab dupate update
ab upate update
ab udpate update
ab updateable updatable
ab Updateable Updatable
ab conosle console
ab campaing campaign
ab camapign campaign
ab campigan campaign
ab campagin campaign
ab campagn campaign
ab campiagn campaign
ab camapaign campaign
ab respone response
ab closeset closest
ab contribuiton contribution
ab contribuiton contribution
ab contribuiotn contribution
ab conribution contribution
ab contribuitos contributions
ab contribuitos contributions
ab contribuiots contributions
ab conributions contributions
ab positon position
ab animaiton animation
ab promsie promise
ab siez size
ab palatte palette
ab palette palette
ab pallate palette
ab pallete palette
ab pallette palette
ab pallate palette
ab stlyes styles
" why is this an english word
ab glypg glyph
ab glpygh glyph
ab glpyh glyph
ab glpyh glyph
ab glpy glyph
ab glphy glyph
ab exprot export
ab improt import
ab paylaod payload
ab marign margin
ab marthin margin
ab amrgin margin

" ------------------------------------------------------------------------------------------
" Text objects?
" ------------------------------------------------------------------------------------------
" Fuck you uncommentable text objects
" regex_a:
"      Select around a regex `/bob/gi` with a/
" regex_i:
"      Select inside a regex /`bob`/gi with i/
" regex_r:
"       Select a css rule margin:`0 10px`; with ir
" regex_h:
"       I have no idea what this one was for
" regex_v:
"       Select a value?
" regex_in:
"       Select inside a number `-0.1`em with in
" regex_an:
"       Select around a number `-0.1em` with an
" regex_aa:
"       Select around (a)ttribute a="stuff" including jsx props a={hi}
" regex_ar:
" regex_ir:
"       Select inside around css (r)ules, including react createstyle rules.
"       Useful for ysr' to surround unquoted css
" regex_ih:
"       Inside ( function, args ) ignoring parens and whitespace. I (h)ave no
"       idea
"

call textobj#user#plugin('horesshit', {
\   'regex_j': {
\     'select': 'aj',
\     '*pattern*': '^\s*"\?\w\+"\?\s*:\s*{\_[^}]*}.*\n\?',
\   },
\   'regex_a': {
\     'select': 'ax',
\     '*pattern*': '\/.*\/[gicm]\{0,}',
\   },
\   'regex_i': {
\     'select': 'ix',
\     '*pattern*': '\/\zs.\+\ze\/'
\   },
\   'regex_ar': {
\     'select': 'ar',
\     '*pattern*': ':\zs.\+\ze(;|\s+)'
\   },
\   'regex_ir': {
\     'select': 'ir',
\     '*pattern*': '\v:\s*\zs.+\ze\s*[,;]\s*$'
\   },
\   'regex_h': {
\     'select': 'ih',
\     '*pattern*': '[a-zA-Z-\/]\+'
\   },
\   'regex_v': {
\     'select': 'iv',
\     '*pattern*': '[0-9a-zA-Z-\/-]\+'
\   },
\   'regex_in': {
\     'select': 'in',
\     '*pattern*': '\-\?[0-9\.]\+'
\   },
\   'regex_an': {
\     'select': 'an',
\     '*pattern*': '\-\?[\#0-9.a-z%]\+'
\   },
\   'regex_aa': {
\     'select': 'aa',
\     '*pattern*': '\v(\w|-)+\=[{"].{-}[}"]'
\   },
\   'regex_ia': {
\     'select': 'ia',
\     '*pattern*': '\v(\w|-)+\=[{"]\zs.{-}\ze[}"]'
\   },
\   'regex_ih': {
\     'select': 'ih',
\     '*pattern*': '\v((\w|[''"+,.])(\s\w)?)+'
\   },
\ })
