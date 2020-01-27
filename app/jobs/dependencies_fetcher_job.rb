class DependenciesFetcherJob

  @queue = :dependencies

  def self.perform(project_id:)
    new.perform(project_id: project_id)
  end

  def perform(project_id:)
    project = Project.find(project_id)
    DependencyFetcher.get_dependencies(project, project.organization)
  end

end
