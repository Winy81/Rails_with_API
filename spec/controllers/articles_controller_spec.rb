require 'rails_helper'

describe ArticlesController do
	describe '#index' do 
	   subject{get :index}
	   it 'should return success response' do
	   		subject
	   		expect(response).to have_http_status(:ok)
	   end 

	   it 'should return proper json' do
	   		create_list = FactoryBot.create :article
	   		subject
	   		json = JSON.parse(response.body)
	   		json_data = json['data']
	   		expect(json_data.length).to eq(1)
	   		expect(json_data[0]['attributes']).to eq({
	   			"title" => "MyString 1",
	   			"content" => "MyText 1",
	   			"slug" => "MySlug 1"
	   		})
	   end
    end
end