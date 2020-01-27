class DependenciesFanoutJob < ApplicationJob

  queue_as :dependencies
  @queue = :dependencies

  def perform
    Project.all.pluck(:id).each do |project_id|
      DependenciesFetcherJob.perform_later(project_id: project_id)
    end
  end

end
