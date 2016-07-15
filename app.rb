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

get('/stylist/:id') do
  @stylist = Stylist.find(params.fetch('id').to_i)
  @clients = Client.all()
  # @myclients = @stylist.clients
  erb(:stylist)
end

post('/stylist_success') do
  @stylist = params.fetch('stylist_name')
  stylist = Stylist.new({:id => nil, :name => @stylist})
  stylist.save
  erb(:stylist_success)
end

post('/client_success') do
  name = params.fetch('name')
  describe = params.fetch('notes')
  stylist_id = params.fetch('stylist_id').to_i
  @stylist = Stylist.find(stylist_id)
  @client = Client.new({:id => nil, :name => name, :describe => describe, :stylist_id => stylist_id})
  @client.save
  erb(:client_success)
end
