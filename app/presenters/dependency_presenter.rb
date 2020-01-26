class DependencyPresenter

  attr_reader :name, :projects, :weight

  def initialize(dependency)
    @name = dependency.name
    @projects = dependency.projects
    @weight = @projects.size
  end

end
