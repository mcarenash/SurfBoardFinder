class Board < ActiveRecord::Base
	
	geocoded_by :address
	belongs_to  :user
	validates   :title, presence: true
	validates   :price, presence: true
	validates   :description, presence: true
	validates   :address, presence: true
	after_validation :geocode
	
end
