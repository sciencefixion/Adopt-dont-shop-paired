require 'rails_helper'

RSpec.describe "shelters index page", type: :feature do
  it "can see the name of each shelter in the system" do
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

    visit '/shelters/'

    expect(page).to have_content("#{shelter_1.name}")
    expect(page).to have_content("#{shelter_2.name}")
  end
end
