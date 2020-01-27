class DependenciesFanoutJob

  @queue = :dependencies

  def self.perform
    new.perform
  end

  def perform
    Project.all.pluck(:id).each do |project_id|
      Resque.enqueue(DependenciesFetcherJob, project_id: project_id)
    end
  end

end
