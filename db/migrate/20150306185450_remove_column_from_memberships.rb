class RemoveColumnFromMemberships < ActiveRecord::Migration
  def change
    remove_column :memberships, :role, :string
  end
end
