class HomeController < ApplicationController

  def show
    @repo_count = Project.count
    @languages = Language.all.order("name ASC")
  end

  helper_method def dependencies
    @dependencies ||= Dependency.all
      .with_projects
      .ordered_by_name
      .reject{ |dependency| dependency.language.blank? }
      .map { |dependency| DependencyPresenter.new(dependency) }
      .sort_by(&:weight)
  end

end
