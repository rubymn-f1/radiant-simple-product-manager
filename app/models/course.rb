class Course < ActiveRecord::Base
  belongs_to :category
  
  validates_presence_of :title
  validates_numericality_of :capacity, :price
  validates_inclusion_of :capacity, :in => 1..999
  
end