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

class Sub < ActiveRecord::Base
  extend FriendlyId
  
  validates :title, :description, :moderator, presence: true
  friendly_id :title, use: [:slugged, :finders]
  
  belongs_to(
    :moderator,
    class_name: "User",
    foreign_key: :moderator_id,
    primary_key: :id
  )
  
  has_many(
    :post_subs,
    class_name: "PostSub",
    foreign_key: :sub_id,
    primary_key: :id,
    inverse_of: :sub
  )
  
  has_many(
    :posts,
    -> { includes :votes },
    through: :post_subs,
    source: :post
  )
  
  
end
