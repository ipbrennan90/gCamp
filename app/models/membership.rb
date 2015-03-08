class Membership < ActiveRecord::Base
  belongs_to :user
  belongs_to :project
  #enum role: {member: 2, owner: 1}

end
