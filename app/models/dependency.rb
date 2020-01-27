class Dependency < ApplicationRecord
  belongs_to :package_manager
  belongs_to :license
  has_many :dependency_instances
  has_many :projects, through: :dependency_instances

  before_validation :update_with_details, on: :create

  def update_with_details
    details = DependencyDetailsFetcher.new(self).fetch
    license_name = details[:license] || "Unknown"
    license = License.find_or_create_by(name: license_name)
    self.source_repo_url = details[:url]
    self.license = license
  end

end
