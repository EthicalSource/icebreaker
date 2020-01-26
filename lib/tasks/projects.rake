namespace :projects do

  desc 'Populate projects from orgs'
  task :init => :environment do
    Organization.all.each do |organization|
      puts "Fetching projects for #{organization.name}"
      OrgProjectFetcher.get_projects(organization)
      puts "Fetching dependencies"
      organization.projects.each do |project|
        print "."
        DependencyFetcher.get_dependencies(project, organization)
      end
    end
  end

end
