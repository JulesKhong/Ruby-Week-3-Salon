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

  describe('save') do
    it("saves a stylist to the database") do
      stylist = Stylist.new({:id => nil, :name => "Leon"})
      stylist.save()
      expect(Stylist.all).to(eq([stylist]))
    end
  end

end
