require_relative '03_associatable'

# Phase V
module Associatable
  # Remember to go back to 04_associatable to write ::assoc_options

  def has_one_through(name, through_name, source_name)
    puts "ahhhh"
    define_method(name) do
      through_options = self.class.assoc_options[through_name]
      source_options = through_options.model_class.assoc_options[source_name]
      puts "though: #{through_options.table_name}, source: #{source_options.table_name}"
      query = DBConnection.execute(<<-SQL)
      SELECT
      #{source_options.table_name}.*
      FROM
      #{through_options.table_name}
      JOIN
      #{source_options.table_name}
      ON
      #{through_options.table_name}.#{source_options.foreign_key} = 
         #{source_options.table_name}.#{source_options.primary_key}
       WHERE
       #{through_options.table_name}.
      SQL
      
      self.class.parse_all(self.class.symbolized(query))
    end
  end
end
