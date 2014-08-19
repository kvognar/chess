require 'singleton'
require 'sqlite3'

class QuestionsDatabase < SQLite3::Database
  include Singleton
  
  def initialize
    super('questions.db')
    
    self.results_as_hash = true
    self.type_translation = true
  end
end


class User
  attr_accessor :id, :fname, :lname
  
  def self.all
    results = QuestionsDatabase.instance.execute('SELECT * FROM users')
    results.map { |result| User.new(result) }
  end
  
  def self.find_by_name(fname, lname)
    result = QuestionsDatabase.instance.execute(<<-SQL, fname, lname)
    
    SELECT
      *
    FROM
      users
    WHERE
      fname = ? AND lname = ?
    SQL
    User.new(result.first)
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
    
    User.new(result)
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
    results = QuestionsDatabase.instance.execute(<<-SQL, @id)
    
    SELECT
    *
    FROM
    replies
    WHERE
    author_id = ?
    SQL
    
    results.map { |result| Reply.new(result) }
  end
end


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
    
    Question.new(result)
  end
  
  def self.find_by_author(author_id)
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
  
  def initialize(options = {})
    @id, @title, @body, @author_id = 
    options.values_at('id', 'title', 'body', 'author_id')
  end
  
end


class QuestionFollower
  attr_accessor :id, :question_id, :user_id

  def self.all
    results = QuestionsDatabase.instance.execute('SELECT * FROM question_followers')
    results.map { |result| QuestionFollower.new(result) }
  end
  
  def self.find_by_id(id)
    result = QuestionsDatabase.instance.execute(<<-SQL, id)
    
    SELECT
    *
    FROM
    question_followers
    WHERE
    id = ?
    SQL
    
    QuestionFollower.new(result)
  end
  
  def initialize(options = {})
    @id, @question_id, @user_id =
    options.values_at('id', 'question_id', 'user_id')
  end
end


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
    
    Reply.new(result)
  end
  
  def initialize(options = {})
    @id, @question_id, @parent_id, @author_id, @body = 
    options.values_at('id', 'question_id', 'parent_id', 'author_id', 'body')
  end
end


class QuestionLikes
  attr_accessor :id, :question_id, :user_id
  
  def self.all
    results = QuestionsDatabase.instance.execute('SELECT * FROM question_likes')
    results.map { |result| QuestionLikes.new(result) }
  end
  
  def self.find_by_id(id)
    result = QuestionsDatabase.instance.execute(<<-SQL, id)
    
    SELECT
    *
    FROM
    question_likes
    WHERE
    id = ?
    SQL
    
    QuestionLikes.new(result)
  end
  
  def initialize(options = {})
    @id, @question_id, @user_id = 
    options.values_at('id', 'question_id', 'user_id')
  end
end
  
  
  

  
breakfast = User.find_by_name("Breakfast", "Supper")
jasmine = User.find_by_name("Jasmine", "Rice")
# p breakfast.authored_questions
#
# p jasmine.authored_replies

p Question.find_by_author(jasmine.id)
