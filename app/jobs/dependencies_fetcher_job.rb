class DependenciesFetcherJob < ApplicationJob

  queue_as :dependencies

  def self.perform(project_id)
    project = Project.find(project_id)
    DependencyFetcher.get_dependencies(project, project.organization)
  end

end
