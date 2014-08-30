# == Schema Information
#
# Table name: notes
#
#  id         :integer          not null, primary key
#  author_id  :integer          not null
#  track_id   :integer          not null
#  body       :text             not null
#  created_at :datetime
#  updated_at :datetime
#

class Note < ActiveRecord::Base
  validates :author_id, :track_id, :body, presence: true
  
  belongs_to(
    :author,
    class_name: "User",
    foreign_key: :author_id,
    primary_key: :id
  )
  
  belongs_to(
    :track,
    class_name: "Track",
    foreign_key: :track_id,
    primary_key: :id
  )
end
