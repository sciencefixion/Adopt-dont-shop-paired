require 'rails_helper'

RSpec.describe 'pet id page', type: :feature do
  it 'can show individual pet pages' do
    shelter = Shelter.create(name: 'Old Dog Haven',
                               address: '166 Main St',
                               city: 'Denver',
                               state: 'CO',
                               zip: '80208')

    pet = Pet.create(image: 'pic 1',
                        name: 'Max',
                        description: 'Max is a sweet dog!',
                        age: '2 years',
                        sex: 'male',
                        shelter: shelter)

    visit "/pets/#{pet.id}"

    expect(page).to have_content("#{pet.name}")
    expect(page).to have_content("#{pet.description}")
    expect(page).to have_content("#{pet.age}")
    expect(page).to have_content("#{pet.sex}")
    expect(page).to have_content("adoptable")
  end
  
end
