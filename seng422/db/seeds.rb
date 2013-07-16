# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

# dummy user
unless User.find_by_username("surveyor")
	user = User.new
	user.username = "surveyor"
	user.password = "password"
	user.password_confirmation = "password"
	user.save!
end
