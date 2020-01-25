class DependencyInstance < ApplicationRecord
  belongs_to :dependency
  belongs_to :project
end
