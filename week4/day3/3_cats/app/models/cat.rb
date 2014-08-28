class Cat < ActiveRecord::Base
  CAT_COLORS = [ "red", "orange", "brown", "black", "calico" ] 
  
  validates :age, numericality: true, presence: true
  validates :birth_date, :name, presence: true
  validates(
    :color, 
    inclusion: { 
      in: CAT_COLORS
    }, 
    presence: true
  )
  
  validates :sex, inclusion: { in: [ "M", "F" ] }, presence: true
  
  belongs_to(
    :owner,
    class_name: "User",
    foreign_key: :user_id,
    primary_key: :id
  )
  
  has_many(
    :rental_requests,
    class_name: "CatRentalRequest",
    foreign_key: :cat_id,
    primary_key: :id,
    dependent: :destroy
  )
end
