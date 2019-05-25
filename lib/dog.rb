require 'pry'

class Dog
  attr_accessor :id, :name, :breed
  # attr_accessor :name, :breed
  # attr_reader :id

  def initialize(id=nil, name:, breed:)
    # binding.pry
    @id = id
    @name = name
    @breed = breed
  end

  def self.create_table
    sql = <<-SQL
      CREATE TABLE dogs (
      id INTEGER PRIMARY KEY,
      name TEXT,
      breed TEXT
      );
    SQL

    DB[:conn].execute(sql)
  end

  def self.drop_table
    sql = <<-SQL
      DROP TABLE dogs
    SQL

    DB[:conn].execute(sql)
  end

  def save
    sql = <<-SQL
      INSERT INTO dogs (name, breed)
      VALUES (?, ?)
    SQL

    DB[:conn].execute(sql, name, breed)
    @id = DB[:conn].execute("SELECT last_insert_rowid() FROM dogs")[0][0]

    # Return an instance of the Dog class
  end

  def self.create(dog_attributes)
    dog_attributes.each do |names, breeds|
      names.each do |name|
      end
      binding.pry
    end


  end

end
