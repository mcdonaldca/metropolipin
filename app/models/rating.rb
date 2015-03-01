class Rating < ActiveRecord::Base
	belongs_to :user
	belongs_to :pin
	belongs_to :trip
end
