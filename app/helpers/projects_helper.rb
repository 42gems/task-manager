module ProjectsHelper
  def truncated_description(project)
    unless project.description.nil? or project.description.empty?
      project.description.truncate 40
    else
      "Add description"
    end
  end
end
