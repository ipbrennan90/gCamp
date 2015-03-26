class ChangeColumnUsers < ActiveRecord::Migration
  def change
    remove_column :users, :permission
  end
end
