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

  define_method(:save) do
    result = DB.exec("INSERT INTO stylists (name) VALUES ('#{@name}') RETURNING id;")
    @id = result.first.fetch('id').to_i
  end

  define_singleton_method(:find) do |id|
    result = DB.exec("SELECT * FROM stylists WHERE id = #{id};")
    name = result.first.fetch("name")
    Stylist.new({:id => id, :name => name})
  end

  define_singleton_method(:find_name) do |name|
    result = DB.exec("SELECT * FROM stylists WHERE name='#{name}';")
    id = result.first.fetch("id").to_i
    Stylist.new({:id => id, :name => name})
  end

  define_method(:delete) do
    DB.exec("DELETE FROM stylists WHERE id = #{self.id};")
    DB.exec("DELETE FROM clients WHERE stylist_id = #{self.id};")
  end

  define_method(:update) do |attributes|
    @name = attributes.fetch(:name)
    @id = self.id
    DB.exec("UPDATE stylists SET name = '#{@name}' WHERE id = #{@id};")
  end

  define_method(:clients) do
    stylist_clients = []
    clients = DB.exec("SELECT * FROM clients WHERE stylist_id = #{self.id};")
    clients.each do |client|
      name = client.fetch('name')
      describe = client.fetch('describe')
      id = client.fetch('id').to_i
      stylist_id = client.fetch('stylist_id').to_i
      stylist_clients.push(Client.new({:id => id, :name => name, :describe => describe, :stylist_id => stylist_id}))
    end
    stylist_clients
  end



end
