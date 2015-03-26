class Membership < ActiveRecord::Base
  belongs_to :user
  belongs_to :project
  validates :user, presence: true
  validates :user, uniqueness: { scope: :project_id, message: "has already been added to this project"}


  def membership_description(membership)
    if membership.role==1
      "Owner"
    else
      "Member"
    end
  end


end
