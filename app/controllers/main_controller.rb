class MainController < ApplicationController

	before_filter :authenticate, :except => [:index, :login, :blink]

	def index
		
		unless params[:admin].nil?
			user = User.find_by first: "Caitlin"
			session[:user] = user.id
			redirect_to dashboard_url
		end

	end

	def dashboard
		@display = session[:userID]
		@user = User.find session[:user]
	end

	def explore
		if params[:city].nil? or params[:city] == ''
			redirect_to dashboard_url
		else
			session[:search] = params[:city].downcase
		end

		@city = City.find_by city: session[:search]
	end

	def pindex
		if session[:search].nil? or session[:search] == ''
			redirect_to dashboard_url
		end

		@city = City.find_by city: session[:search]

		require 'rubygems' # not necessary with ruby 1.9 but included for completeness
		require 'yelp'
		client = Yelp::Client.new({ consumer_key: "JSTcs5H0D2gItBX9NwtbOg",
                            consumer_secret: "cp4-k3TIst1X8hw5JLrb8vXJpC4",
                            token: "L4TPFk1ShjIXIozv7IM34iCbCUSpjwXV",
                            token_secret: "Pm4yZ4B7QHB1ziMLWVMvGxRQCEo"
                          })
		
		# finding the top 5 arts, food, and tours locations
		arts_response = client.search(session[:search], {category_filter: "arts"}).businesses
		food_response = client.search(session[:search], {category_filter: "food"}).businesses
		tour_response = client.search(session[:search], {category_filter: "tours"}).businesses
		
		@arts_pins = {}
		@food_pins = {}
		@tour_pins = {}
		for i in 0..4

			#arts_pin = {}
			#food_pin = {}
			#tour_pin = {}

			arts_result = arts_response[i]
			food_result = food_response[i]
			tour_result = tour_response[i]

			arts_title = arts_result.name.downcase
			food_title = food_result.name.downcase
			tour_title = tour_result.name.downcase
			#arts_pin["name"] = arts_result.name
			#food_pin["name"] = food_result.name
			#tour_pin["name"] = tour_result.name

			arts_pin = YelpPin.find_by title: arts_title
			food_pin = YelpPin.find_by title: food_title
			tour_pin = YelpPin.find_by title: tour_title

			if arts_pin.nil?
				arts_pin = YelpPin.new
				arts_pin.title = arts_title
				arts_pin.rating = arts_result.rating
				arts_pin.latitude = arts_result.location.coordinate.latitude
				arts_pin.longitude = arts_result.location.coordinate.longitude
				arts_pin.save()
			end

			if food_pin.nil?
				food_pin = YelpPin.new
				food_pin.title = food_title
				food_pin.rating = food_result.rating
				food_pin.latitude = food_result.location.coordinate.latitude
				food_pin.longitude = food_result.location.coordinate.longitude
				food_pin.save()
			end

			if tour_pin.nil?
				tour_pin = YelpPin.new
				tour_pin.title = tour_title
				tour_pin.rating = tour_result.rating
				tour_pin.latitude = tour_result.location.coordinate.latitude
				tour_pin.longitude = tour_result.location.coordinate.longitude
				tour_pin.save()
			end



			#arts_pin["rating"] = arts_result.rating
			#food_pin["rating"] = food_result.rating
			#tour_pin["rating"] = tour_result.rating
			#arts_pin["latitude"] = arts_result.location.coordinate.latitude
			#food_pin["latitude"] = food_result.location.coordinate.latitude
			#tour_pin["latitude"] = tour_result.location.coordinate.latitude
			#arts_pin["longitude"] = arts_result.location.coordinate.longitude
			#food_pin["longitude"] = food_result.location.coordinate.longitude
			#tour_pin["longitude"] = tour_result.location.coordinate.longitude
			
			@arts_pins[i] = arts_pin
			@food_pins[i] = food_pin
			@tour_pins[i] = tour_pin

		end
		
	end

	def plan_pintrip
		@pin_stops = params[:pin_stops]
		@yelp_stops = params[:yelp_stops]
		@stops = Array.new

		city = City.find_by city: session[:search].downcase

		old_trip = Trip.find_by completed: 0
		unless old_trip.nil?
			old_trip.completed = 1
			old_trip.save()
		end

		pintrip = Trip.new		
		pintrip.city_id = city.id
		pintrip.user_id = session[:user]
		pintrip.completed = 0
		pintrip.save()

		session[:trip] = pintrip.id

		unless @pin_stops.nil?
			@pin_stops.each do |pin_stop|
				pin = Pin.find pin_stop
				stop = Stop.new
				stop.title = pin.title
				stop.latitude = pin.latitude
				stop.longitude = pin.longitude
				stop.rating = nil
				stop.pin_id = pin.id
				stop.pin_type = "Pin"
				stop.time = nil
				stop.trip_id = pintrip.id
				stop.save()

				@stops.push(stop)
			end
		end

		unless @yelp_stops.nil?
			@yelp_stops.each do |yelp_stop|
				yelp_pin = YelpPin.find yelp_stop
				stop = Stop.new
				stop.title = yelp_pin.title
				stop.latitude = yelp_pin.latitude
				stop.longitude = yelp_pin.longitude
				stop.rating = nil
				stop.pin_id = yelp_pin.id
				stop.pin_type = "YelpPin"
				stop.time = nil
				stop.trip_id = pintrip.id
				stop.save()

				@stops.push(stop)
			end
		end

	end

	def finalize_trip
		require 'rubygems'          # This line not needed for ruby > 1.8
		require 'twilio-ruby'

		@trip = Trip.find session[:trip]

		current_time = Time.now

		@trip.stops.each do |stop|
			time = params["stop" + stop.id.to_s + "-time"]
			stop.time = time
			stop.save()

			notification_time = stop.time.strftime("%Y/%m/%d %H:%M:00")

			Rufus::Scheduler.singleton.at notification_time do
				Rails.logger.info notification_time + ">> Hey! It's " + stop.time.strftime("%I:%M %p") + ", time to go to " + stop.title
				 
				# Get your Account Sid and Auth Token from twilio.com/user/account
				account_sid = 'AC77847336a48c6aa58c4f1c0e7cbf67ae' 
				auth_token = '846b1a6d20f408b88b3a4d78a8604431' 
				@client = Twilio::REST::Client.new account_sid, auth_token
				 
				message = @client.account.messages.create(:body => "Hey! It's " + stop.time.strftime("%I:%M %p") + ", time to go to " + stop.title,
				    :to => '+19894883855', 
						:from => '+19899410565')
			end

		end

		redirect_to pinmap_url
	end

	def pins
		@trip = Trip.find session[:trip]
	end

	def set_rating
		rating_id = params[:id]
		score = params[:score]

		rating = Rating.find rating_id
		rating.score = score
		rating.save()

		redirect_to pintrip_url
	end

	def pintrip
		@trip = Trip.find session[:trip]
	end

	def pinmap
		@trip = Trip.find session[:trip]
		@city = City.find @trip.city_id
	end

	def blink
		trip = Trip.find_by completed: 0
		user = User.find_by first: "Caitlin"

		rating = Rating.new
		rating.user_id = user.id
		rating.trip_id = trip.id
		rating.score = nil

		latx = params[:lat].to_i / 10000000.0
		longx = params[:long].to_i / 10000000.0

		base_url = "https://maps.googleapis.com/maps/api/place/nearbysearch/json?location="
		base_url += latx.to_s + ","
		base_url += longx.to_s 
		base_url += "&radius=25&key=AIzaSyBNvTW58zon3XwTd-r6oYELh6NDMR7zfuY"

		uri = URI(base_url)
		res = Net::HTTP.get_response(uri).body
		item = JSON.parse(res)["results"][0]
		if item.nil?
			item = JSON.parse(res)["results"]
		end

		lat = item["geometry"]["location"]["lat"]
		lng = item["geometry"]["location"]["lng"]
		title = item["name"].downcase

		pin = Pin.find_by title: title

		if pin.nil?
			pin = Pin.new
			pin.title = title.downcase
			pin.latitude = lat
			pin.longitude = lng
			pin.city_id = trip.city_id
			pin.save()
		end

		rating.pin_id = pin.id

		results = Rating.where(pin_id: pin.id, user_id: user.id, trip_id: trip.id)

		if results.count == 0
			rating.save()
		end

		require "json"
		my_hash = {:SUCCESS => 1,
			:LAT => lat,
		  :LNG => lng,
		  :pin => pin.id,
		  :user => user.id,
		  :trip => trip.id
		}
		@blink = JSON.generate(my_hash)
		render json: @blink
	end

	def login
		fb_id = params[:id]

		if session[:userID].nil?
			session[:userID] = params[:userID]
		else
			session[:userID] = "NOT FOUND"
		end

		user = User.find_by fb_id: fb_id

		if user.nil?
			user = User.new
			user.fb_id = fb_id
			user.first = params[:first]
			user.last = params[:last]
			user.save
		end

		session[:user] = user.id
	end

	def logout
		session = nil
		redirect_to index_url
	end

	def cheat
	end

	def drop_rating
		trip = Trip.find session[:trip]
		rating = Rating.new
		rating.user_id = session[:user]
		rating.trip_id = session[:trip]
		rating.score = nil

		lat = params[:lat]
		long = params[:long]

		base_url = "https://maps.googleapis.com/maps/api/place/nearbysearch/json?location="
		base_url += params[:lat] + ","
		base_url += params[:long] 
		base_url += "&radius=25&key=AIzaSyBNvTW58zon3XwTd-r6oYELh6NDMR7zfuY"

		uri = URI(base_url)
		res = Net::HTTP.get_response(uri).body
		@item = JSON.parse(res)["results"][0]
		@lat = @item["geometry"]["location"]["lat"]
		@lng = @item["geometry"]["location"]["lng"]
		@title = @item["name"]

		pin = Pin.find_by title: @title.downcase

		if pin.nil?
			pin = Pin.new
			pin.title = @title.downcase
			pin.latitude = @lat
			pin.longitude = @lng
			pin.city_id = trip.city_id
			pin.save()
		end

		rating.pin_id = pin.id
		rating.save()
		redirect_to pintrip_url
	end

	private

	def authenticate
		if session[:user].nil?
			redirect_to index_url
		end
	end

	def recording
		#redirect_to dashboard_url
	end

end
