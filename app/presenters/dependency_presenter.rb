class DependencyPresenter

  attr_reader :name, :language, :license, :projects, :url, :weight

  def initialize(dependency)
    @name = dependency.name
    @projects = dependency.projects
    @language = dependency.language
    @license = dependency.license&.name
    @weight = @projects.size
    @url = dependency.source_repo_url
  end

end
