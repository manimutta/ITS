# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

roles = ["Admin", "Customer", "SupportHead"]
roles.each do |x|
  Role.create(name: x)
end
user = User.create(fullname: "mani", email: "admin@gmail.com", password: "123456789", password_confirmation: "123456789")
RoleUser.create(user_id: user.id, role_id: Role.where(name: "Admin").first.id)