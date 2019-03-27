require 'rails_helper'

RSpec.describe Article, type: :model do

 
describe '#validations' do

  it 'should be that factory is valid' do
  	expect(FactoryBot.build :article).to be_valid
  end

  it 'should validate the presence of the tilte' do
  	article = FactoryBot.build :article, title:""
  	expect(article).not_to be_valid
  	expect(article.errors.messages[:title]).to include('can not be blank')
  end

  it 'should validate the presence of the content' do
  	article = FactoryBot.build :article, content:""
  	expect(article).not_to be_valid
  	expect(article.errors.messages[:content]).to include('can not be blank')
  end
   
  it 'should validate the presence of the slug' do
  	article = FactoryBot.build :article, slug:""
  	expect(article).not_to be_valid
  	expect(article.errors.messages[:slug]).to include('can not be blank')
  end

  it 'should validate uniquness the slug' do
    article = FactoryBot.create :article, slug:"same"
    invalid_article = FactoryBot.build :article, slug:"same"
    expect(invalid_article).not_to be_valid
    expect(invalid_article.errors.messages[:slug]).to include('should be uniqe')
  end

end


describe '.recent' do
	it 'should list recent article first' do
 	  old_article = FactoryBot.create :article
 	  newer_article = FactoryBot.create :article
 	  expect(described_class.recent).to eq([newer_article,old_article])
 	  old_article.update_column :created_at, Time.now
 	  expect(described_class.recent).to eq([old_article,newer_article])
	end
end


end
