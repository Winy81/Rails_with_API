require 'rails_helper'

RSpec.describe User, type: :model do
  describe "#validations" do
  	it "shuold be presence of attributes" do
  		user = FactoryBot.create :user
  		expect(user).to be_valid

  		user = FactoryBot.build :user, login: nil, provider: nil
  		expect(user).not_to be_valid
  		expect(user.errors.messages[:login]).to include("can not be blank")
  		expect(user.errors.messages[:provider]).to include("can not be blank")
  	end
  end
end
