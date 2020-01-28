class DependencyPresenter

  attr_reader :name, :language, :license, :projects, :url, :weight

  def initialize(dependency)
    @name = dependency.name
    @projects = dependency.projects
    @language = dependency.language
    @license = license_name(dependency.license&.name)
    @weight = @projects.size
    @url = dependency.source_repo_url
  end

  def license_name(name)
    return if name.nil? || name.empty?
    return if name == "Unknown"
    "#{name} license"
  end

end
