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

  describe('save') do
    it('saves a client to the hair_salon database') do
      stylist = Stylist.new({:id => nil, :name => "Leon"})
      stylist.save
      client = Client.new({:id => nil, :name => "Rose", :describe => "Loves change and new ideas", :stylist_id => stylist.id })
      client.save
      expect(Client.all).to(eq([client]))
    end
  end


end
