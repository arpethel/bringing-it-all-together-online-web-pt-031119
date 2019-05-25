require 'pry'

class Dog
  attr_accessor :name, :breed
# binding.pry
  def initialize(id:, name:, breed:)
    # binding.pry
    @id = id
    @name = name
    @breed = breed
  end


end
