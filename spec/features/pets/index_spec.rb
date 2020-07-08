require 'rails_helper'

RSpec.describe 'pets index page', type: :feature do
  it 'can see each pet in the system' do
    shelter = Shelter.create!(name: 'Old Dog Haven',
                               address: '166 Main St',
                               city: 'Denver',
                               state: 'CO',
                               zip: '80208')
    pet = Pet.create!(image: 'pic 2',
                     name: 'Maggie',
                     age: '2 years',
                     sex: 'female',
                     shelter: shelter,
                    description: "Oh Maggie, you came and you gave me a turkey!")

    visit '/pets/'

    # expect(page).to have_content("#{pet.image}")
    expect(page).to have_content("#{pet.name}")
    expect(page).to have_content("#{pet.age}")
    expect(page).to have_content("#{pet.sex}")
    expect(page).to have_content("#{pet.shelter.name}")
  end
end
