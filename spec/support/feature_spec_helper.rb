shared_examples 'Drabkirn Quotes Header Content' do
  scenario "Drabkirn Quotes Header Content" do
    expect(page).to have_selector('img[alt="Drabkirn Logo"]')
    expect(page).to have_selector('img[src="/content/images/drabkirn-logo-180x180.png"]')
    expect(page).to have_selector('h1', text: 'Drabkirn')
    expect(page).to have_selector('h2', text: 'Quotes')
    expect(page).to have_selector('p', text: /We write thoughts in the form to redefine inspiration in a few words/)

    find('img[alt="Drabkirn Logo"]').click
    expect(page.current_path).to eq "/"
  end
end

shared_examples 'Drabkirn Quotes Footer Content' do
  scenario "Drabkirn Quotes Footer Content" do
    expect(page).to have_selector('.footer-legal p', text: '2019-2020 - Drabkirn')
    expect(page).to have_link('Drabkirn', href: 'https://drabkirn.cdadityang.xyz')
    expect(page).to have_selector('.footer-baaaaaa p', text: '@Baaaaaa')

    expect(page).to have_link('Subscribe', href: 'https://drabkirn.cdadityang.xyz/subscribe')
    expect(page).to have_link('Palace', href: 'https://drabkirn.cdadityang.xyz/palace')
    expect(page).to have_link('Contact', href: 'mailto:drabkirn@cdadityang.xyz')
  end
end