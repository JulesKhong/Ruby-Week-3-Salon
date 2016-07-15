require('helper_spec')

describe(Stylist) do

  describe('.all') do
    it("shows the stylist array as empty at first") do
      expect(Stylist.all).to(eq([]))
    end
  end

end
