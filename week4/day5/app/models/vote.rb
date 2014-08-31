# == Schema Information
#
# Table name: votes
#
#  id           :integer          not null, primary key
#  value        :integer
#  votable_id   :integer
#  votable_type :string(255)
#  voter_id     :integer
#  created_at   :datetime
#  updated_at   :datetime
#

class Vote < ActiveRecord::Base
  validates :voter, :votable, presence: true
  validates :votable_id, uniqueness: { scope: [:voter_id, :votable_type] }
  validates :value, inclusion: { in: [1, -1] }
  
  belongs_to(
    :voter,
    class_name: "User",
    foreign_key: :voter_id,
    primary_key: :id
  )
  
  belongs_to(
    :votable,
    polymorphic: true
  )
end
