
module Save
  
  def save
    if @id.nil?
      insert
    else 
      update
    end
  end

  def insert
    query = 
    <<-SQL
    INSERT INTO
      #{table_name}(#{variable_names})
    VALUES
      (#{values_string})
    SQL
    
    QuestionsDatabase.instance.execute(query, *set_values)
    
    @id = QuestionsDatabase.instance.last_insert_row_id
    self
  end

  def update
    
    query = 
    <<-SQL
    UPDATE
      #{table_name}
    SET
      #{set_string}
    WHERE
      id = ?
    SQL
      
    QuestionsDatabase.instance.execute(query, *set_values, self.id)
    self
  end
  
  private
  
  def table_name
    self.class.to_s.underscore.pluralize
  end
  
  def set_symbols
    self.instance_variables - [:@id]
  end
  
  def variable_names
    set_symbols.map { |var| var.to_s[1..-1] }
  end
  
  def set_string
    variable_names.map { |name| "#{name} = ?"}.join(', ')
  end
  
  def set_values
    set_symbols.map { |var| self.instance_variable_get(var) }
  end
  
  def values_string
    (["?"]*set_symbols.count).join(', ')
  end
  
end