class Cat < ActiveRecord::Base
  validates :age, numericality: true, presence: true
  validates :birth_date, :name, presence: true
  validates :color, inclusion: { in: [ "red",
     "orange", "brown", "black", "calico" ] }, presence: true
  validates :sex, inclusion: { in: [ "M", "F" ] }, presence: true
  
  has_many(
    :rental_requests,
    class_name: "CatRentalRequest",
    foreign_key: :cat_id,
    primary_key: :id,
    dependent: :destroy
  )
end
