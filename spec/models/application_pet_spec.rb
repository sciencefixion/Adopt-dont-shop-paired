require 'rails_helper'

RSpec.describe ApplicationPet do
  describe 'validations' do
    it { should validate_presence_of :pet_id }
    it { should validate_presence_of :application_id }
  end

  describe 'relationships' do
    it { should have_many :pets }
    it { should have_many :applications }
  end
end
