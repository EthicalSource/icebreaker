class HomeController < ApplicationController
  def show

  end

  helper_method def dependencies
    @dependencies ||= Dependency.all
      .with_projects
      .ordered_by_name
      .map { |dependency| to_presenter(dependency) }
      .sort_by(&:weight)
  end

  private def to_presenter(dependency)
    DependencyPresenter.new(dependency)
  end
end