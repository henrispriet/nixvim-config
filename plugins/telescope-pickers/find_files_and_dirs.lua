-- custom picker that recursively list all files and dirs under cwd and includes cwd as "./"
function(opts)
  local pickers = require("telescope.pickers")
  local conf = require("telescope.config").values
  local make_entry = require("telescope.make_entry")
  local actions = require("telescope.actions")
  local action_state = require("telescope.actions.state")

  opts = opts or {}

  opts.entry_maker = opts.entry_maker or make_entry.gen_from_file(opts)
  -- leave file paths as is (ensures trailing '/' for dirs)
  opts.path_display = function(_, path)
    return path
  end

  -- make sure ./ is included
  opts.results = opts.entry_maker("./")
  local finder = require("telescope.finders.async_oneshot_finder")({
    fn_command = function()
      return { command = "fd" }
    end,
    entry_maker = opts.entry_maker,
    results = { opts.entry_maker("./") },
  })

  -- open directories in oil floating window
  local attach_mappings = function(prompt_bufnr, map)
    actions.select_default:replace(function()
      local selection = action_state.get_selected_entry()
      if selection == nil then
	return
      end

      actions.close(prompt_bufnr)
      local path = "./"..selection[1]

      if path:match("/$") then
	vim.cmd([[Oil --float ]]..path)
      else
	vim.cmd([[edit ]]..path)
      end
    end)
    return true
  end

  pickers.new(opts, {
    prompt_title = "Find Files",
    finder = finder,
    sorter = conf.file_sorter(opts),
    previewer = conf.file_previewer(opts),
    attach_mappings = attach_mappings,
  }):find()
end
