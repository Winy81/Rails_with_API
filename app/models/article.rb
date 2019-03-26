class Article < ApplicationRecord
	validates_presence_of :title, message: 'can not be blank'
	validates_presence_of :content, message: 'can not be blank'
	
end
