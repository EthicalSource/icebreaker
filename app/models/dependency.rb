class Dependency < ApplicationRecord
  belongs_to :package_manager
  has_many :dependency_instances
  has_many :projects, through: :dependency_instances
end
