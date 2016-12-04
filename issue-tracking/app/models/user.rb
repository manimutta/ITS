class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :role_users
  has_many :roles, through: :role_users
  has_many :tickets
  has_many :comments
  after_create :set_roles
  # validates_presence_of :fullname


  def has_role(role)
    self.roles.pluck(:name).include? role
  end

  def set_roles
    RoleUser.create(user_id: self.id, role_id: Role.where(name: "Customer").first.id)
  end

  def getname
    if self.fullname.blank?
      return "User"
    else
      return self.fullname
    end
  end
end
