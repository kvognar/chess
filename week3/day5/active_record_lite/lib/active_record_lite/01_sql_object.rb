require_relative 'db_connection'
require 'active_support/inflector'
#NB: the attr_accessor we wrote in phase 0 is NOT used in the rest
#    of this project. It was only a warm up.

class SQLObject
    
  def self.columns
    query_results = DBConnection.execute2(<<-SQL)
    SELECT
    *
    FROM
    #{self.table_name}
    SQL
    query_results.first.map(&:to_sym)
    # ...
  end

  def self.finalize!
    self.columns.each do |column|

      instance_variable_set("@attributes", {})
      
      define_method(column) do
        @attributes[column]
      end
      define_method("#{column}=") do |arg|
        @attributes[column] = arg
      end
    end

  end

  def self.table_name=(table_name)
    @table_name = table_name
    # ...
  end

  def self.table_name
    @table_name ||= self.to_s.pluralize.underscore
    # ...
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

  def attributes
    # ...
  end

  def insert
    # ...
  end

  def initialize
    # ...
  end

  def save
    # ...
  end

  def update
    # ...
  end

  def attribute_values
    # ...
  end
end
