require 'pry'

class Dog
  attr_accessor :name, :breed

  def initialize(name, breed, id = nil)
    binding.pry
    @name = name
    @breed = breed
    @id = id
  end


end
