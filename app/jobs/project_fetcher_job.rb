class ProjectFetcherJob < ApplicationJob

  queue_as :projects
  @queue = :projects

  def perform
    Organization.all.each do |organization|
      OrgProjectFetcher.get_projects(organization)
    end
  end

end
