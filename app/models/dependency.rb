class Dependency < ApplicationRecord
  belongs_to :package_manager
  has_many :dependency_instances
  has_many :projects, through: :dependency_instances

  after_create :set_source_repo_url

  def set_source_repo_url
    update(source_repo_url: DependencyDetailsFetcher.new(self).source_code_url)
  end

end
