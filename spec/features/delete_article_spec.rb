require 'rails_helper'

RSpec.feature "Deleting an Article" do
  before do
    @article=Article.create(title: "Title one",body: "Body one")
  end
  scenario "A user deletes an Article" do
    visit"/"
    click_link @article.title
    click_link "Delete Article"
    expect(page).to have_content("Article has been deleted")
    expect(current_path).to eq(articles_path)
  end
end