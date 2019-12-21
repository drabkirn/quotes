require 'rails_helper'

feature "All Quotes Page - /quotes", js: true do
  
  before(:each) do
    3.times { create(:quote) }
    visit "/quotes"
  end

  it_behaves_like "Drabkirn Quotes Header Content"

  scenario "Main Section Content" do
    expect(page).to have_selector('p', text: 'We usually release a new quote every Tuesday.')
    expect(page).to have_selector('p', text: "Here are all of our quotes")
    
    drabkirnQuotesBaseURL = "https://drabkirn.quotes.cdadityang.xyz"
    allQuotes = Quote.all
    allQuotes.each do |quote|
      expect(page).to have_selector('.card .card-header h3', text: quote.title)
      expect(page).to have_selector('.card .card-content p', text: quote.content)
      expect(page).to have_selector('.card .card-footer a[href="https://twitter.com/intent/tweet?text=' + quote.content + '&hashtags=drabkirn,quote&url=' + drabkirnQuotesBaseURL + '/quotes/' + quote.id.to_s + '&via=drabkirn"]')
      expect(page).to have_selector('.card .card-footer a[href="https://api.whatsapp.com/send?text=' + quote.content + '. See more at ' + drabkirnQuotesBaseURL)
    end

    expect(page).to have_selector('.card .card-footer img[alt="twtr-share-icon"]', count: Quote.all.count)
    expect(page).to have_selector('.card .card-footer img[alt="wapp-share-icon"]', count: Quote.all.count)
  end

  scenario "Navigation links" do
    expect(page).to have_selector('.wide-btn', text: 'Back')
  end

  scenario "Navigate to / when button is clicked" do
    click_on 'Back'
    expect(page.current_path).to eq "/"
  end

  it_behaves_like "Drabkirn Quotes Footer Content"
end