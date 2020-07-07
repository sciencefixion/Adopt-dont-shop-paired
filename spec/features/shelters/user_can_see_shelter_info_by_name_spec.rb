require 'rails_helper'

RSpec.describe "shelter id page", type: :feature do
  it "can see the information for a shelter by its name" do
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
    visit "/shelters/#{shelter_1_id}"

    expect(page).to have_content("#{shelter_1.name}")
    expect(page).to have_content("#{shelter_1.address}")
    expect(page).to have_content("#{shelter_1.city}")
    expect(page).to have_content("#{shelter_1.state}")
    expect(page).to have_content("#{shelter_1.zip}")
  end
end
