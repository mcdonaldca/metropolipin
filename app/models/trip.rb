class Trip < ActiveRecord::Base
	has_many :ratings
	has_many :stops
	belongs_to :city
end
