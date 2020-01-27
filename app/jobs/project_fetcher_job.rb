class ProjectFetcherJob

  @queue = :projects

  def self.perform
    new.perform
  end

  def perform
    Organization.all.each do |organization|
      OrgProjectFetcher.get_projects(organization)
    end
  end

end
