class ProjectsController < ApplicationController

  def index
    @dependencies = Dependency.all.includes(:projects).order("dependencies.name ASC").map{ |d| DependencyPresenter.new(d) }
  end

end
