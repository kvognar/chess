# == Schema Information
#
# Table name: responses
#
#  id               :integer          not null, primary key
#  user_id          :integer          not null
#  answer_choice_id :integer          not null
#  created_at       :datetime
#  updated_at       :datetime
#

class Response < ActiveRecord::Base
  validates :user_id, :answer_choice_id, presence: true
  validate :user_has_not_already_answered_question
  
  belongs_to(
    :user,
    class_name: 'User',
    foreign_key: :user_id,
    primary_key: :id
  )
  
  belongs_to(
    :answer_choice,
    class_name: 'AnswerChoice',
    foreign_key: :answer_choice_id,
    primary_key: :id
  )
  
  has_one(
    :question,
    through: :answer_choice,
    source: :question
  )

  has_many(
    :sibling_responses,
    through: :question,
    source: :responses
  )
  
  # def sibling_responses
  #   #question.responses.where('response.id != ?', self.id)
  #   question.responses - [self]
  # end
  #
  def stuff
    debugger
    self.sibling_responses
  end
  
  def user_has_not_already_answered_question
    p sibling_responses
    unless (sibling_responses.where('user_id = ?', self.user_id) - [self]).empty?
      errors[:user] << "cannot vote more than once per question"
    end
  end
  
end
