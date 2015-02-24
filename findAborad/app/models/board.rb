class Board < ActiveRecord::Base

	has_attached_file :image, :styles => { :medium => "300x300>", :thumb => "100x100>" }
	validates_attachment_content_type :image, content_type: /\Aimage\/.*\Z/
	geocoded_by :address
	belongs_to  :user
	validates   :title, presence: true
	validates   :price, presence: true
	validates   :description, presence: true
	validates   :address, presence: true
	after_validation :geocode
	
end
