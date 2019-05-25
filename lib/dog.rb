require 'pry'

class Dog
  attr_accessor :id, :name, :breed

  def initialize(name:, breed:, id:)
    @id = nil
    @name = name
    @breed = breed
  end


end
