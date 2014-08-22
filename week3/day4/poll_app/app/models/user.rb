# == Schema Information
#
# Table name: users
#
#  id         :integer          not null, primary key
#  user_name  :string(255)      not null
#  created_at :datetime
#  updated_at :datetime
#

class User < ActiveRecord::Base
  validates :user_name, presence: true, uniqueness: true 
  has_many(
    :polls,
    class_name: "Poll",
    foreign_key: :author_id,
    primary_key: :id
  )
  
  has_many(
    :responses,
    class_name: "Response",
    foreign_key: :user_id,
    primary_key: :id
  )
  
  def completed_polls
    
    <<-SQL
      SELECT
      polls_x.* AS responded_polls,
      COUNT(DISTINCT responses.id) AS responses_count,
      COUNT(DISTINCT questions.id)
      FROM
      polls AS polls_x
      JOIN
      questions ON polls_x.id = questions.poll_id
      JOIN
      answer_choices
      ON
      questions.id = answer_choices.question_id
      LEFT OUTER JOIN
      responses
      ON
      answer_choices.id = responses.answer_choice_id
      WHERE
      responses.user_id = 3
      GROUP BY
      polls_x.id
      HAVING
      COUNT(DISTINCT responses.id) = (
        SELECT
        COUNT(DISTINCT questions.id)
        FROM
        polls AS polls_y
        JOIN
        questions
        ON
        polls_y.id = questions.poll_id
        WHERE
        polls_x.id = polls_y.id
        GROUP BY
        polls_y.id
        )
        
        SQL

      
    
  end
end
