require 'pry'

class Dog
  attr_accessor :id, :name, :breed
  # attr_accessor :name, :breed
  # attr_reader :id
  def initialize(id: nil, name:, breed:)
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

    new_doggy = Dog.new(name: name, breed: breed)
  end

  def self.create(name:, breed:)
    dog = Dog.new(name: name, breed: breed)
    dog.save
    dog
  end

  def self.find_by_id
    sql = <<-SQL
      SELECT *
      FROM dogs
      WHERE id = ?
      SQL

    new_dog = db.execute(sql, id_num).flatten

    Pokemon.new(id: new_pokemon[0], name: new_pokemon[1], type: new_pokemon[2], db: db)
  end

end
