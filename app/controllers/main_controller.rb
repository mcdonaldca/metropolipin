class MainController < ApplicationController

	def index
		unless session[:user].nil?
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
		#user = User.find session[:user]
		#@display = user.fb_id
		@display = session[:user]
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

end
