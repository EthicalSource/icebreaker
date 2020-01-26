DependencyInstance.destroy_all
PackageManager.destroy_all
Language.destroy_all
Project.destroy_all
Organization.destroy_all
Dependency.destroy_all

language = Language.create(name: "Ruby")
package_manager = PackageManager.create(name: "RubyGems", language: language)
org = Organization.create(name: "Palantir")

%w{stormtrooper sith imperial bountyhunter}.each do |p|
  Project.create(
    name: p,
    org_name: "palantir",
    repo_name: p,
    repo_url: "https://github.com/palantir/#{p}",
    organization: org
  )
end

%w{rebel senate jedi ewoks}.each do |p|
  Dependency.create(
    name: p,
    language: "Ruby",
    source_repo_url: "https://github.com/ContributorCovenant/#{p}",
    package_manager: package_manager
  )
end

Project.all.each do |project|
  Dependency.all.each_with_index do |dependency, i|
    next unless [true, false].sample
    DependencyInstance.create(project: project, dependency: dependency, version: "0.7.#{i}")
  end
end
