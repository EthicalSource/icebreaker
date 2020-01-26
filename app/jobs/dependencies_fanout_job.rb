class DependenciesFanoutJob < ApplicationJob

  @queue = :dependencies

  def perform
    Project.all.each { |project| Resque.enqueue(ProjectFetcherJob, project.id) }
  end

end
