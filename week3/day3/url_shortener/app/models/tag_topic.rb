class TagTopic < ActiveRecord::Base
  validates :tag_name, inclusion: { in: %w(news sports weather) }
  
  has_many(
    :taggings,
    class_name: "Tagging",
    primary_key: :id,
    foreign_key: :tag_topic_id
  )
  
  has_many(
    :shortened_urls,
    through: :taggings,
    source: :shortened_url
  )
end