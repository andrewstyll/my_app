class Upload < ActiveRecord::Base
	#attr_accessor :current_status
	
	validates(:name, presence: true, length: {maximum: 30})
	validates(:description, presence: true, length: {maximum: 140})
	validates(:price, presence: true, length: {maximum: 5})

	has_attached_file :file 

	validates_attachment_content_type :file, content_type: /\Aapplication\/.*\Z/
	#validates_attachment_content_type :file, content_type: /\Aimage\/.*\Z/
end
