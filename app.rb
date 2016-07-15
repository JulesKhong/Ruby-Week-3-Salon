require('sinatra')
require('sinatra/reloader')
require('./lib/client')
require('./lib/stylist')
require('pg')
also_reload('lib/**/*.rb')

DB = PG.connect({:dbname => 'hair_salon_test'})

get('/') do
  @stylists = Stylist.all
  erb(:index)
end

post('/stylist_success') do
  @stylist = params.fetch('stylist_name')
  stylist = Stylist.new({:id => nil, :name => @stylist})
  stylist.save
  erb(:stylist_success)
end
