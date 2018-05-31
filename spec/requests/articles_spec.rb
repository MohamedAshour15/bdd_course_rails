require 'rails_helper'
RSpec.describe "Articles" ,type: :request do
before do
  @article=Article.create(title: "Title one",body: "Body of article one")
end
describe 'GET /articles/:id' do
  context 'with existing article' do
    before { get "/articles/#{@article.id}" }
    it "handles existing article" do
      expect(response.status).to eq 200
    end
  end 
  context 'with non-existing article' do
        before { get "/articles/xxxx" }
    it "handles non existing article" do
      expect(response.status).to eq 302
      flash_messsage="The article you are looking for couldn't be found"
      expect(flash[:alert]).to eq flash_messsage
    end
  end
end
end