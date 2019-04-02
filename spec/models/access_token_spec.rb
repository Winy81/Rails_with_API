require 'rails_helper'

RSpec.describe AccessToken, type: :model do
  describe '#validations' do
  	it 'should have valid factory' do
  		expect(FactoryBot.create :access_token).to be_valid
  	end

  	it 'should validate token' do
  		token = FactoryBot.create :access_token, token: ""
  		expect(:access_token).not_to be_valid
  	end

  	it 'should be unique' do
  		token = FactoryBot.create :access_token, token: "sample"
  		invalid_token = FactoryBot.build :access_token, token: "sample"
  		expect(invalid_token).not_to be_valid
  		expect(invalid_token.errors.messages[:token]).include('should be uniqe')
  	end

  describe '#new' do
  	it 'should have a token present after initialize' do

  	end
  end


  end
end
