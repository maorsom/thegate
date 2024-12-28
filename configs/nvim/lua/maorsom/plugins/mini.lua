return { -- Collection of various small independent plugins/modules
  "echasnovski/mini.nvim",
  config = function()
    local lazy = require("lazy.status")
    local icons = require("nvim-web-devicons")

    -- Better Around/Inside textobjects
    --
    -- Examples:
    --  - va)  - [V]isually select [A]round [)]paren
    --  - yinq - [Y]ank [I]nside [N]ext [']quote
    --  - ci'  - [C]hange [I]nside [']quote
    require("mini.ai").setup({ n_lines = 500 })

    -- Add/delete/replace surroundings (brackets, quotes, etc.)
    --
    -- - saiw) - [S]urround [A]dd [I]nner [W]ord [)]Paren
    -- - sd'   - [S]urround [D]elete [']quotes
    -- - sr)'  - [S]urround [R]eplace [)] [']
    require("mini.surround").setup()

    -- Simple and easy statusline.
    --  You could remove this setup call if you don't like it,
    --  and try some other statusline plugin
    local statusline = require("mini.statusline")
    -- set use_icons to true if you have a Nerd Font
    statusline.setup({ use_icons = vim.g.have_nerd_font })

    local blocked_filetypes = { ["neo-tree"] = true }

    ---@diagnostic disable-next-line: duplicate-set-field
    MiniStatusline.active = function()
      if blocked_filetypes[vim.bo.filetype] then
        vim.cmd("highlight StatusLine guibg=NONE guifg=NONE")
        return ""
      end

      local mode, mode_hl = MiniStatusline.section_mode({ trunc_width = 120 })
      local git = MiniStatusline.section_git({ trunc_width = 75 })
      local diagnostics = MiniStatusline.section_diagnostics({ trunc_width = 75 })
      local filename = MiniStatusline.section_filename({ trunc_width = 140 })
      local fileinfo, hl_group = MiniStatusline.section_fileinfo({ trunc_width = 120 })
      local location = MiniStatusline.section_location({ trunc_width = 75 })
      local search = MiniStatusline.section_searchcount({ trunc_width = 75 })

      return MiniStatusline.combine_groups({
        { hl = mode_hl, strings = { mode } },
        { hl = "MiniStatuslineDevinfo", strings = { git, diagnostics } },
        "%<", -- Mark general truncate point
        { hl = "MiniStatuslineFilename", strings = { filename } },
        "%=", -- End left alignment
        { hl = "@text.todo", strings = { lazy.updates() } },
        { hl = hl_group, strings = { fileinfo } },
        { hl = mode_hl, strings = { search, location } },
      })
    end

    ---@diagnostic disable-next-line: duplicate-set-field
    statusline.section_location = function()
      return "%2l:%-2v"
    end

    ---@diagnostic disable-next-line: duplicate-set-field
    statusline.section_fileinfo = function()
      return icons.get_icon(vim.fn.expand("%:t"), vim.fn.expand("%:e"))
    end
  end,
}
