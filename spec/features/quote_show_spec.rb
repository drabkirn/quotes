require 'rails_helper'

feature "/quotes/:id - Shows Quote of requested ID", js: true do

  before(:each) do
    create(:user, quotes_token: "1d6c93b21328ac04cd88f6d045b99f")
    (1..3).each do |i|
      create(:quote, id: i)
    end
    @selected_quote = Quote.first
    visit "/quotes/#{@selected_quote.id}"
  end

  it_behaves_like "Drabkirn Quotes Header Content"

  scenario "Main Section Content" do
    expect(page).to have_selector('h2', text: @selected_quote.title)
    expect(page).to have_selector('blockquote', text: @selected_quote.content)
    expect(page).to have_selector('p', text: "- #{@selected_quote.author.upcase}")
    expect(page).to have_selector('p', text: /PUBLISHED ON:/)
    @selected_quote.tags.each do |tag|
      expect(page).to have_selector('p', text: tag.upcase)
    end
  end

  scenario "Navigation links" do
    expect(page).to have_selector('.wide-btn', text: 'Back')
  end

  scenario "Navigate to /quotes when button is clicked" do
    click_on 'Back'
    expect(page.current_path).to eq "/quotes"
  end

  it_behaves_like "Drabkirn Quotes Footer Content"
end