class ChangeTokenColumn < ActiveRecord::Migration
  def change
    change_column :users, :pivotal_tracker_token, :string
  end
end
