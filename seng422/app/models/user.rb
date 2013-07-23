class User < ActiveRecord::Base
  validates :username, :uniqueness => true

  has_many :checklists

  # yoink: http://www.tonyamoyal.com/2010/07/28/rails-authentication-with-devise-and-cancan-customizing-devise-controllers/
  has_and_belongs_to_many :roles

  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :username, :password, :password_confirmation, :remember_me, :role_ids
  # attr_accessible :title, :body
  
  def email_required?
	  false
  end

  def email_changed?
	  false
  end

  def role?(role)
	  return !!self.roles.find_by_name(role.to_s)
  end

  def self.with_role(role)
	  return joins(:roles).where(roles: {name: role.to_s})
  end
end
