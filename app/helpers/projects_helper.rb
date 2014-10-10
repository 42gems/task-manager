module ProjectsHelper
  def truncated_description_of(project, length)
    unless project.description.nil? or project.description.empty?
      project.description.truncate length
    else
      "Add description"
    end
  end
end
