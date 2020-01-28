class Language < ApplicationRecord
  validates :name, uniqueness: true, presence: true
end
