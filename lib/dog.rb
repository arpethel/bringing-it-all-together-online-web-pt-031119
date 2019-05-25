require 'pry'

class Dog
  attr_accessor :id, :name, :breed

  def initialize(name, breed)
    binding.pry
    @id = id
    @name = name
    @breed = breed
  end


end
