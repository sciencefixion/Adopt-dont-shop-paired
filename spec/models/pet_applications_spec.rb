require 'rails_helper'

RSpec.describe PetApplication do
  describe 'validations' do
    it { should validate_presence_of :pet_ids }
    it { should validate_presence_of :application_ids }
  end

  describe 'relationships' do
    it { should have_many :pets }
    it { should have_many :applications }

  end
end
