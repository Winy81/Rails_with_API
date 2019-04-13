require 'rails_helper'

RSpec.describe Comment, type: :model do
  describe '#validations' do
  	it 'shuold have valid factory' do
  		expect(FactoryBot.build :comment).to be_valid
  	end
  end
end
