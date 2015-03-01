class MainController < ApplicationController

	before_filter :authenticate, :except => [:index, :login]

	def index
		
		unless params[:admin].nil?
			user = User.find_by first: "Caitlin"
			session[:user] = user.id
			redirect_to dashboard_url
		end

	end

	def login
		fb_id = params[:id]

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

	def dashboard
		@user = User.find session[:user]
	end

	def explore
		if params[:city].nil? or params[:city] == ''
			session[:search] = "new york city"
		else
			session[:search] = params[:city].downcase
		end

		@city = City.find_by city: session[:search]

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


end
