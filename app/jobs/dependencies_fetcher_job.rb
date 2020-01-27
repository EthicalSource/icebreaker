class DependenciesFetcherJob < ApplicationJob

  queue_as :dependencies
  @queue = :dependencies

  def perform(project_id: project_id)
    project = Project.find(project_id)
    DependencyFetcher.get_dependencies(project, project.organization)
  end

end
