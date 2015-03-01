class Trip < ActiveRecord::Base
	has_many :ratings
	belongs_to :city
end
