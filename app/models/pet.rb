class Pet < ApplicationRecord
  validates_presence_of :image, :name, :description, :sex, :age, :adoptable
  belongs_to :shelter
  has_many :applications, through: :application_pets
end
