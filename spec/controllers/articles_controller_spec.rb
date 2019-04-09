require 'rails_helper'
require 'database_cleaner'

DatabaseCleaner.strategy = :truncation

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
  	DatabaseCleaner.clean

    subject { post :create }

    context 'when no code provided' do
      it_behaves_like 'forbidden_requests'
    end

    context 'when invalid code provided' do
      before { request.headers['authorization'] = 'Invalid token' }
      it_behaves_like 'forbidden_requests'
    end


    context 'when authorized' do
      user = FactoryBot.create :user
      let(:access_token) { user.create_access_token }
      before { request.headers['authorization'] = "Bearer #{access_token.token}" }

      context 'when invalid parameters provided' do
        let(:invalid_attributes) do
          {
            data: {
              attributes: {
                title: '',
                content: ''
              }
            }
          }
        end

        subject { post :create, params: invalid_attributes }

        it 'should return 422 status code' do
          subject
          expect(response).to have_http_status(:unprocessable_entity)
        end

        it 'should return proper error json' do
          subject
          json = JSON.parse(response.body)
          expect(json['errors']).to include(
            {
              "source" => { "pointer" => "/data/attributes/title" },
              "detail" =>  "can not be blank"
            },
            {
              "source" => { "pointer" => "/data/attributes/content" },
              "detail" =>  "can not be blank"
            },
            {
              "source" => { "pointer" => "/data/attributes/slug" },
              "detail" =>  "can not be blank"
            }
          )
        end


      end

      context 'when success request sent' do
      	user = FactoryBot.create :user
      	let(:access_token) { user.create_access_token }
        before { request.headers['authorization'] = "Bearer #{access_token.token}" }
      	let(:valid_attributes) do
          {
            data: {
              attributes: {
                title: 'Awesome article',
                content: 'Super content',
                slug: 'awesome-article'
              }
            }
          }
        end
    end

    end
   
  end
end