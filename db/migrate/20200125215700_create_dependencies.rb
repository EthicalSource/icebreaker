class CreateDependencies < ActiveRecord::Migration[6.0]
  def change
    create_table :dependencies, id: :uuid do |t|
      t.string :name, null: false
      t.string :language
      t.string :source_repo_url
      t.references :package_manager, type: :uuid, foreign_key: true
      t.timestamps
    end
  end
end
