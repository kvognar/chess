# == Schema Information
#
# Table name: subs
#
#  id           :integer          not null, primary key
#  title        :string(255)      not null
#  description  :text             not null
#  moderator_id :integer          not null
#  created_at   :datetime
#  updated_at   :datetime
#  slug         :string(255)
#

require 'test_helper'

class SubTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
