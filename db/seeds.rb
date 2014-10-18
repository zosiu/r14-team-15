# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
User.where(email: 'try.me@coding-romeo.com').first_or_create! do |u|
  u.codeship_api_token = 'some token'
  u.password = u.password_confirmation = '12345678'
end
