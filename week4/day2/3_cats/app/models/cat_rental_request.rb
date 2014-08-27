class CatRentalRequest < ActiveRecord::Base
  validates :cat_id, :start_date, :end_date, :status, presence: true
  validates :status, inclusion: { in: ["PENDING", "APPROVED", "DENIED"] }
  validate :overlapping_approved_requests
  validate :start_before_end
  
  after_initialize do |request|
    request.status ||= "PENDING"
  end
  
  belongs_to(
    :cat,
    class_name: "Cat",
    foreign_key: :cat_id,
    primary_key: :id
  )
  
  has_many(
    :sibling_requests,
    through: :cat,
    source: :rental_requests
  )
  
  def approve!
    CatRentalRequest.transaction do
      self.status = "APPROVED"
      self.save!
      overlapping_requests.each { |request| request.deny! }
    end
  end
  
  def deny!
    self.status = "DENIED"
    self.save!
  end
  
  def pending?
    self.status == "PENDING"
  end
  
  # private
  
  def overlapping_requests 
    where_query = <<-SQL
      cat_rental_requests.id != ? 
    AND 
      (start_date BETWEEN ? AND ? 
      OR end_date BETWEEN ? AND ?)
    SQL
    
    sibling_requests.where(
      where_query, id, start_date, end_date, start_date, end_date
    )
  end
  
  def overlapping_approved_requests
    if overlapping_requests.any? {|req| req.status == 'APPROVED'} &&
      self.status == "APPROVED"
        errors[:rental_request] << "cannot overlap"
    end
  end
  
  def start_before_end
    if start_date > end_date
      errors[:start_date] << "must be before end date"
    end
  end
end
