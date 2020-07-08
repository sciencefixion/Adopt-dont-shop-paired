require 'rails_helper'

RSpec.describe 'shelter delete page', type: :feature do
  it 'can delete an existing shelter' do
    shelter_1 = Shelter.create(name: 'Old Dog Haven',
                               address: '166 Main St',
                               city: 'Denver',
                               state: 'CO',
                               zip: '80208')
    shelter_2 = Shelter.create(name: 'Leave No Paws Behind',
                              address: '692 Mango Drive',
                              city: 'Denver',
                              state: 'CO',
                              zip: '80210')

    shelter_1_id = shelter_1[:id]
    visit "shelters/#{shelter_1_id}"

    click_on 'Delete Shelter'

    visit '/shelters'

    expect(page).not_to have_content('Old Dog Haven')
  end
end
