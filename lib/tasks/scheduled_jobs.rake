namespace :scheduled_jobs do
  # Safe to run hourly  or daily, pulls in all the projects for the organizations we
  # are monitoring and updates their dependency graph
  desc "Rebuilds graph in the background"
  task update_projects: :environment do
    ProjectFetcherJob.perform_later
  end
end