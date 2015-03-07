class RemoveColumnFromProjects < ActiveRecord::Migration
  def change
    remove_column :projects, :role, :integer
  end
end
