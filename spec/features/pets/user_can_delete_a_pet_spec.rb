require 'rails_helper'

RSpec.describe 'delete pet page', type: :feature do
  it 'can delete an existing pet' do
    shelter = Shelter.create!(name: 'Old Dog Haven',
                               address: '166 Main St',
                               city: 'Denver',
                               state: 'CO',
                               zip: '80208')

    pet = Pet.create!(image: 'https://i.ytimg.com/vi/2xZsXlSj-ts/maxresdefault.jpg',
                     name: 'Maggie',
                     description: 'A thoughtful sentient being',
                     age: '2 years',
                     sex: 'female',
                     shelter: shelter)

    visit "/pets/#{pet.id}"
    click_on 'Delete Pet'

    expect(current_path).to eq("/pets")
    expect(page).to_not have_content(pet.id)
  end
end
