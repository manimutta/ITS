class Role < ActiveRecord::Base

  validates_uniqueness_of :name
  validates_presence_of :name
  has_many :role_users
  has_many :users, through: :role_users
end
