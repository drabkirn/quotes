require 'rails_helper'

feature "All Quotes Page - /quotes", js: true do
  
  before(:each) do
    create(:user, quotes_token: "1d6c93b21328ac04cd88f6d045b99f")
    3.times { create(:quote) }
    # Test for Twitter truncate text
    create(:quote, content: Faker::Lorem.sentence(word_count: 50))
    visit "/quotes"
  end

  it_behaves_like "Drabkirn Quotes Header Content"

  scenario "Main Section Content" do
    expect(page).to have_selector('p', text: /We usually release a new quote once a week, but in case we are very imaginative, we may come up with a couple of them per week/)
    expect(page).to have_selector('p', text: /Here are all the quotes straight from our database/)
    
    drabkirnQuotesBaseURL = "https://drabkirn.quotes.cdadityang.xyz"
    allQuotes = Quote.all
    allQuotes.each do |quote|
      expect(page).to have_selector('.card .card-header h3', text: quote.title)
      expect(page).to have_selector('.card .card-content p', text: quote.content)

      twitterCharLimit = 220;
      twitterTruncatedText = "";
      if(quote.content.length > twitterCharLimit)
        twitterTruncatedText = quote.content[0...220] + "..."
      else
        twitterTruncatedText = quote.content
      end

      expect(page).to have_selector('.card .card-footer a[href="https://twitter.com/intent/tweet?text=' + twitterTruncatedText + '%0A&hashtags=drabkirn,quote&url=' + drabkirnQuotesBaseURL + '/quotes/' + quote.id.to_s + '&via=drabkirn"]')
      expect(page).to have_selector('.card .card-footer a[href="https://api.whatsapp.com/send?text=' + quote.content + '%0A%0A See more at ' + drabkirnQuotesBaseURL)
      expect(page).to have_selector('.card .card-footer a[href="https://www.facebook.com/sharer/sharer.php?u=' + drabkirnQuotesBaseURL + '/quotes/' + quote.id.to_s)
      expect(page).to have_selector('.card .card-footer a[href="https://www.linkedin.com/sharing/share-offsite/?url=' + drabkirnQuotesBaseURL + '/quotes/' + quote.id.to_s)
    end

    expect(page).to have_selector('.card .card-footer img[alt="twtr-share-icon"]', count: Quote.all.count)
    expect(page).to have_selector('.card .card-footer img[alt="wapp-share-icon"]', count: Quote.all.count)
    expect(page).to have_selector('.card .card-footer img[alt="fb-share-icon"]', count: Quote.all.count)
    expect(page).to have_selector('.card .card-footer img[alt="linkedin-share-icon"]', count: Quote.all.count)

    70.times { create(:quote) }
    visit "/quotes"
    expect(page).to have_selector('.pagination')
    expect(page).to have_selector('.pagination li', count: 8)
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