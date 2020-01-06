require 'rails_helper'

feature "Drabkirn Quotes Homepage", js: true do
  
  before(:each) do
    3.times { create(:quote) }
    visit "/"
  end

  it_behaves_like "Drabkirn Quotes Header Content"

  scenario "Main Section Content" do
    getRandomQuoteTextFromDOM = find('blockquote').native.attribute('innerText')
    allQuotesContents = Quote.all.pluck(:content)
    randomQuoteIndex = 0
    allQuotesContents.each_with_index do |quote, index|
      randomQuoteIndex = index if quote == getRandomQuoteTextFromDOM
    end
    getrandomQuoteTextFromDB = allQuotesContents[randomQuoteIndex]

    expect(page).to have_selector('p', text: 'We usually release a new quote every Tuesday.')
    expect(page).to have_selector('p', text: "Here's a random quote for you to get started")

    expect(page).to have_selector('blockquote', text: getrandomQuoteTextFromDB)
  end

  scenario "Navigation links" do
    expect(page).to have_selector('.btn', text: 'All Quotes')
    expect(page).to have_link('Subscribe', href: 'https://drabkirn.cdadityang.xyz/subscribe')
  end

  scenario "Navigate to /quotes when button is clicked" do
    click_on 'All Quotes'
    expect(page.current_path).to eq "/quotes"
  end

  it_behaves_like "Drabkirn Quotes Footer Content"
end