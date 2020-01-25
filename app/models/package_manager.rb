class PackageManager < ApplicationRecord
  belongs_to :language
  has_many :dependencies
end
