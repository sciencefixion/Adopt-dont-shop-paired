require 'rails_helper'

RSpec.describe 'pet can only be favorited once' do
  it 'can only favorite a pet one time' do
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

    expect(page).to have_content("Add Pet to Favorites")
    click_on 'Add Pet to Favorites'

    expect(page).to have_content("You added #{pet.name} to your favorites!")
    expect(page).to have_content("Favorite Pets: 1")

    visit "/pets/#{pet.id}"

    expect(page).to_not have_content("Add Pet to Favorites")
    expect(page).to have_content("Remove Pet from Favorites")

    click_on "Remove Pet from Favorites"

    expect(current_path).to eq("/pets/#{pet.id}")

    expect(page).to have_content("You removed #{pet.name} to your favorites!")
    expect(page).to have_content("Favorite Pets: 0")
    expect(page).to have_content("Add Pet to Favorites")
  end
end


# User Story 12, Can't Favorite a Pet More Than Once
#
# As a visitor
# After I've favorited a pet
# When I visit that pet's show page
# I no longer see a link to favorite that pet
# But I see a link to remove that pet from
# my favorites
# When I click that link
# A delete request is sent to "/favorites/:pet_id"
# And I'm redirected back to that pets show page
# where I can see a flash message indicating that
# the pet was removed from my favorites
# And I can now see a link to favorite that pet
# And I also see that my favorites indicator has
# decremented by 1
