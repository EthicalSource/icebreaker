class DependenciesFanoutJob < ApplicationJob

  queue_as :dependencies
  @queue = :dependencies

  def perform
    Project.all.each { |project| DependenciesFetcherJob.perform_later(project.id) }
  end

end
