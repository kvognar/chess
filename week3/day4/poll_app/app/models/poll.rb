# == Schema Information
#
# Table name: polls
#
#  id         :integer          not null, primary key
#  title      :string(255)      not null
#  author_id  :integer          not null
#  created_at :datetime
#  updated_at :datetime
#

class Poll < ActiveRecord::Base
  validates :author_id, :title, presence: true
  
  belongs_to(
    :author,
    class_name: "User",
    foreign_key: :author_id,
    primary_key: :id
  )
  
  has_many(
    :questions,
    class_name: "Question",
    foreign_key: :poll_id,
    primary_key: :id
  )
  
  def n_plus_1_results
    results = Hash.new { |h, k| h[k] = Hash.new(0) }
    questions.each do |question|
      question.answer_choices.each do |choice|
        results[question.text][choice.text] += 1
      end
    end
    results
  end
  
  def results
    results = Hash.new { |h, k| h[k] = Hash.new(0) }
    questions.includes(:answer_choices).each do |question|
      question.answer_choices.each do |choice|
        results[question.text][choice.text] += 1
      end
    end
  end
  
  def best_results
    questions.sql
    
    # SELECT
    # answer_choices.text, COUNT(responses.id ) AS votes
    # FROM
    # answer_choices
    # JOIN
    # responses
    #   ON answer_choices.id = responses.answer_choice_id
    # WHERE
    # answer_choices.question_id = 1
    # GROUP BY
    # answer_choices.id
      #
    # Poll.select
    # .
    #
    #
    
    questions
    .select('answer_choices.*, COUNT(responses.id) AS votes')
    .group('answer_choices.id')
    
    
  end
  
end
