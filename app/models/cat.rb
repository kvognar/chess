class Cat < ActiveRecord::Base
  validates :age, numericality: true, presence: true
  validates :birth_date, :name, presence: true
  validates :color, inclusion: { in: [ "red",
     "orange", "brown", "black", "calico" ] }, presence: true
  validates :sex, inclusion: { in: [ "M", "F" ] }, presence: true
end
