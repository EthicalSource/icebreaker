class DependenciesFetcherJob < ApplicationJob

  def perform(project)
    DependencyFetcher.get_dependencies(project, project.organization)
  end

end
