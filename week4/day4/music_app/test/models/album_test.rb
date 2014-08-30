# == Schema Information
#
# Table name: albums
#
#  id         :integer          not null, primary key
#  title      :string(255)      not null
#  band_id    :integer          not null
#  venue      :string(255)      not null
#  created_at :datetime
#  updated_at :datetime
#

require 'test_helper'

class AlbumTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
