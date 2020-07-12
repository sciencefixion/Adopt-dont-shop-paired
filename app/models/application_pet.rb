class ApplicationPet < ApplicationRecord
  validates_presence_of :pet_ids, :application_ids
  belongs_to :pets
  belongs_to :applications
end
