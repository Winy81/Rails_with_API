class Article < ApplicationRecord
	validates_presence_of :title, message: 'can not be blank'
	validates_presence_of :content, message: 'can not be blank'
	validates_presence_of :slug, message: 'can not be blank'
	validates_uniqueness_of :slug, message: 'should be uniqe'

	belongs_to :user

	scope :recent, -> {order(created_at: :desc)}
end
