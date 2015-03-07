class AddRolesToProjects < ActiveRecord::Migration
  def change
    add_column :projects, :role, :integer
  end
end
