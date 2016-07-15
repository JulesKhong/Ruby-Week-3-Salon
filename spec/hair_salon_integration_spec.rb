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

describe('viewing details about a stylist',{:type => :feature}) do
  it('shows the stylist detail page when a stylists name is clicked from the homepage') do
    visit('/')
    fill_in('stylist_name', :with => "Montra")
    click_button('Add stylist')
    click_link('Return to dashboard')
    click_link('Montra')
    expect(page).to have_content('About Montra')
  end
end

describe('adding a client to a stylist',{:type => :feature}) do
  it('adds an add form on the stylist page, and shows a success page when clients are added') do
    visit('/')
    fill_in('stylist_name', :with => "Montra")
    click_button('Add stylist')
    click_link('Return to dashboard')
    click_link('Montra')
    fill_in('name', :with => "Mike Vannett")
    fill_in('notes', :with => "Needs reminders to come in")
    click_button('Assign client to Montra')
    expect(page).to have_content("Mike Vannett now has a stylist")
  end
end
