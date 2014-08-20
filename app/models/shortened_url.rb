require 'securerandom'

class ShortenedUrl < ActiveRecord::Base
  validates :short_url, presence: true, uniqueness: true
  validates :user_id, :long_url, presence: true
  
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
  
  
  
  def self.random_code
    code = SecureRandom.base64(16)
    while ShortenedUrl.exists?(short_url: code)
      code = SecureRandom.base64(16)
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
end