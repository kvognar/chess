class Question
  
  attr_accessor :id, :title, :body, :author_id

  def self.all
    results = QuestionsDatabase.instance.execute('SELECT * FROM questions')
    results.map { |result| Question.new(result) }
  end
  
  def self.find_by_id(id)
      
    result = QuestionsDatabase.instance.execute(<<-SQL, id)
    
    SELECT
      *
    FROM
      questions
    WHERE
      id = ?
    SQL
    
    Question.new(result.first)
  end
  
  def self.find_by_author_id(author_id)
    results = QuestionsDatabase.instance.execute(<<-SQL, author_id)
    
    SELECT
      *
    FROM
      questions
    WHERE
      author_id = ?
    SQL

    results.map { |result| Question.new(result) }
  end
  
  def self.most_followed(n)
    QuestionFollower.most_followed_questions(n)
  end
  
  def self.most_liked(n)
    QuestionLike.most_liked_questions(n)
  end
  
  def initialize(options = {})
    @id, @title, @body, @author_id = 
    options.values_at('id', 'title', 'body', 'author_id')
  end
  
  def author
    results = QuestionsDatabase.instance.execute(<<-SQL, @author_id)
    
    SELECT
      *
    FROM
      users
    WHERE
      users.id = ?
    SQL
    
    User.new(results.first)
  end
  
  def replies
    Reply.find_by_question_id(self.id)
  end
  
  def followers
    QuestionFollower.followers_for_question_id(self.id)
  end
  
  def likers
    QuestionLike.likers_for_question_id(self.id)
  end
  
  def num_likes
    QuestionLike.num_likes_for_question_id(self.id)
  end
end






