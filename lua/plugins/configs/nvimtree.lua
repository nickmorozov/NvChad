local api = require "nvim-tree.api"

-- Open by default
local function open_nvim_tree(data)
    -- buffer is a directory
    local directory = vim.fn.isdirectory(data.file) == 1
    -- buffer is a real file on the disk
    local real_file = vim.fn.filereadable(data.file) == 1
    -- buffer is a [No Name]
    local no_name = data.file == "" and vim.bo[data.buf].buftype == ""

    if directory then
        -- change to the directory
        vim.cmd.cd(data.file)
        -- open the tree
        api.tree.open()
    elseif real_file or no_name then
        -- open the tree but don't focus it
        api.tree.toggle { focus = false }
    end
end

vim.api.nvim_create_autocmd({ "VimEnter" }, {
    callback = open_nvim_tree,
})

-- Auto close when tree is last
local function tab_win_closed(winnr)
    local tabnr = vim.api.nvim_win_get_tabpage(winnr)
    local bufnr = vim.api.nvim_win_get_buf(winnr)
    local buf_info = vim.fn.getbufinfo(bufnr)[1]
    local tab_wins = vim.tbl_filter(function(w)
        return w ~= winnr
    end, vim.api.nvim_tabpage_list_wins(tabnr))
    local tab_bufs = vim.tbl_map(vim.api.nvim_win_get_buf, tab_wins)

    if buf_info.name:match ".*NvimTree_%d*$" then -- close buffer was nvim tree
        -- Close all nvim tree on :q
        if not vim.tbl_isempty(tab_bufs) then -- and was not the last window (not closed automatically by code below)
            api.tree.close()
        end
    else -- else closed buffer was normal buffer
        if #tab_bufs == 1 then -- if there is only 1 buffer left in the tab
            local last_buf_info = vim.fn.getbufinfo(tab_bufs[1])[1]

            if last_buf_info.name:match ".*NvimTree_%d*$" then -- and that buffer is nvim tree
                vim.schedule(function()
                    if #vim.api.nvim_list_wins() == 1 then -- if its the last buffer in vim
                        vim.cmd "quit" -- then close all of vim
                    else -- else there are more tabs open
                        vim.api.nvim_win_close(tab_wins[1], true) -- then close only the tab
                    end
                end)
            end
        end
    end
end

vim.api.nvim_create_autocmd("WinClosed", {
    callback = function()
        local winnr = tonumber(vim.fn.expand "<amatch>")
        vim.schedule_wrap(tab_win_closed(winnr))
    end,
    nested = true,
})

local options = {
    filters = {
        dotfiles = false,
        exclude = { vim.fn.stdpath "config" .. "/lua/custom" },
    },
    disable_netrw = true,
    hijack_netrw = true,
    hijack_cursor = true,
    hijack_unnamed_buffer_when_opening = true,
    sync_root_with_cwd = true,
    update_focused_file = {
        enable = true,
        update_root = false,
    },
    auto_reload_on_write = true,
    reload_on_bufenter = true,
    view = {
        adaptive_size = true,
        side = "left",
        width = {
            min = "10%",
            max = "30%",
        },
        preserve_window_proportions = false,
        cursorline = true,
        relativenumber = true,
    },
    git = {
        enable = false,
        ignore = true,
    },
    filesystem_watchers = {
        enable = true,
    },
    actions = {
        open_file = {
            resize_window = true,
        },
    },
    renderer = {
        root_folder_label = false,
        highlight_git = false,
        highlight_opened_files = "icon", -- "none|icon|all"
        highlight_modified = "all",
        add_trailing = true,
        group_empty = true,

        indent_markers = {
            enable = false,
        },

        icons = {
            show = {
                file = true,
                folder = true,
                folder_arrow = true,
                git = true,
            },

            glyphs = {
                default = "󰈚",
                symlink = "",
                folder = {
                    default = "",
                    empty = "",
                    empty_open = "",
                    open = "",
                    symlink = "",
                    symlink_open = "",
                    arrow_open = "",
                    arrow_closed = "",
                },
                git = {
                    unstaged = "✗",
                    staged = "✓",
                    unmerged = "",
                    renamed = "➜",
                    untracked = "★",
                    deleted = "",
                    ignored = "◌",
                },
            },
        },
    },
}

return options
