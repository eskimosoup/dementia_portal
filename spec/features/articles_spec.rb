require 'rails_helper'

RSpec.feature "User visits the articles page", type: :feature do

  scenario "articles page with no articles" do
    visit articles_path
    expect_articles_url
    expect(page).to have_content("Currently no articles")
  end

  scenario "viewing article" do
    article = create(:article)
    visit articles_path
    expect_articles_url
    expect(page).to have_content(article.summary)
    first(:css, "a.article").click
    expect(current_url).to eq(article_url(article))
    expect(page).to have_content(article.title)
    expect(page).to have_content(article.content)
  end

  def expect_articles_url
    expect(current_url).to eq(articles_url)
  end
end