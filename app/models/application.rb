class Application < ApplicationRecord
  validates_presence_of :pet_ids, :name, :address, :city, :state, :zip, :phone_number, :description
  has_many :pets
end
