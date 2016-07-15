require('capybara/rspec')
require('./app')
Capybara.app = Sinatra::Application
set(:show_exceptions, false)

describe('adding a stylist',{:type => :feature}) do
  it('adds a stylist to the database, and lists it on the homepage') do
    visit('/')
    fill_in('stylist_name', :with => "Edward Scissorhands")
    click_button('Add stylist')
    click_link('Return to dashboard')
    expect(page).to have_content("Edward Scissorhands")
  end
end
