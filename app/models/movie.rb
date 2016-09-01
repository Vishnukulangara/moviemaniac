class Movie < ActiveRecord::Base
	has_many :reviews
	belongs_to :user
	has_attached_file :image, styles: { medium: "300x450#", thumb: "200x300#" }, default_url: "/images/:style/missing.png"
  	validates_attachment_content_type :image, content_type: /\Aimage\/.*\z/

  	ratyrate_rateable "rating"
  	
end
