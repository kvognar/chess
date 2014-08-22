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
    
    
    
    
    # SELECT
    # polls.*
    # FROM
    #   (
    #   SELECT
    #   polls.* AS poll,
    #   COUNT(questions.id) AS question_count
    #   FROM
    #   polls
    #   JOIN
    #   questions ON polls.id = questions.poll_id
    #   GROUP BY
    #   polls.id
    #   ) AS polls_with_count
    # JOIN
    #   (
    #   SELECT
    #   questions.poll_id AS poll_id,
    #   COUNT(responses.id) AS response_count
    #   FROM
    #   responses
    #   JOIN
    #   questions ON responses.question_id = questions.id
    #   WHERE
    #   responses.user_id = 4
    #   GROUP BY
    #   questions.poll_id
    #   ) AS poll_ids_with_response_count
    # ON poll.id = poll_id
    
    
    SELECT
    responce_counts.responded_polls.*,
    FROM
      (
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
      responses.user_id = 1
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
      
      # ) AS response_counts
  #   JOIN
  #     questions
  #     LEFT OUTER
  #
  #
  #
  #     (
  #     SELECT
  #     polls.* AS total_polls,
  #     COUNT(DISTINCT questions.id) AS total_count
  #     FROM
  #     polls
  #     JOIN
  #     questions ON polls.id = questions.poll_id
  #     JOIN
  #     answer_choices
  #     ON
  #     questions.id = answer_choices.question_id
  #     LEFT OUTER JOIN
  #     responses
  #     ON
  #     answer_choices.id = responses.answer_choice_id
  #     GROUP BY
  #     polls.id
  #     ) AS total_counts
  #
  #   ON response_counts.responded_polls = total_counts.total_polls
  #
  #   WHERE
  #   response_counts.responses_count = total_counts.total_count
  #
      
    
  end
end
