require('sinatra')
require('sinatra/reloader')
require('./lib/client')
require('./lib/stylist')
require('pg')
also_reload('lib/**/*.rb')

DB = PG.connect({:dbname => 'hair_salon_test'})

get('/') do
  @stylists = Stylist.all
  @clients = Client.all
  erb(:index)
end

get('/stylist/:id') do
  @stylist = Stylist.find(params.fetch('id').to_i)
  @clients = @stylist.clients
  # @myclients = @stylist.clients
  erb(:stylist)
end

delete('/stylist/:id') do
  @stylist = Stylist.find(params.fetch('id').to_i)
  @stylist.delete
  @stylists = Stylist.all
  @clients = Client.all
  erb(:index)
end

delete('/client/:id') do
  @client = Client.find(params.fetch('id').to_i)
  @client.delete
  @stylists = Stylist.all
  @clients = Client.all
  erb(:index)
end

post('/stylist_success') do
  @stylist = params.fetch('stylist_name')
  stylist = Stylist.new({:id => nil, :name => @stylist})
  stylist.save
  @stylists = Stylist.all
  erb(:stylist_success)
end

post('/client_success') do
  @name = params.fetch('name')
  @describe = params.fetch('notes')
  @stylist_id = params.fetch('stylist_id').to_i
  @stylist = Stylist.find(@stylist_id)
  @client = Client.new({:id => nil, :name => @name, :describe => @describe, :stylist_id => @stylist_id})
  @client.save
  @clients = Client.all
  erb(:client_success)
end

post('/client_success/home') do
  @name = params.fetch('name')
  @describe = params.fetch('notes')
  @stylist = Stylist.find_name(params.fetch('stylists'))
  @client = Client.new({:id => nil, :name => @name, :describe => @describe, :stylist_id => @stylist.id})
  @client.save
  erb(:client_success)
end
