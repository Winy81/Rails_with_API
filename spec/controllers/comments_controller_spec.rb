require 'rails_helper'

require 'database_cleaner'

DatabaseCleaner.strategy = :truncation


RSpec.describe CommentsController, type: :controller do
  let(:article) { FactoryBot.create :article }

  DatabaseCleaner.clean


  describe "GET #index" do
    
    it "returns a success response" do
      get :index, params: { article_id: article.id}
      expect(response).to have_http_status(:ok)
    end
  end

  describe "POST #create" do

    let(:valid_attributes) {{ content: 'my awsome comment for article'}}
    let(:invalid_attributes) {{ content: ''}}

    context "with valid params" do
      it "creates a new Comment" do
        expect {
          post :create, params: {article_id: article.id, comment: valid_attributes}
        }.to change(Comment, :count).by(1)
      end

      it "renders a JSON response with the new comment" do

        post :create, params: {article_id: article.id, comment: valid_attributes}
        expect(response).to have_http_status(:created)
        expect(response.content_type).to eq('application/json')
        expect(response.location).to eq(comment_url(Comment.last))
      end
    end

    context "with invalid params" do
      it "renders a JSON response with errors for the new comment" do

        post :create, params: {article_id: article.id, comment: invalid_attributes}
        expect(response.content_type).to eq('application/json')
      end
    end
  end


end
