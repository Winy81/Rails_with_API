class User < ApplicationRecord
	validates_presence_of :login, message: 'can not be blank'
	validates_presence_of :provider, message: 'can not be blank'
	validates_uniqueness_of :login, message: "should be uniqe"

	has_many :article, dependent: :destroy

	has_one :access_token, dependent: :destroy

end
