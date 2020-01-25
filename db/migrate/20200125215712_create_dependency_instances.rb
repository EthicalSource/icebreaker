class CreateDependencyInstances < ActiveRecord::Migration[6.0]
  def change
    create_table :dependency_instances, id: :uuid do |t|
      t.string :version
      t.references :dependency, type: :uuid, foreign_key: true
      t.references :project, type: :uuid, foreign_key: true
      t.timestamps
    end
  end
end
