
-- lua/config/commands.lua
vim.api.nvim_create_user_command('BufOnly', '%bd | e# | bd#', { bang = true })

local M = {}
-- Otras funciones y comandos existentes
-- Buffer history
M.buffer_history = {
  history = {},
  index = 0,

  should_record = function(bufnr)
    local bt = vim.bo[bufnr].buftype
    return bt == "" or bt == "acwrite"
  end,

  record_buffer = function()
    local buf = vim.api.nvim_get_current_buf()
    if not M.buffer_history.should_record(buf) then return end

    if M.buffer_history.index == 0 or M.buffer_history.history[M.buffer_history.index] ~= buf then
      while #M.buffer_history.history > M.buffer_history.index do
        table.remove(M.buffer_history.history)
      end
      table.insert(M.buffer_history.history, buf)
      M.buffer_history.index = #M.buffer_history.history
    end
  end,

  goto_prev_buffer = function()
    if M.buffer_history.index > 1 then
      M.buffer_history.index = M.buffer_history.index - 1
      vim.api.nvim_set_current_buf(M.buffer_history.history[M.buffer_history.index])
    end
  end,

  goto_next_buffer = function()
    if M.buffer_history.index < #M.buffer_history.history then
      M.buffer_history.index = M.buffer_history.index + 1
      vim.api.nvim_set_current_buf(M.buffer_history.history[M.buffer_history.index])
    end
 end,

  cleanup_closed_buffers = function()
    local i = 1
    while i <= #M.buffer_history.history do
      if not vim.api.nvim_buf_is_valid(M.buffer_history.history[i]) then
        table.remove(M.buffer_history.history, i)
        if M.buffer_history.index >= i then
          M.buffer_history.index = math.max(1, M.buffer_history.index - 1)
        end
      else
        i = i + 1
      end
    end
  end,

  show_history = function()
    local buffers = {}
    local current_index = M.buffer_history.index

    for i, bufnr in ipairs(M.buffer_history.history) do
      if vim.api.nvim_buf_is_valid(bufnr) then
        local name = vim.api.nvim_buf_get_name(bufnr)
        name = name ~= "" and vim.fn.fnamemodify(name, ":~:.") or "[Sin nombre]"

        local prefix = i == current_index and "* " or "  "
        table.insert(buffers, {
          value = i,
          display = string.format("%s%d: %s", prefix, i, name)
        })
      end
    end

    if #buffers == 0 then
      vim.notify("No hay historial de buffers disponible", vim.log.levels.INFO)
      return
    end

    require('fzf-lua').fzf_exec(
      vim.tbl_map(function(item) return item.display end, buffers),
      {
        prompt = "Buffer History > ",
        actions = {
          ["default"] = function(selected)
            local index_str = selected[1]:match("^%s*(%d+):")
            if index_str then
              local index = tonumber(index_str)
              M.buffer_history.index = index
              vim.api.nvim_set_current_buf(M.buffer_history.history[index])
            end
          end
        }
      }
    )
  end
}

return M
