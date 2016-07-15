require('helper_spec')

describe(Stylist) do

  describe('.all') do
    it("shows the stylist array as empty at first") do
      expect(Stylist.all).to(eq([]))
    end
  end

  describe('#==') do
    it("equates two stylists when they share the same id and name") do
      stylist = Stylist.new({:id => 1, :name => "Emmanuel"})
      stylist_two = Stylist.new({:id => 1, :name => "Emmanuel"})
      expect(stylist).to(eq(stylist_two))
    end
  end

  describe('#save') do
    it("saves a stylist to the database") do
      stylist = Stylist.new({:id => nil, :name => "Leon"})
      stylist.save()
      expect(Stylist.all).to(eq([stylist]))
    end
  end

  describe('.find') do
    it("uses an id value to find and return a stylist") do
      stylist = Stylist.new({:id => nil, :name => "Sarah"})
      stylist.save()
      stylist_two = Stylist.new({:id => nil, :name => "Luke"})
      stylist_two.save()
      expect(Stylist.find(stylist_two.id)).to(eq(stylist_two))
    end
  end

  describe('#delete') do
    it('deletes a stylist from the hair_salon database') do
      stylist = Stylist.new({:id => nil, :name => "Phil"})
      stylist.save
      stylist.delete
      expect(Stylist.all).to(eq([]))
    end
  end

  describe('#update') do
    it('updates stylist info on the hair_salon database') do
      stylist = Stylist.new({:id => nil, :name => "Sally"})
      stylist.save
      stylist.update({:name => "Sona"})
      expect(stylist.name).to(eq("Sona"))
    end
  end

  describe('#clients') do
    it("returns a list of clients for a particular stylist") do
      stylist = Stylist.new({:id => nil, :name => "Venice"})
      stylist.save
      client = Client.new({:id => nil, :name => "Rose", :describe => "Rose is four and likes Mickey Mouse", :stylist_id => stylist.id})
      client.save
      client_two = Client.new({:id => nil, :name => "Montra", :describe => "Does not want short hair", :stylist_id => stylist.id })
      client_two.save()
      expect(stylist.clients).to(eq([client, client_two]))
    end
  end

  describe('.find_name') do
    it("finds a stylist based on a name") do
      stylist = Stylist.new({:id => nil, :name => "Jake"})
      stylist.save
      expect(Stylist.find_name("Jake")).to(eq(stylist))
    end
  end

end
