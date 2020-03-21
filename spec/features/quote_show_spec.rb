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

    expect(page).to have_selector('h2', text: "Share em:")
    expect(page).to have_selector('p', text: /Hey, did you know, you can share our quotes directly from below, we save you from heavy-lifting COPY-PASTING them/)
  end

  scenario "Navigation links" do
    expect(page).to have_selector('.wide-btn', text: 'Back')
  end

  scenario "Previous and Next Quotes Navigation links" do
    @selected_quote = Quote.find(2)
    visit "/quotes/#{@selected_quote.id}"
    expect(page).to have_selector('.btn', text: '==>')
    expect(page).to have_selector('.btn', text: '<==')
  end

  scenario "Navigate to Previous Quote" do
    @selected_quote = Quote.find(2)
    visit "/quotes/#{@selected_quote.id}"
    click_on '<=='
    expect(page.current_path).to eq "/quotes/1"
  end

  scenario "Navigate to /quotes when button is clicked" do
    click_on 'Back'
    expect(page.current_path).to eq "/quotes"
  end

  scenario "Navigate to Next Quote" do
    @selected_quote = Quote.find(2)
    visit "/quotes/#{@selected_quote.id}"
    click_on '==>'
    expect(page.current_path).to eq "/quotes/3"
  end

  it_behaves_like "Drabkirn Quotes Footer Content"
end