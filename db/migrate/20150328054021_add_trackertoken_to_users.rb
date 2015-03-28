class AddTrackertokenToUsers < ActiveRecord::Migration
  def change
    add_column :users, :tracker_token, :integer
  end
end
