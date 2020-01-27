class DependenciesFanoutJob < ApplicationJob

  queue_as :dependencies
  @queue = :dependencies

  def perform
    Project.all.each { |project| DependenciesFetcherJob.perform(project.id) }
  end

end
