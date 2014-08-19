require 'singleton'
require 'sqlite3'
require_relative 'user'
require_relative 'question'
require_relative 'question_follower'
require_relative 'reply'
require_relative 'question_likes'

class QuestionsDatabase < SQLite3::Database
  include Singleton
  
  def initialize
    super('questions.db')
    
    self.results_as_hash = true
    self.type_translation = true
  end
end




  
breakfast = User.find_by_name("Breakfast", "Supper").first
jasmine = User.find_by_name("Jasmine", "Rice").first

# p breakfast.authored_questions
#
# p jasmine.authored_replies
q = Question.find_by_id(2)
r3 = Reply.find_by_id(3)
# p Question.find_by_author_id(breakfast.id)
# p r3.parent_reply
# p r3.parent_reply.child_replies

p QuestionFollower.followers_for_question_id(2)
p QuestionFollower.followed_questions_for_user_id(2)

p breakfast.followed_questions
p q.followers