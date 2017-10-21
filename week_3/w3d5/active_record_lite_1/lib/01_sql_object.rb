require_relative 'db_connection'
require 'active_support/inflector'

# NB: the attr_accessor we wrote in phase 0 is NOT used in the rest
# of this project. It was only a warm up.

class SQLObject
  def self.columns
    # This is an N + 1 query; be sure to come back to this once you have
    # defined #all, or maybe some other method...?
    return @columns if @columns

    @columns = DBConnection.execute2(<<-SQL)
    SELECT
      *
    FROM
      '#{self.table_name}';
    SQL

    @columns.first.map!(&:to_sym)
  end

  # Creates getter and setter methods for each column in the table, sets
  # them as the value in the attributes hash to the key that is pointed to by
  # the current column.
  # Got help from Ethan on this one; I was in the right ball park, but heading
  # the wrong direction. I had literally copied and pasted my getter/setter
  # solutions to the 00_attr... exercises, but changed the variables.

  def self.finalize!
    self.columns.each do |col|
      define_method(col) { self.send(:attributes)[col] }
      define_method("#{col}=") do |new_value|
        self.send(:attributes)[col] = new_value
      end
    end
  end



  def self.table_name=(table_name)
    @table_name = table_name
  end

  # Wow, these two table methods took me about...30 minutes...
  # I had the right idea, calling #to_s and #downcase on self, then
  # adding an s, but I wasn't passing that into the getter method, I was
  # trying to do that in my setter method; I had hardcoded 'cats' into the
  # default for #self.table_name, since I saw that was supposed to be returned
  # in the tests; I wasn't tryign to bypass the test, but I thought that
  # was what they wanted. Whoops!

  def self.table_name(table_name = "#{self.to_s.downcase}s")
    @table_name = table_name
  end

  def self.all
    # ...
  end

  def self.parse_all(results)
    # ...
  end

  def self.find(id)
    # ...
  end

  def initialize(params = {})
    p params

    params.each do |attribute, _value|
      if !self.class.columns.include?(attribute.to_sym)
        raise "unknown attribute '#{attribute}'"
      end
    end

    # params.each do |attribute, value|


    # params.each do |attribute, v|


  end

  def attributes
    @attributes ||= {}
  end

  def attribute_values
    # ...
  end

  def insert
    # ...
  end

  def update
    # ...
  end

  def save
    # ...
  end
end
