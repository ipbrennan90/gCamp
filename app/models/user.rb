class User < ActiveRecord::Base
  validates :first_name, :last_name, :email, :password, :password_confirmation, presence: true
  validates :email, uniqueness: true
  has_secure_password
end
