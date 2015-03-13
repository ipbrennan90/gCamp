class Comment < ActiveRecord::Base
  belongs_to :user
  belongs_to :task
  belongs_to :project
end
