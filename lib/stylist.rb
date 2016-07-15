require('pry')

class Stylist
  attr_reader(:id, :name)

  define_method(:initialize) do |attributes|
    @id = attributes[:id]
    @name = attributes.fetch(:name)
  end

  define_singleton_method(:all) do
    returned_stylists = DB.exec("SELECT * FROM stylists;")
    stylists = []
    returned_stylists.each() do |stylist|
      id = stylist.fetch('id').to_i
      name = stylist.fetch('name')
      stylists.push(Stylist.new({:id => id, :name => name}))
    end
    stylists
  end

  define_method(:==) do |another_stylist|
    self.name.==(another_stylist.name).&(self.id.==(another_stylist.id))
  end

end
