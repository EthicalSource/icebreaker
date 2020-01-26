class ProjectFetcherJob < ApplicationJob

  @queue = :projects

  def self.perform
    Organization.all.each do |organization|
      OrgProjectFetcher.get_projects(organization)
    end
  end

end
