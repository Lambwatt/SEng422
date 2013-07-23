# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

# Roles
Role.delete_all
user_role = Role.find_or_create_by_name("surveyor")
admin_role = Role.find_or_create_by_name("admin")
manager_role = Role.find_or_create_by_name("manager")

# dummy users
user = User.find_by_username("surveyor")
user.destroy if user
user = User.new
user.username = "surveyor"
user.password = "password"
user.password_confirmation = "password"
user.roles = [user_role]
user.save!

user = User.find_by_username("admin")
user.destroy if user
user = User.new
user.username = "admin"
user.password = "password"
user.password_confirmation = "password"
user.roles = [admin_role]
user.save!

user = User.find_by_username("manager")
user.destroy if user
user = User.new
user.username = "manager"
user.password = "password"
user.password_confirmation = "password"
user.roles = [manager_role]
user.save!
