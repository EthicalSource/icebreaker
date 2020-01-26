class DependenciesFanoutJob < ApplicationJob

  queue_as :dependencies

  def perform
    Project.all.each { |project| ProjectFetcherJob.perform(project.id)) }
  end

end
