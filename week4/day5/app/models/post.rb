# == Schema Information
#
# Table name: posts
#
#  id         :integer          not null, primary key
#  title      :string(255)      not null
#  url        :string(255)
#  content    :text
#  author_id  :integer          not null
#  created_at :datetime
#  updated_at :datetime
#

class Post < ActiveRecord::Base
  validates :title, :author, presence: true
  delegate :username, to: :author, prefix: true
  
  belongs_to(
    :author,
    class_name: "User",
    foreign_key: :author_id,
    primary_key: :id    
  )
  
  has_many(
    :post_subs,
    class_name: "PostSub",
    foreign_key: :post_id,
    primary_key: :id,
    inverse_of: :post
  )
  
  has_many(
    :subs,
    through: :post_subs,
    source: :sub
  )
  
  has_many(
    :comments,
    class_name: "Comment",
    foreign_key: :post_id,
    primary_key: :id
  )
  
  has_many(
    :top_level_comments,
    -> { where(parent_id: nil) },
    class_name: "Comment",
    foreign_key: :post_id,
    primary_key: :id
  )
  
  def comments_by_parent_id
    comments_by_parent_id = Hash.new { |h , k| h[k] = Array.new }
    
    comments.each do |comment|
      comments_by_parent_id[comment.parent_id] << comment
    end
    
    comments_by_parent_id
  end
  
end
