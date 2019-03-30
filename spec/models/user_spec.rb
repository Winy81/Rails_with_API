require 'rails_helper'

RSpec.describe User, type: :model do
  describe "#validations" do
  	it "shuold be presence of attributes" do
  		user = FactoryBot.create :user
  		expect(user).to be_valid
  	end
  end
end
