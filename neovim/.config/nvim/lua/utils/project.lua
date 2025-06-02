local telescopeActions = require("telescope.actions")

local project = require("project_nvim.project")

local function change_working_directory(prompt_bufnr, prompt)
  local state = require("telescope.actions.state")

  local selected_entry = state.get_selected_entry(prompt_bufnr)

  if selected_entry == nil then
    telescopeActions.close(prompt_bufnr)
    return
  end

  local project_path = selected_entry.value

  if prompt == true then
    telescopeActions._close(prompt_bufnr, true)
  else
    telescopeActions.close(prompt_bufnr)
  end

  local cd_successful = project.set_pwd(project_path, "telescope")
  return project_path, cd_successful
end


return {
  find_file_in_selection = function(prompt_bufnr)
    local project_path, cd_successful = change_working_directory(prompt_bufnr, true)

    if cd_successful then
      require("utils.search").find_project_files()
    end
  end
}
