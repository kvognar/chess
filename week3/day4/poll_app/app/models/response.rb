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
  validate :response_is_not_from_author
  
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

  #will not fire query unless instance is already saved to db
  # has_many(
  #   :sibling_responses,
  #   through: :question,
  #   source: :responses
  # )
  
  def sibling_responses
    #question.responses.where('response.id != ?', self.id)
    question.responses
  end
  
  def response_is_not_from_author
    if question.poll.author == user
      errors[:user] << "cannot vote on own poll"
    end
  end
  
  def user_has_not_already_answered_question
    unless (sibling_responses.where('user_id = ?', self.user_id) - [self]).empty?
      errors[:user] << "cannot vote more than once per question"
    end
  end
  
end
