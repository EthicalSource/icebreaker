class CreatePackageManagers < ActiveRecord::Migration[6.0]
  def change
    create_table :package_managers, id: :uuid do |t|
      t.string :name
      t.references :language, type: :uuid, foreign_key: true
      t.timestamps
    end
  end
end
