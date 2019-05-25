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
    if self.id
      self.update
    else
      sql = <<-SQL
        INSERT INTO dogs (name, breed)
        VALUES (?, ?)
      SQL

      DB[:conn].execute(sql, name, breed)
      @id = DB[:conn].execute("SELECT last_insert_rowid() FROM dogs")[0][0]

      dog_saved = Dog.new(name: name, breed: breed)
    end
  end

  def self.create(name:, breed:)
    dog = Dog.new(name: name, breed: breed)
    dog.save
    dog
  end

  def self.find_by_id(id_num)
    sql = <<-SQL
      SELECT *
      FROM dogs
      WHERE id = ?
      SQL

    dog_found_by_id = DB[:conn].execute(sql, id_num).flatten

    Dog.new(id: dog_found_by_id[0], name: dog_found_by_id[1], breed: dog_found_by_id[2])
  end

  def self.find_by_name(dog_name)
    sql = <<-SQL
      SELECT *
      FROM dogs
      WHERE name = ?
      SQL

    dog_found_by_name = DB[:conn].execute(sql, dog_name).flatten

    Dog.new(id: dog_found_by_name[0], name: dog_found_by_name[1], breed: dog_found_by_name[2])
  end

  def update
    sql = "UPDATE dogs SET name = ?, breed = ? WHERE id = ?"
    DB[:conn].execute(sql, self.name, self.breed, self.id)
  end

  def self.new_from_db(row)
    id = row[0]
    name = row[1]
    breed = row[2]
    dog_from_db = self.new(id: id, name: name, breed: breed)
  end

  def self.find_or_create_by(name:, breed:)
    dog = DB[:conn].execute("SELECT * FROM dogs WHERE name = ? AND breed = ?", name, breed)
    if !dog.empty?
      dog_data = dog[0]
      dog = Song.new(dog_data[0], dog_data[1], dog_data[2])
    else
      dog = self.create(name: name, breed: breed)
    end
    dog
  end

end
