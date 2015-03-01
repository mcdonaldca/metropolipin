# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

# Clear existing data

City.delete_all
User.delete_all
Pin.delete_all
Rating.delete_all

# Cities

barcelona = City.new
barcelona.city = "barcelona"
barcelona.state = nil
barcelona.country = "spain"
barcelona.save()

new_york_city = City.new
new_york_city.city = "new york city"
new_york_city.state = "new york"
new_york_city.country = "united states"
new_york_city.save()

chicago = City.new
chicago.city = "chicago"
chicago.state = "illinois"
chicago.country = "united states"
chicago.save()

# Users

caitlin = User.new
caitlin.fb_id = "10205425176300298"
caitlin.first = "Caitlin"
caitlin.last = "McDonald"
caitlin.save()

erin = User.new
erin.fb_id = "10205425176300299"
erin.first = "Erin"
erin.last = "Hoffman"
erin.save()

lauren = User.new
lauren.fb_id = "10205425176300300"
lauren.first = "Lauren"
lauren.last = "Bretz"
lauren.save()

bogdan = User.new
bogdan.fb_id = "10205425176300301"
bogdan.first = "Bogdan"
bogdan.last = "Pozderca"
bogdan.save()

# Pins

central_park = Pin.new
central_park.title = "Central Park"
central_park.latitude = "40.782865"
central_park.longitude = "-73.965355"
central_park.city_id = new_york_city.id
central_park.save()

statue_of_liberty = Pin.new
statue_of_liberty.title = "Statue of Liberty National Monument"
statue_of_liberty.latitude = "40.689249"
statue_of_liberty.longitude = "-74.0445"
statue_of_liberty.city_id = new_york_city.id
statue_of_liberty.save()

cheese_bar = Pin.new
cheese_bar.title = "Murray's Cheese Bar"
cheese_bar.latitude = "40.731249"
cheese_bar.longitude = "-74.00322"
cheese_bar.city_id = new_york_city.id
cheese_bar.save()

# Ratings

b_central_park = Rating.new
b_central_park.pin_id = central_park.id
b_central_park.user_id = bogdan.id
b_central_park.score = 4
b_central_park.save()

e_statue_of_liberty = Rating.new
e_statue_of_liberty.pin_id = statue_of_liberty.id
e_statue_of_liberty.user_id = erin.id
e_statue_of_liberty.score = 2
e_statue_of_liberty.save()

l_statue_of_liberty = Rating.new
l_statue_of_liberty.pin_id = statue_of_liberty.id
l_statue_of_liberty.user_id = lauren.id
l_statue_of_liberty.score = 3
l_statue_of_liberty.save()

b_statue_of_liberty = Rating.new
b_statue_of_liberty.pin_id = statue_of_liberty.id
b_statue_of_liberty.user_id = bogdan.id
b_statue_of_liberty.score = 5
b_statue_of_liberty.save()

e_cheese_bar = Rating.new
e_cheese_bar.pin_id = cheese_bar.id
e_cheese_bar.user_id = erin.id
e_cheese_bar.score = 5
e_cheese_bar.save()

l_cheese_bar = Rating.new
l_cheese_bar.pin_id = cheese_bar.id
l_cheese_bar.user_id = lauren.id
l_cheese_bar.score = 5
l_cheese_bar.save()