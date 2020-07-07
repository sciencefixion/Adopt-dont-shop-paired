require 'rails_helper'

RSpec.describe 'shelter pets page', type: :feature do
  it 'can show all pets in a given shelter' do
    shelter_1 = Shelter.create(name: 'Old Dog Haven',
                               address: '166 Main St',
                               city: 'Denver',
                               state: 'CO',
                               zip: '80208')
    shelter_2 = Shelter.create(name: 'Blind Cat Rescue',
                               address: '54 Gold Rd',
                               city: 'Golden',
                               state: 'CO',
                               zip: '80419')
    pet_1 = Pet.create(image: 'pic 1',
                        name: 'Max',
                        age: '2 years',
                        sex: 'male',
                        shelter: shelter_1)
    pet_2 = Pet.create(image: 'pic 2',
                        name: 'Maggie',
                        age: '1 year',
                        sex: 'female',
                        shelter: shelter_2)

    visit "/shelters/#{shelter_1.id}/pets"

    # expect(page).to have_content("#{pet_1.image}")
    expect(page).to have_content("#{pet_1.name}")
    expect(page).to have_content("#{pet_1.age}")
    expect(page).to have_content("#{pet_1.sex}")

    # expect(page).to_not have_content("#{pet_2.image}")
    expect(page).to_not have_content("#{pet_2.name}")
    expect(page).to_not have_content("#{pet_2.age}")
    expect(page).to_not have_content("#{pet_2.sex}")
  end
end
