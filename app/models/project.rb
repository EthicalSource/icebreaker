class Project < ApplicationRecord
  belongs_to :organization
  has_many :dependency_instances
  has_many :dependencies, through: :dependency_instances
end
