class AddColumnsToComments < ActiveRecord::Migration
  def change
    add_column :comments, :project_id, :integer
    add_column :comments, :user_id, :integer
  end
end
