require 'rails_helper'

RSpec.describe User, type: :model do
  describe "#validations" do

  	it "shuold be valid" do
  		user = FactoryBot.create :user
  		expect(user).to be_valid
  	end


  	it "shuold be presence of attributes" do
  		user = FactoryBot.build :user, login: nil, provider: nil
  		expect(user).not_to be_valid
  		expect(user.errors.messages[:login]).to include("can not be blank")
  		expect(user.errors.messages[:provider]).to include("can not be blank")
  	end

  	it 'should be uniqe' do
  		user = FactoryBot.create :user
  		user2 = FactoryBot.build :user, login: user.login
  		expect(user2).not_to be_valid
  		expect(user2.errors.messages[:login]).to include("should be uniqe")

  		user2.login = 'new_login'
  		expect(user2).to be_valid
  	end

  end
end
