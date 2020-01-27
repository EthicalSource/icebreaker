class DependenciesFetcherJob

  @queue = :dependencies

  def self.perform(params={})
    project = Project.find(params['project_id'])
    DependencyFetcher.get_dependencies(project, project.organization)
  end

end
