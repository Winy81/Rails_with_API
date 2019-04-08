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

	   it 'should return articles in the proper order' do
	   		old_article = FactoryBot.create :article
	   		newer_article = FactoryBot.create :article
	   		subject
	   		json = JSON.parse(response.body)
	   		json_data = json['data']
	   		expect(json_data.first['id']).to eq(newer_article.id.to_s)
	   		expect(json_data.last['id']).to eq(old_article.id.to_s)
	   end

	   it 'should paginate reslults' do
	   	FactoryBot.create_list :article, 3
	   	get :index, params: {page:2,per_page:1}
	   	json = JSON.parse(response.body)
	   	json_data = json['data']
	   	expect(json_data.length).to eq 1
	   	second_article = Article.recent.second.id.to_s
	   	expect(json_data.first['id']).to eq(second_article)

	   end
    end


  describe '#show' do
   let(:article) { FactoryBot.create :article }
    subject { get :show, params: { id: article.id } }

    it 'should return success response' do
      subject
      expect(response).to have_http_status(:ok)
    end

    it 'should return proper json' do
      subject
      json = JSON.parse(response.body)
	  json_data = json['data']
      expect(json_data['attributes']).to eq({
          "title" => article.title,
          "content" => article.content,
          "slug" => article.slug
      })
    end
  end



  describe '#create' do
    subject { post :create }

    context 'when no code provided' do
      it_behaves_like 'forbidden_requests'
    end

    context 'when invalid code provided' do
      before { request.headers['authorization'] = 'Invalid token' }
      it_behaves_like 'forbidden_requests'
    end

   
  end
end