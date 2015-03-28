class ChangenameUsers < ActiveRecord::Migration
  def change
    rename_column :users, :tracker_token, :pivotal_tracker_token
  end
end
