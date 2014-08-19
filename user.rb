class User
  attr_accessor :id, :fname, :lname
  
  def self.all
    results = QuestionsDatabase.instance.execute('SELECT * FROM users')
    results.map { |result| User.new(result) }
  end
  
  def self.find_by_name(fname, lname)
    results = QuestionsDatabase.instance.execute(<<-SQL, fname, lname)
    
    SELECT
      *
    FROM
      users
    WHERE
      fname = ? AND lname = ?
    SQL
    
    results.map { |result| User.new(result) }
  end
  
  def self.find_by_id(id)
    result = QuestionsDatabase.instance.execute(<<-SQL, id)
    
    SELECT
    *
    FROM
    users
    WHERE
    id = ?
    SQL
    
    User.new(result.first)
  end
  
  def initialize(options = {})
    @id, @fname, @lname = 
    options.values_at('id', 'fname', 'lname')
  end
  
  def authored_questions
    results = QuestionsDatabase.instance.execute(<<-SQL, @id)
    
    SELECT
    *
    FROM
    questions
    WHERE
    author_id = ?
    SQL
    
    results.map { |result| Question.new(result) }
  end
  
  def authored_replies
    Reply.find_by_user(@id)
  end
  
  def followed_questions
    QuestionFollower.followed_questions_for_user_id(@id)
  end
end