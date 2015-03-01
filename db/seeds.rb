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
YelpPin.delete_all
Rating.delete_all
Trip.delete_all
Stop.delete_all

# Cities

barcelona = City.new
barcelona.city = "barcelona"
barcelona.state = nil
barcelona.country = "spain"
barcelona.latitude = "41.39479"
barcelona.longitude = "2.1487679"
barcelona.zoom = "12"
barcelona.save()

new_york_city = City.new
new_york_city.city = "new york city"
new_york_city.state = "new york"
new_york_city.country = "united states"
new_york_city.latitude = "40.7033127"
new_york_city.longitude = "-73.979681"
new_york_city.zoom = "10"
new_york_city.save()

chicago = City.new
chicago.city = "chicago"
chicago.state = "illinois"
chicago.country = "united states"
chicago.latitude = "41.8337329"
chicago.longitude = "-87.7321555"
chicago.zoom = "11"
chicago.save()

# Users

caitlin = User.new
caitlin.fb_id = "10205425176300298"
caitlin.first = "Caitlin"
caitlin.last = "McDonald"
caitlin.profile_picture = "http://graph.facebook.com/caitlinamcdonald/picture"
caitlin.save()

erin = User.new
erin.fb_id = "10205425176300299"
erin.first = "Erin"
erin.last = "Hoffman"
erin.profile_picture = "http://graph.facebook.com/EronHistorion/picture"
erin.save()

lauren = User.new
lauren.fb_id = "10205425176300300"
lauren.first = "Lauren"
lauren.last = "Bretz"
lauren.profile_picture = "http://graph.facebook.com/lauren.bretz.3/picture"
lauren.save()

bogdan = User.new
bogdan.fb_id = "10205425176300301"
bogdan.first = "Bogdan"
bogdan.last = "Pozderca"
bogdan.profile_picture = "http://graph.facebook.com/bogdan.pozderca/picture"
bogdan.save()

# Pins

central_park = Pin.new
central_park.title = "central park"
central_park.latitude = "40.782865"
central_park.longitude = "-73.965355"
central_park.city_id = new_york_city.id
central_park.save()

statue_of_liberty = Pin.new
statue_of_liberty.title = "statue of liberty national monument"
statue_of_liberty.latitude = "40.689249"
statue_of_liberty.longitude = "-74.0445"
statue_of_liberty.city_id = new_york_city.id
statue_of_liberty.save()

cheese_bar = Pin.new
cheese_bar.title = "murray's cheese bar"
cheese_bar.latitude = "40.731249"
cheese_bar.longitude = "-74.00322"
cheese_bar.city_id = new_york_city.id
cheese_bar.save()

# Trips

bogdan_trip = Trip.new
bogdan_trip.city_id = new_york_city.id
bogdan_trip.user_id = bogdan.id
bogdan_trip.completed = 1
bogdan_trip.save()

erin_trip = Trip.new
erin_trip.city_id = new_york_city.id
erin_trip.user_id = erin.id
erin_trip.completed = 1
erin_trip.save()

lauren_trip = Trip.new
lauren_trip.city_id = new_york_city.id
lauren_trip.user_id = lauren.id
lauren_trip.completed = 1
lauren_trip.save()

# Ratings

b_central_park = Rating.new
b_central_park.pin_id = central_park.id
b_central_park.user_id = bogdan.id
b_central_park.score = 4
b_central_park.trip_id = bogdan_trip.id
b_central_park.save()

e_statue_of_liberty = Rating.new
e_statue_of_liberty.pin_id = statue_of_liberty.id
e_statue_of_liberty.user_id = erin.id
e_statue_of_liberty.score = 2
e_statue_of_liberty.trip_id = erin_trip.id
e_statue_of_liberty.save()

l_statue_of_liberty = Rating.new
l_statue_of_liberty.pin_id = statue_of_liberty.id
l_statue_of_liberty.user_id = lauren.id
l_statue_of_liberty.score = 3
l_statue_of_liberty.trip_id = lauren_trip.id
l_statue_of_liberty.save()

b_statue_of_liberty = Rating.new
b_statue_of_liberty.pin_id = statue_of_liberty.id
b_statue_of_liberty.user_id = bogdan.id
b_statue_of_liberty.score = 5
b_statue_of_liberty.trip_id = bogdan_trip.id
b_statue_of_liberty.save()

e_cheese_bar = Rating.new
e_cheese_bar.pin_id = cheese_bar.id
e_cheese_bar.user_id = erin.id
e_cheese_bar.score = 5
e_statue_of_liberty.trip_id = erin_trip.id
e_cheese_bar.save()

l_cheese_bar = Rating.new
l_cheese_bar.pin_id = cheese_bar.id
l_cheese_bar.user_id = lauren.id
l_cheese_bar.score = 5
l_statue_of_liberty.trip_id = lauren_trip.id
l_cheese_bar.save()