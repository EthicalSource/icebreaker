class CreateLicenses < ActiveRecord::Migration[6.0]
  def change
    create_table :licenses, id: :uuid do |t|
      t.string :name
    end
  end
  add_column :dependencies, :license_id, :uuid
end
