class CreateOrganizations < ActiveRecord::Migration[6.0]
  def change
    create_table :organizations, id: :uuid do |t|
      t.string :name
      t.string :url
      t.string :github_url

      t.timestamps
    end
  end
end
