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
    
    QuestionLikes.new(result.first)
  end
  
  def initialize(options = {})
    @id, @question_id, @user_id = 
    options.values_at('id', 'question_id', 'user_id')
  end
end