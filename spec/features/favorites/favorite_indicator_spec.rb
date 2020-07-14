require 'rails_helper'

RSpec.describe 'favorite pet indicator' do
  it 'can display a count of pets in favorites list' do
    shelter = Shelter.create(name: 'Old Dog Haven',
                               address: '166 Main St',
                               city: 'Denver',
                               state: 'CO',
                               zip: '80208')

    pet = Pet.create(image: 'https://i.ytimg.com/vi/2xZsXlSj-ts/maxresdefault.jpg',
                     name: 'Maggie',
                     description: 'A thoughtful sentient being',
                     age: '2 years',
                     sex: 'female',
                     shelter: shelter)

    visit '/pets'

    expect(page).to have_content("Favorite Pets:")

    click_on 'Maggie'
    click_on 'Add Pet to Favorites'

    expect(page).to have_content("You added #{pet.name} to your favorites!")
    expect(page).to have_content("Favorite Pets: 1")
  end
end
