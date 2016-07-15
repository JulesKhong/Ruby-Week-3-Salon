require('pry')

class Client
  attr_reader(:id, :name, :describe, :stylist_id)

  define_method(:initialize) do |attributes|
    @id = attributes[:id]
    @name = attributes.fetch(:name)
    @describe = attributes.fetch(:describe)
    @stylist_id = attributes.fetch(:stylist_id)
  end

  define_singleton_method(:all)do
    returned_clients = DB.exec("SELECT * FROM clients;")
    clients =[]
    returned_clients.each do |client|
      id = client.fetch('id').to_i
      name = client.fetch('name')
      describe = client.fetch('describe')
      stylist_id = client.fetch('stylist_id').to_i
      clients.push(Client.new({:id => id, :name => name, :describe => describe, :stylist_id => stylist_id }))
    end
    clients
  end

  define_method(:==) do |another_client|
    self.name.==(another_client.name).&(self.id.==(another_client.id))
  end

  define_method(:save) do
    result = DB.exec("INSERT INTO clients (name, describe, stylist_id) VALUES ('#{@name}', '#{@describe}', #{@stylist_id}) RETURNING id;")
    @id = result.first.fetch('id').to_i
  end

  define_singleton_method(:find) do |id|
    result = DB.exec("SELECT * FROM clients WHERE id = #{id};")
    name = result.first.fetch("name")
    describe = result.first.fetch("describe")
    stylist_id = result.first.fetch("stylist_id")
    Client.new({:id => id, :name => name, :describe => describe, :stylist_id => stylist_id })
  end

  define_method(:delete) do
    DB.exec("DELETE FROM clients WHERE id = #{self.id};")
  end

  define_method(:update_describe) do |attributes|
    @id = self.id
    @describe = attributes.fetch(:describe)
    DB.exec("UPDATE clients SET describe = '#{@describe}' WHERE id = #{@id};")
  end

  define_method(:update) do |attributes|
    @id = self.id
    @name = attributes.fetch(:name)
    DB.exec("UPDATE clients SET name = '#{@name}' WHERE id = #{@id};")
    end

    define_method(:stylist) do
      stylist = DB.exec("SELECT * FROM stylists WHERE id = #{self.stylist_id};")
      id = stylist.first.fetch('id').to_i
      name = stylist.first.fetch('name')
      Stylist.new({:id => id, :name => name})
    end

end
