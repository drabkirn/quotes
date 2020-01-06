shared_examples 'Drabkirn Quotes Header Content' do
  scenario "Drabkirn Quotes Header Content" do
    expect(page).to have_selector('img[alt="Drabkirn Logo"]')
    expect(page).to have_selector('img[src="/content/images/drabkirn-logo-180x180.png"]')
    expect(page).to have_selector('h1', text: 'Drabkirn Quotes')
    expect(page).to have_selector('p', text: 'Redefined inspiration in some words. Collection of quotes from Drabkirn to change your mindset to achieve more, get inspired, and improve your life.')

    find('img[alt="Drabkirn Logo"]').click
    expect(page.current_path).to eq "/"
  end
end

shared_examples 'Drabkirn Quotes Footer Content' do
  scenario "Drabkirn Quotes Footer Content" do
    expect(page).to have_selector('.footer-legal p', text: '2019 - Drabkirn')
    expect(page).to have_selector('.footer-legal-links a', text: 'Drabkirn')
    expect(page).to have_selector('.footer-baaaaaa p', text: '@Baaaaaa')

    expect(page).to have_link('Contact', href: 'mailto:drabkirn@cdadityang.xyz')
  end
end