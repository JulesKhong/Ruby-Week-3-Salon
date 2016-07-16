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
    expect(page).to have_content('Stylist profile: Montra')
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

describe('show the list of clients on the homepage',{:type => :feature}) do
  it('lists all clients on the homepage') do
    visit('/')
    fill_in('stylist_name', :with => "Sam")
    click_button('Add stylist')
    click_link('Return to dashboard')
    click_link('Sam')
    fill_in("name", :with => "Sally Joe")
    fill_in("notes", :with => "wonderful curly hair")
    click_button('Assign client to Sam')
    click_link('Return to dashboard')
    expect(page).to have_content("Sally Joe")
  end
end

describe('deleting stylists',{:type => :feature}) do
  it('deletes a stylist from the database along with their clients') do
    visit('/')
    fill_in('stylist_name', :with => "Sam")
    click_button('Add stylist')
    click_link('Return to dashboard')
    click_link('Sam')
    click_button('Delete Sam')
    expect(page).to have_no_content('Sam')
  end
end

describe('add clients from the dashboard',{:type => :feature}) do
  it('shows all clients on the homepage') do
    visit('/')
    fill_in('stylist_name',  :with => "Sam")
    click_button('Add stylist')
    click_link('Return to dashboard')
    fill_in('name', :with => "George")
    fill_in('notes', :with => "uses black hair dye")
    select('Sam', :from => 'stylists')
    click_button('Add client')
    click_link('Return to dashboard')
    expect(page).to have_content("George")
  end
end

describe('viewing a clients details',{:type => :feature}) do
  it('shows all client details when a user clicks on their name from the homepage') do
    visit('/')
    fill_in('stylist_name',  :with => "Sam")
    click_button('Add stylist')
    click_link('Return to dashboard')
    fill_in('name', :with => "George")
    fill_in('notes', :with => "uses black hair dye")
    select('Sam', :from => 'stylists')
    click_button('Add client')
    expect(page).to have_content("George now has a stylist")
  end
end

describe('updating client notes',{:type => :feature}) do
  it('allows a user to click on a client link from the homepage, and see a form where they can update notes') do
    visit('/')
    fill_in('stylist_name',  :with => "Sam")
    click_button('Add stylist')
    click_link('Return to dashboard')
    fill_in('name', :with => "George")
    fill_in('notes', :with => "uses black hair dye")
    select('Sam', :from => 'stylists')
    click_button('Add client')
    click_link('Return to dashboard')
    click_link('George')
    fill_in('update_notes', :with => "uses blue hair dye")
    click_button('Save update')
    click_link('George')
    expect(page).to have_content("uses blue hair dye")
  end
end
