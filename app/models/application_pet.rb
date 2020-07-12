class ApplicationPet < ApplicationRecord
  validates_presence_of :pet_id, :application_id
  belongs_to :pet
  belongs_to :application
end
