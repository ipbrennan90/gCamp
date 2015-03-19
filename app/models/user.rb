class User < ActiveRecord::Base
  validates :first_name, :last_name, :email, :password, :password_confirmation, presence: true
  validates :email, uniqueness: true
  has_many :memberships, dependent: :destroy
  has_many :comments
  has_many :projects, through: :memberships
  has_many :tasks, through: :comments
  has_secure_password


  def full_name
    "#{first_name} #{last_name}"
  end

end
