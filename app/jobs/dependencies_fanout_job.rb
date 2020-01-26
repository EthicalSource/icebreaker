class DependenciesFanoutJob < ApplicationJob

  queue_as :dependencies

  def perform
    Project.all.each { |project| ProjectFetcherJob.perform_later(project.id) }
  end

end
