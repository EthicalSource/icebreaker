class ProjectsController < ApplicationController

  def index
    @dependencies = Dependency.all.includes(:projects).map{ |d| DependencyPresenter.new(d) }
  end

end
