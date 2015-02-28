class MainController < ApplicationController

	def index
	end

	def login
		session[:user_id] = params[:user_id]
	end

	def dashboard
	end

end
