class ChangeColumnsForMemberships < ActiveRecord::Migration
  def change
    change_column :memberships, :project_id, :integer, null: false
    change_column :memberships, :user_id, :integer, null: false
    
  end
end
