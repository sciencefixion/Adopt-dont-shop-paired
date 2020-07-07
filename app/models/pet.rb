class Pet < ApplicationRecord
  validates_presence_of :image, :name, :description, :sex, :age, :adoptable
  belongs_to :shelter
end
