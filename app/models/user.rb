class User < ApplicationRecord
	validates_presence_of :login, message: 'can not be blank'
	validates_presence_of :provider, message: 'can not be blank'
	validates_uniqueness_of :login, message: "should be uniqe"

end
