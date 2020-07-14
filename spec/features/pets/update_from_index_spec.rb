require 'rails_helper'

RSpec.describe 'update pet from index page', type: :feature do
  it 'can update an existing pet from the index page' do
    shelter = Shelter.create(name: 'Old Dog Haven',
                               address: '166 Main St',
                               city: 'Denver',
                               state: 'CO',
                               zip: '80208')

    pet = Pet.create(image: 'pic 2',
                     name: 'Maggie',
                     age: '2 years',
                     sex: 'female',
                     shelter: shelter,
                     description: "Neither Gyllenhaal or Smith, sorry.")

    name = 'Margaret'

    visit "/pets"
    click_link 'Update Pet'
    expect(current_path).to eq("/pets/#{pet.id}/edit")
    fill_in 'Name', with: name
    click_on 'Update Pet'
    expect(current_path).to eq("/pets/#{pet.id}")

    expect(page).to have_content('Margaret')
    expect(page).to_not have_content('Maggie')
  end
end
