# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

user = User.new
user.email = 'a@a.a'
user.username = 'YoHoJo'
user.password = 'secret'
user.password_confirmation = 'secret'
user.skip_confirmation_notification!
user.skip_confirmation!
user.save!