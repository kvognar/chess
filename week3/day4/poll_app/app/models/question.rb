# == Schema Information
#
# Table name: questions
#
#  id         :integer          not null, primary key
#  text       :text             not null
#  poll_id    :integer          not null
#  created_at :datetime
#  updated_at :datetime
#

class Question < ActiveRecord::Base
  validates :poll_id, :text, presence: true
  
  belongs_to(
    :poll,
    class_name: "Poll",
    foreign_key: :poll_id,
    primary_key: :id
  )
  
  has_many(
    :answer_choices,
    class_name: "AnswerChoice",
    foreign_key: :question_id,
    primary_key: :id
  )
  
  has_many(
    :responses,
    through: :answer_choices,
    source: :responses
  )
  
  def results
    # n + 1 woohoo
    # results = Hash.new(0)
    # answer_choices.each do |choice|
    #   results[choice.text] = choice.responses.length
    # end
    #
    # answer_choices.includes(:responses).each do |choice|
    #   results[choice.text] = choice.responses.length
    # end
    # results
    AnswerChoice.find_by_sql(<<-SQL, self.id)
    SELECT
    answer_choices.*
    FROM
    answer_choices
    JOIN
    responses
      ON answer_choices.id = responses.answer_choice_id
    WHERE
    answer_choices.question_id = ?
    SQL
  end
  
  def sql_results
    Hash[Question.joins(:answer_choices)
      .joins('LEFT OUTER JOIN responses ON answer_choices.id = responses.answer_choice_id')
      .group('answer_choices.id')
      .where('questions.id = ?', self.id)
      .pluck('answer_choices.text, COUNT(responses.id)')]
  end
end
