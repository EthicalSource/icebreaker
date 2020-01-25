class CreateProjects < ActiveRecord::Migration[6.0]
  def change
    create_table :projects, id: :uuid do |t|
      t.string :name
      t.string :org_name
      t.string :repo_name
      t.string :repo_url
      t.references :organization, type: :uuid, foreign_key: true
      t.timestamps
    end
  end
end
