class Person
  attr_reader :id, :last_name, :first_name

  def initialize(data)
    @id = data[:id]
    @last_name = data[:last_name]
    @first_name = data[:first_name]
  end
end
