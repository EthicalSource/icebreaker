namespace :projects do

  desc 'Populate projects from orgs'
  task :init => :environment do
    Organization.all.each do |organization|
      puts "Fetching projects for #{organization.name}"
      OrgProjectFetcher.get_projects(organization)
    end
    projects = Project.all
    total = projects.count
    puts "Fetching dependencies"
    projects.each_with_index do |project, i|
      print "."
      DependencyFetcher.get_dependencies(project)
    end
  end

end
