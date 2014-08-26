class Comment < ActiveRecord::Base
  belongs_to(
    :author,
    class_name: "User",
    foreign_key: :author_id,
    primary_key: :id
  )
  
  belongs_to(
    :commentable,
    primary_key: :id,
    foreign_key: :commentable_id,
    polymorphic: true
  )
end
