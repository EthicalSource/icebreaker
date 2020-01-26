class PackageManager < ApplicationRecord
  MANAGERS = {
    'RUBYGEMS' => 'ruby',
    'NPM' => 'javascript',
  }
  belongs_to :language
  has_many :dependencies
  before_validation :set_language, on: :create

  private
  def set_language
    self.language = Language.find_or_create_by(name: MANAGERS[self.name])
  end
end
