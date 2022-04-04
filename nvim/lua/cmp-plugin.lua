-- Setup nvim-cmp.
local cmp = require'cmp'

local has_words_before = function()
    local line, col = unpack(vim.api.nvim_win_get_cursor(0))
    return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match('%s') == nil
end

local lsp_kinds = {
    Text                  = {''  , 'TSText'        } ,
    -- Method                = {'ƒ'  , 'TSMethod'      } ,
    Method                = {'M'  , 'TSMethod'      } ,
    Function              = {'ƒ'  , 'TSFunction'    } ,
    Constructor           = {''  , 'TSConstructor' } ,
    Field                 = {'⌘'  , 'TSField'       } ,
    Variable              = {''  , 'TSVariable'    } ,
    Class                 = {''  , 'TSConstructor' } ,
    Interface             = {''  , 'TSAnnotation'  } ,
    Module                = {''  , 'TSConstant'    } ,
    Property              = {''  , 'TSProperty'    } ,
    Unit                  = {''  , 'TSTag'         } ,
    Value                 = {''  , 'TSValue'       } ,
    Enum                  = {'了' , 'TSMethod'      } ,
    Keyword               = {''  , 'TSKeyword'     } ,
    Snippet               = {'﬌'  , 'TSLabel'       } ,
    Color                 = {''  , 'TSBoolean'     } ,
    File                  = {''  , 'TSSymbol'      } ,
    Reference             = {''  , 'TSReference'   } ,
    Folder                = {''  , 'Directory'     } ,
    EnumMember            = {''  , 'TSPunctSpecial'} ,
    Constant              = {''  , 'TSConstant'    } ,
    Struct                = {''  , 'TSStruct'      } ,
    Event                 = {''  , 'TSEvent'       } ,
    Operator              = {''  , 'TSOperator'    } ,
    TypeParameter         = {''  , 'TSType'        } ,
}
cmp.setup({
    documentation = false,
    formatting={
        fields = { 'kind', 'abbr', 'menu' },
        format = function(_, vim_item)
            vim_item.kind_highlight = lsp_kinds[vim_item.kind][2]
            vim_item.kind = lsp_kinds[vim_item.kind][1]
            return vim_item
        end,
    },
    snippet = {
        -- REQUIRED - you must specify a snippet engine
        expand = function(args)
        -- vim.fn["vsnip#anonymous"](args.body) -- For `vsnip` users.
           require('luasnip').lsp_expand(args.body) -- For `luasnip` users.
        -- vim.fn["UltiSnips#Anon"](args.body) -- For `ultisnips` users.
        -- require'snippy'.expand_snippet(args.body) -- For `snippy` users.
        end,
    },
    mapping = {
        ['<C-n>'] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Insert }),
        ['<C-p>'] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Insert }),
        ['<Tab>'] = function(fallback)
          if not cmp.select_next_item() then
            if vim.bo.buftype ~= 'prompt' and has_words_before() then
              cmp.complete()
            else
              fallback()
            end
          end
        end,

        ['<S-Tab>'] = function(fallback)
          if not cmp.select_prev_item() then
            if vim.bo.buftype ~= 'prompt' and has_words_before() then
              cmp.complete()
            else
              fallback()
            end
          end
        end,
    },
    sources = cmp.config.sources({
        { name = "nvim_lsp" },
        { name = "path" },
        -- { name = 'vsnip' }, -- For vsnip users.
        -- { name = 'luasnip' }, -- For luasnip users.
        -- { name = 'ultisnips' }, -- For ultisnips users.
        -- { name = 'snippy' }, -- For snippy users.
    }, {
        { name = 'buffer' },
    }),
    completion = { keyword_length = 2, },
    view = {
        -- etries = "native",
    },
    -- sorting = {
        -- comparators = {
            -- cmp.config.compare.offset,
            -- cmp.config.compare.exact,
            -- cmp.config.compare.score,
            -- cmp.config.compare.order,
            -- cmp.config.compare.recently_used,
            -- cmp.config.compare.kind,
            -- cmp.config.compare.sort_text,
            -- cmp.config.compare.length,
        -- }

      -- function(...)
        -- if vim.api.nvim_get_mode().mode:sub(1, 1) ~= 'c' then
          -- return cmp_buffer:compare_locality(...)
        -- end
      -- end,

    -- }
})

