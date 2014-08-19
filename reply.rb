class Reply
  attr_accessor :id, :question_id, :parent_id, :author_id, :body
  
  def self.all
    results = QuestionsDatabase.instance.execute('SELECT * FROM replies')
    results.map { |result| Reply.new(result) }
  end
  
  def self.find_by_id(id)
    result = QuestionsDatabase.instance.execute(<<-SQL, id)
    
    SELECT
      *
    FROM
      replies
    WHERE
      id = ?
    SQL
    
    Reply.new(result.first)
  end
  
  def self.find_by_question_id(question_id)
    results = QuestionsDatabase.instance.execute(<<-SQL, question_id)
    
    SELECT
      *
    FROM
      replies
    WHERE
      question_id = ?
    SQL
    
    results.map { |result| Reply.new(result) }
  end
  
  def self.find_by_user(user)
    results = QuestionsDatabase.instance.execute(<<-SQL, user)
    
    SELECT
      *
    FROM
      replies
    WHERE
      author_id = ?
    SQL
    
    results.map { |result| Reply.new(result) }
  end
  
  def initialize(options = {})
    @id, @question_id, @parent_id, @author_id, @body = 
    options.values_at('id', 'question_id', 'parent_id', 'author_id', 'body')
  end
  
  def author
    results = QuestionsDatabase.instance.execute(<<-SQL, @author_id)
    
    SELECT
      *
    FROM
      users
    WHERE
      id = ?
    SQL
    
    User.new(results.first)
  end
  
  def question
    results = QuestionsDatabase.instance.execute(<<-SQL, @question_id)
    
    SELECT
      *
    FROM
      questions
    WHERE
      id = ?
    SQL
    
    Question.new(results.first)
  end
  
  def parent_reply
    return nil if @parent_id.nil?
    
    results = QuestionsDatabase.instance.execute(<<-SQL, @parent_id)
    
    SELECT
      *
    FROM
      replies
    WHERE
      id = ?
    SQL
    
    Reply.new(results.first)
  end
  
  def child_replies
    results = QuestionsDatabase.instance.execute(<<-SQL, @id)
    
    SELECT
      *
    FROM
      replies
    WHERE
      parent_id = ?
    SQL
    
    results.map { |result| Reply.new(result) }
  end
  
end





