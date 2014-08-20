
module Save
  #user
  # id, fname, lname
  #question
  # id, title, body, author_id
  # reply
  # id, question_id, parent_id, author_id, body
  
  def save
    if @id.nil?
      insert
    else 
      update
    end
  end

  def insert
    table_name = self.class.to_s.underscore.pluralize
    set_symbols = self.instance_variables - [:@id]
    variable_names = set_symbols.map { |var| var.to_s[1..-1] }.join(', ')
    values_string = (["?"]*set_symbols.count).join(', ')
    set_values = set_symbols.map { |var| self.instance_variable_get(var) }
  
    QuestionsDatabase.instance.execute(<<-SQL, *set_values)
  
    INSERT INTO
    #{table_name}(#{variable_names})
    VALUES
    (#{values_string})
    SQL
    
    @id = QuestionsDatabase.instance.last_insert_row_id
    self
  end

  def update

    table_name = self.class.to_s.underscore.pluralize
    set_symbols = self.instance_variables - [:@id]
    variable_names = set_symbols.map { |var| var.to_s[1..-1] }
    set_string = variable_names.map {|name| "#{name} = ?"}.join(', ')
    set_values = set_symbols.map { |var| self.instance_variable_get(var) }

    QuestionsDatabase.instance.execute(<<-SQL, *set_symbols, self.id)
  
    UPDATE
      #{table_name}
    SET
      #{set_string}
    WHERE
      id = ?
    SQL
    self
  end

end