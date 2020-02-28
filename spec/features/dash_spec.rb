require 'rails_helper'

feature "/dash - User dashboard", js: true do

  before(:each) do
    create(:user, quotes_token: "1d6c93b21328ac04cd88f6d045b99f")
    3.times { create(:quote) }
    visit "/dash"
  end

  it_behaves_like "Drabkirn Quotes Header Content"

  scenario "Main Section Content" do
    expect(page).to have_selector('h1', text: "Dashboard")
    expect(page).to have_selector('u', text: "Manage your content and API access, all in one place.")
  end

  scenario "Login the user and check for details" do
    user = create(:user, quotes_token: "1d6c93b21328ac04cd88f6d045b99g")
    visit "/auth/login?auth_token=#{user.auth_token}"
    expect(page).to have_selector('td', text: user.id)
    expect(page).to have_selector('td', text: user.username)
    expect(page).to have_selector('td', text: user.quotes_token)
    expect(page).to have_selector('td', text: user.quotes_api_count)
  end

  scenario "Navigation links of signed out user" do
    expect(page).to have_selector('.wide-btn', text: 'Back')
  end

  scenario "Navigation links of signed in user" do
    user = create(:user, quotes_token: "1d6c93b21328ac04cd88f6d045b99h")
    visit "/auth/login?auth_token=#{user.auth_token}"
    expect(page).to have_selector('.wide-btn', text: 'Sign out local')
    expect(page).to have_selector('.wide-btn', text: 'Delete Account')
    expect(page).to have_selector('.wide-btn', text: 'Back')
  end

  scenario "Navigate to /dash when Sign out local button is clicked when user is signed in" do
    user = create(:user, quotes_token: "1d6c93b21328ac04cd88f6d045b99i")
    visit "/auth/login?auth_token=#{user.auth_token}"
    click_on 'Sign out local'
    expect(page.current_path).to eq "/dash"
  end

  scenario "Signin user > delete user > confirm > navigate to /dash" do
    user = create(:user, quotes_token: "1d6c93b21328ac04cd88f6d045b99j")
    visit "/auth/login?auth_token=#{user.auth_token}"
    click_on 'Delete Account'
    page.driver.browser.switch_to.alert.accept
    expect(page.current_path).to eq "/dash"
  end

  scenario "Signin user > delete user > dismiss > stay on /dash" do
    user = create(:user, quotes_token: "1d6c93b21328ac04cd88f6d045b99j")
    visit "/auth/login?auth_token=#{user.auth_token}"
    click_on 'Delete Account'
    page.driver.browser.switch_to.alert.dismiss
    expect(page.current_path).to eq "/dash"
    expect(page).to have_selector('td', text: user.id)
  end

  scenario "Navigate to / when Back button is clicked when user is signed in" do
    user = create(:user, quotes_token: "1d6c93b21328ac04cd88f6d045b99i")
    visit "/auth/login?auth_token=#{user.auth_token}"
    click_on 'Back'
    expect(page.current_path).to eq "/"
  end

  scenario "Navigate to / when back button is clicked when user is signed out" do
    click_on 'Back'
    expect(page.current_path).to eq "/"
  end

  it_behaves_like "Drabkirn Quotes Footer Content"
end