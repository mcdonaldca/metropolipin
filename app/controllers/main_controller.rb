class MainController < ApplicationController

	before_filter :authenticate, :except => [:index, :login, :blink, :blinkex]

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
				food_pin.title = arts_title
				food_pin.rating = food_result.rating
				food_pin.latitude = food_result.location.coordinate.latitude
				food_pin.longitude = food_result.location.coordinate.longitude
				food_pin.save()
			end

			if tour_pin.nil?
				tour_pin = YelpPin.new
				tour_pin.title = arts_title
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
				stop.time = nil
				stop.trip_id = pintrip.id
				stop.save()

				@stops.push(stop)
			end
		end

	end

	def pintrip
	end

	def finalize_trip
	end

	def pinmap
		@trip = Trip.find session[:trip]
		@city = City.find @trip.city_id
	end


	def blink

		if session[:blink].nil?
			session[:blink] = 0
		else
			session[:blink] += 1
		end

		require "json"
		my_hash = {:SUCCESS => 1, :BLINK => session[:blink]}
		@blink = JSON.generate(my_hash)
		render json: @blink
	end

	def blinkex
		require "json"
		my_hash = {:SUCCESS => 1, :LAT => params[:lat], :LONG => params[:long]}
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

	private

	def authenticate
		if session[:user].nil?
			redirect_to index_url
		end
	end

	def make_recording
		redirect_to dashboard_url
	end

end
