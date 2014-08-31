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

require 'test_helper'

class VoteTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
