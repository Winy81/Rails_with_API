require 'rails_helper'

RSpec.describe Article, type: :model do
  it 'should be that factory is valid' do
  	expect(FactoryBot.build :article).to be_valid
  end

  it 'should validate the presence of the tilte' do
  	article = FactoryBot.build :article, title:""
  	expect(article).not_to be_valid
  	expect(article.errors.message[:title]).to include("can be blank")
  end

  it 'should validate the presence of the content' do
  	article = FactoryBot.build :article, content:""
  	expect(article).not_to be_valid
  	expect(article.errors.message[:content]).to include("can be blank")
  end


end
