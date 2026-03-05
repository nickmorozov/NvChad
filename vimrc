
" Shared vim settings — sourced by both Neovim (NvChad) and IdeaVim (.ideavimrc)
"
" Keep this minimal: NvChad handles most nvim settings via Lua.
" This file is for settings that should also apply in JetBrains IDEs.

" Escape on jj/ff in insert mode
:imap jj <Esc>
:imap ff <Esc>

" Searching
set ignorecase          " Case-insensitive search
set smartcase           " ...unless pattern has uppercase
set hlsearch            " Highlight search results
set incsearch           " Highlight as you type

" Show matching brackets
set showmatch

" :W sudo saves the file (nvim only, not IdeaVim)
if has('nvim')
  command W w !sudo tee % > /dev/null
endif

" Highlight trailing whitespace
if has('nvim')
  :highlight ExtraWhitespace ctermbg=red guibg=red
  :match ExtraWhitespace /\s\+$/
endif
