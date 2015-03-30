class User < ActiveRecord::Base
  attr_accessor :skip_password_validation
  validates :first_name, :last_name, :email,presence: true
  unless :skip_password_validation
    validates :password, :password_confirmation
  end 


  validates :email, uniqueness: true
  has_many :memberships, dependent: :destroy
  has_many :comments
  has_many :projects, through: :memberships
  has_many :tasks, through: :comments
  has_secure_password


  def full_name
    "#{first_name} #{last_name}"
  end

  before_save :default_values
  def default_values
    self.permission ||= 'false'
  end




end
