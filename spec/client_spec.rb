require('helper_spec')

describe(Client) do

  describe('.all') do
    it('returns the client array as empty at first') do
      expect(Client.all).to(eq([]))
    end
  end

  describe('#==') do
    it("equates two clients when they share the same name and id") do
      client = Client.new({:id => nil, :name => "Hingyi", :describe => "Keeps his beard at about a quarter inch", :stylist_id => 2})
      client_two = Client.new({:id => nil, :name => "Hingyi", :describe => "Keeps his beard at about a quarter inch", :stylist_id => 2})
      expect(client).to(eq(client_two))
    end
  end

  describe('#save') do
    it('saves a client to the hair_salon database') do
      stylist = Stylist.new({:id => nil, :name => "Leon"})
      stylist.save
      client = Client.new({:id => nil, :name => "Rose", :describe => "Loves change and new ideas", :stylist_id => stylist.id })
      client.save
      expect(Client.all).to(eq([client]))
    end
  end

  describe('.find') do
    it("uses an id value to find and return a client") do
      stylist = Stylist.new({:id => nil, :name => "Stephan"})
      stylist.save
      client = Client.new({:id => nil, :name => "Hannah", :describe => "Finicky, ask lots of questions", :stylist_id => stylist.id})
      client.save
      client_two = Client.new({:id => nil, :name => "Hingyi", :describe => "Keeps his beard at about a quarter inch", :stylist_id => stylist.id})
      client_two.save()
      expect(Client.find(client.id)).to(eq(client))
    end
  end

  describe('#delete') do
    it("deletes a client from the database") do
      stylist = Stylist.new({:id => nil, :name => "Stephan"})
      stylist.save
      client = Client.new({:id => nil, :name => "Sam", :describe => "loves pixie cuts", :stylist_id => stylist.id})
      client.save
      client.delete
      expect(Client.all).to(eq([]))
    end
  end

  describe('#update_describe') do
    it("updates client description on the database") do
      stylist = Stylist.new({:id => nil, :name => "Bob"})
      stylist.save
      client = Client.new({:id => nil, :name => "Destiny", :describe => "Does not like trying new things", :stylist_id => stylist.id})
      client.save
      client.update_describe({:describe => "Never ever likes trying new things"})
      expect(client.describe).to(eq("Never ever likes trying new things"))
    end
  end
  describe('#update') do
    it("updates client name on the database") do
      stylist = Stylist.new({:id => nil, :name => "Bob"})
      stylist.save
      client = Client.new({:id => nil, :name => "Destiny", :describe => "Does not like trying new things", :stylist_id => stylist.id})
      client.save
      client.update({:name => "Destinys Child"})
      expect(client.name).to(eq("Destinys Child"))
    end
  end

  describe('#stylist') do
    it("returns the stylist that works with that client") do
      stylist = Stylist.new({:id => nil, :name => "Chaucer"})
      stylist.save
      client = Client.new({:id => nil, :name => "Shalane", :describe => "Free spirit", :stylist_id => stylist.id })
      client.save
      expect((client.stylist).name).to(eq("Chaucer"))
    end
  end


end
