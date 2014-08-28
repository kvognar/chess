# == Schema Information
#
# Table name: tracks
#
#  id           :integer          not null, primary key
#  title        :string(255)      not null
#  album_id     :integer          not null
#  status       :string(255)      not null
#  lyrics       :text
#  created_at   :datetime
#  updated_at   :datetime
#  track_number :integer          not null
#

class Track < ActiveRecord::Base
  validates :title, :album_id, :status, :track_number, presence: true
  validates :status, inclusion: { in: ["bonus", "regular"] }
  validates :track_number, 
            numericality: :only_integer, 
            uniqueness: { scope: :id }
  
  belongs_to(
    :album,
    class_name: "Album",
    foreign_key: :album_id,
    primary_key: :id
  )
  
end
