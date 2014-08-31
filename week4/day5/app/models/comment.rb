require 'votable'

# == Schema Information
#
# Table name: comments
#
#  id         :integer          not null, primary key
#  content    :text             not null
#  author_id  :integer          not null
#  post_id    :integer
#  created_at :datetime
#  updated_at :datetime
#  parent_id  :integer
#

class Comment < ActiveRecord::Base
  include Votable
  validates :author, :post, :content, presence: true
  delegate :username, to: :author, prefix: true
  
  def top_level_comment?
    self.parent_id.nil?
  end
  
  belongs_to(
    :author,
    class_name: "User",
    foreign_key: :author_id,
    primary_key: :id
  )
  
  belongs_to(
    :post,
    class_name: "Post",
    foreign_key: :post_id,
    primary_key: :id
  )
  
  belongs_to(
    :parent_comment,
    class_name: "Comment",
    foreign_key: :parent_id,
    primary_key: :id
  )
  
  has_many(
    :child_comments,
    class_name: "Comment",
    foreign_key: :parent_id,
    primary_key: :id
  )
  
  
end
