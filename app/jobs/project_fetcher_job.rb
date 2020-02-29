class ProjectFetcherJob < ApplicationJob

  def perform
    Organization.all.each do |organization|
      OrgProjectFetcher.get_projects(organization)
    end
  end
end
