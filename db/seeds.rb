# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

City.delete_all
User.delete_all

barcelona = City.new
barcelona.city = "Barcelona"
barcelona.state = nil
barcelona.country = "Spain"
barcelona.save()

new_york_city = City.new
new_york_city.city = "New York City"
new_york_city.state = "New York"
new_york_city.country = "United State"
new_york_city.save()

chicago = City.new
chicago.city = "Chicago"
chicago.state = "Illinois"
chicago.country = "United State"
chicago.save()


caitlin = User.new
caitlin.fb_id = "10205425176300298"
caitlin.first = "Caitlin"
caitlin.last = "McDonald"
caitlin.save()