class MainController < ApplicationController

	def index
	end

	def login
		session[:user_id] = params[:user_id]
	end

	def dashboard
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
