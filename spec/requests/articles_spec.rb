require 'rails_helper'
RSpec.describe "Articles" ,type: :request do
before do
     @john=User.create(email: "john@example.com",password:"password")
      @fred=User.create(email: "fred@example.com",password:"password")
  @article=Article.create!(title: "Title one",body: "Body of article one",user: @john)
end

describe 'GET /articles/:id/edit' do
  context 'with non-signed in users' do
     before { get "/articles/#{@article.id}/edit" }
  it 'redirects to the signin page' do
    expect(response.status).to eq 302
          flash_messsage="You need to sign in or sign up before continuing."
      expect(flash[:alert]).to eq flash_messsage
  end
end
context 'with signed in user who is not owner' do
  before do
    login_as(@fred)
    get "/articles/#{@article.id}/edit"
  end
  it "redirects to the home page" do
  expect(response.status).to eq 302
        flash_messsage="You can only edit your own article. "
      expect(flash[:alert]).to eq flash_messsage
end
end
context 'with signing in user as owner successful edit' do
  
  before do
    login_as(@john)
     get "/articles/#{@article.id}/edit"
  end
  it "successfully edits article" do
      expect(response.status).to eq 200
  end
end
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