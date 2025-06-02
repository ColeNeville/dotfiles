local is_inside_work_tree = {}

return {
  find_project_files = function()
    local cwd = vim.fn.getcwd()

    if is_inside_work_tree[cwd] == nil then
      vim.fn.system("git rev-parse --is_inside_work_tree")
      is_inside_work_tree[cwd] = vim.v.shell_error == 0
    end

    if is_inside_work_tree[cwd] then
      require("telescope.builtin").git_files({})
    else
      require("telescope.builtin").find_files({})
    end
  end,
}
