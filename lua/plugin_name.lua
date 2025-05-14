

---@class Config
local config = {
  prefixes = { "TODO", "NOTE", "FIXME", "HACK", "WARN" },
  keymap = "<leader>tp",
  telescope = {
    layout_config = {
      width = 0.5,
      height = 0.4,
    },
  },
}

---@class MyModule
local M = {}

---@type Config
M.config = config

---@param args Config?
-- you can define your setup function here. Usually configurations can be merged, accepting outside params and
-- you can also put some validation here for those.
M.setup = function(args)
  M.config = vim.tbl_deep_extend("force", M.config, args or {})
  M.setup_commands()
end

function M.setup_commands()
  vim.api.nvim_create_user_command("TelescopePrefix", function()
    M.pick_prefix()
  end, { desc = "Pick a prefix to insert at line start" })

  if M.config.keymap then
    vim.keymap.set("n", M.config.keymap, M.pick_prefix, { desc = "Insert prefix at line start" })
  end
end

M.pick_prefix = function()
  -- 确保 Telescope 已加载
  local ok, _ = pcall(require, "telescope")
  if not ok then
    vim.notify("Telescope not found!", vim.log.levels.ERROR)
    return
  end

  -- 使用正确的 Telescope API
  local actions = require("telescope.actions")
  local action_state = require("telescope.actions.state")
  local pickers = require("telescope.pickers")
  local finders = require("telescope.finders")
  local conf = require("telescope.config").values

  pickers
    .new(M.config.telescope or {}, {
      prompt_title = "Select Prefix",
      finder = finders.new_table({
        results = M.config.prefixes,
      }),
      sorter = conf.generic_sorter(M.config.telescope),
      attach_mappings = function(prompt_bufnr, _)
        actions.select_default:replace(function()
          local selection = action_state.get_selected_entry()
          actions.close(prompt_bufnr)

          if selection and selection[1] then
            local line = vim.api.nvim_get_current_line()
            -- 获取行首的空格（缩进）
            local indent = line:match("^(%s*)")
            -- 获取去除缩进后的内容
            local content = line:sub(#indent + 1)
            -- 构建新行：缩进 + 前缀 + ": " + 内容
            local new_line = indent .. selection[1] .. ": " .. content
            vim.api.nvim_set_current_line(new_line)
          end
        end)
        return true
      end,
    })
    :find()
end

return M
