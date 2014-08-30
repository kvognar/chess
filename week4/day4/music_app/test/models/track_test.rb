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

require 'test_helper'

class TrackTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
