class ApplicationPet < ApplicationRecord
  validates_presence_of :pet_id, :application_id
  belongs_to :pets
  belongs_to :applications
end
