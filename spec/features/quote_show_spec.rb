require 'rails_helper'

feature "/quotes/:id - Shows Quote of requested ID", js: true do
  
  before(:each) do
    3.times { create(:quote) }
    @selected_quote = Quote.last
    visit "/quotes/#{@selected_quote.id}"
  end

  it_behaves_like "Drabkirn Quotes Header Content"

  scenario "Main Section Content" do
    expect(page).to have_selector('h3', text: @selected_quote.title)
    expect(page).to have_selector('blockquote', text: @selected_quote.content)
    expect(page).to have_selector('p', text: @selected_quote.author)
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