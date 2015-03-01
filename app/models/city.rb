class City < ActiveRecord::Base
	has_many :pins 
	has_many :trips
end
