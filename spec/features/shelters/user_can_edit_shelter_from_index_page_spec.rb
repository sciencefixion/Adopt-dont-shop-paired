require 'rails_helper'

RSpec.describe 'edit from shelter index page', type: :feature do
  it 'can edit a shelter from the index page' do
    shelter_1 = Shelter.create(name: 'Old Dog Haven',
                               address: '166 Main St',
                               city: 'Denver',
                               state: 'CO',
                               zip: '80208')

    visit '/shelters/'

    expect(page).to have_content('Update Shelter')
  end
end
