class DropRepoNameFromProject < ActiveRecord::Migration[6.0]
  def change
    remove_column :projects, :repo_name
  end
end
