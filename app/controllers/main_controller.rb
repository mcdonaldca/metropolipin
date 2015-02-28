class MainController < ApplicationController

	def index
	end

	def login
		unless params["test"].nil?
			session[:val] = params["test"]
		end
	end

end
