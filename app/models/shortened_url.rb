require 'securerandom'

class ShortenedUrl < ActiveRecord::Base
  validates :short_url, presence: true, uniqueness: true
  validates :user_id, :long_url, presence: true
  validates :long_url, length: { in: 17..1024 }
  validate :no_flooding_check
  
  belongs_to(
    :submitter,
    class_name: "User",
    primary_key: :id,
    foreign_key: :user_id
  )
  
  has_many(
    :visits,
    class_name: "Visit",
    primary_key: :id,
    foreign_key: :shortened_url_id
  )
  
  has_many(
    :visitors,
    Proc.new { distinct },
    through: :visits,
    source: :visitor
  )
  
  has_many(
    :taggings,
    class_name: "Tagging",
    primary_key: :id,
    foreign_key: :shortened_url_id
  )
  
  has_many(
    :tag_topics,
    through: :taggings,
    source: :tag_topic
  )
  
  def self.random_code
    code = SecureRandom.urlsafe_base64(12)
    while ShortenedUrl.exists?(short_url: code)
      puts "What?! Unbelievable!!"
      code = SecureRandom.urlsafe_base64(12)
    end
    code
  end
  
  def self.create_for_user_and_long_url!(user, long_url)
    ShortenedUrl.create!(user_id: user.id, long_url: long_url, 
      short_url: ShortenedUrl.random_code)
  end
  
  def num_clicks
    visits.count
  end
  
  def num_uniques
    visitors.count
  end
  
  def num_recent_uniques
    time_range = (10.minutes.ago..Time.now)
    visits.where(visits: { created_at: time_range }).distinct.count
  end
  
  def num_very_recent_urls_by_user
    submitter.submitted_urls.where(
          shortened_urls: { created_at: 1.minute.ago..Time.new }).count
  end
  

  
  def no_flooding_check
    if num_very_recent_urls_by_user > 5
      errors[:submitter] << "can't submit more than 5 times per minute"
    end
  end
end