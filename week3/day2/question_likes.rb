class QuestionLike
  include Save
  attr_accessor :id, :question_id, :user_id
  
  def table_name
  end
  
  def self.all
    results = QuestionsDatabase.instance.execute('SELECT * FROM question_likes')
    results.map { |result| QuestionLike.new(result) }
  end
  
  def self.find_by_id(id)
    results = QuestionsDatabase.instance.execute(<<-SQL, id)
    
    SELECT
      *
    FROM
      question_likes
    WHERE
      id = ?
    SQL
    
    QuestionLikes.new(results.first)
  end
  
  def self.likers_for_question_id(question_id)
    results = QuestionsDatabase.instance.execute(<<-SQL, question_id)
    
    SELECT
      users.*
    FROM
      question_likes
    JOIN
      users
    ON
      user_id = users.id
    WHERE
      question_id = ?
    SQL
    
    results.map { |result| User.new(result) }
  end
  
  def self.num_likes_for_question_id(question_id)
    results = QuestionsDatabase.instance.execute(<<-SQL, question_id)
    
    SELECT
      COUNT(question_id)
    FROM
      question_likes
    WHERE
      question_id = ?
    
    SQL
    
    results.first.values.first
  end
  
  def self.liked_questions_for_user_id(user_id)
    results = QuestionsDatabase.instance.execute(<<-SQL, user_id)
    
    SELECT
      questions.*
    FROM
      question_likes
    JOIN
      questions
    ON
      question_id = questions.id
    WHERE
      user_id = ?
    SQL
    
    results.map { |result| Question.new(result) }
  end
  
  def self.most_liked_questions(n)
    results = QuestionsDatabase.instance.execute(<<-SQL, n)
    
    SELECT
      questions.*
    FROM
      question_likes
    JOIN
      questions
    ON
      questions.id = question_id
    GROUP BY
      questions.id
    ORDER BY
      COUNT(questions.id) DESC
    LIMIT 
      ?
    SQL
    
    results.map { |result| Question.new(result) }  
  end
  
  def initialize(options = {})
    @id, @question_id, @user_id = 
    options.values_at('id', 'question_id', 'user_id')
  end
end