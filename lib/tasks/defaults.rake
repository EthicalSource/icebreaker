namespace :defaults do

  desc 'Create default orgs, package managers, and languages'
  task :init => :environment do
    ruby = Language.create(name: "Ruby")
    js = Language.create(name: "Javascript")

    PackageManager.create(name: "RubyGems", language: ruby)
    PackageManager.create(name: "NPM", language: js)

    Organization.create(name: "Palantir")
  end

end
