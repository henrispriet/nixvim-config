-- custom picker that allows multi-selecting buffers to delete
function(opts)
  local actions = require("telescope.actions")
  local action_state = require("telescope.actions.state")
  local conf = require("telescope.config").values
  local finders = require("telescope.finders")
  local pickers = require("telescope.pickers")
  local make_entry = require("telescope.make_entry")

  opts = opts or {}

  -- trimmed down from https://github.com/nvim-telescope/telescope.nvim/blob/c392f1b78eaaf870ca584bd698e78076ed301b26/lua/telescope/builtin/__internal.lua#L893
  local bufnrs = vim.tbl_filter(
    function(bufnr)
      return vim.fn.buflisted(bufnr) == 1
    end,
    vim.api.nvim_list_bufs()
  )

  -- sort by lru
  table.sort(bufnrs, function(a, b)
    return vim.fn.getbufinfo(a)[1].lastused < vim.fn.getbufinfo(b)[1].lastused
  end)

  local buffers = {}
  for _, bufnr in ipairs(bufnrs) do
    local flag = bufnr == vim.fn.bufnr "" and "%" or (bufnr == vim.fn.bufnr "#" and "#" or " ")

    local element = {
      bufnr = bufnr,
      flag = flag,
      info = vim.fn.getbufinfo(bufnr)[1],
    }

    table.insert(buffers, element)
  end

  -- idk what opts.bufnr_width does
  local max_bufnr = math.max(unpack(bufnrs))
  opts.bufnr_width = #tostring(max_bufnr)

  local finder = finders.new_table({
    results = buffers,
    entry_maker = make_entry.gen_from_buffer(opts)
  })

  -- adapted from https://github.com/axieax/urlview.nvim/blob/main/lua/urlview/pickers.lua
  local attach_mappings = function(prompt_bufnr, map)
    map({ "i", "n" }, "<C-a>", actions.toggle_all)

    actions.select_default:replace(function()
      local picker = action_state.get_current_picker(prompt_bufnr)
      local multi = picker:get_multi_selection()

      -- TODO: oil.nvim style confirm popup?

      actions.close(prompt_bufnr)
      for _, entry in ipairs(multi) do
	vim.cmd([[bd ]]..entry.bufnr)
      end
    end)

    return true
  end

  pickers.new(opts, {
    prompt_title = "Close Buffers",
    finder = finder,
    sorter = conf.generic_sorter(opts),
    previewer = conf.grep_previewer(opts),
    attach_mappings = attach_mappings,
  }):find()
end
