class Upload < ActiveRecord::Base
	validates(:name, presence: true, length: {maximum: 30})
	validates(:description, presence: true, length: {maximum: 140})
	validates(:price, presence: true, length: {maximum: 5})
end
