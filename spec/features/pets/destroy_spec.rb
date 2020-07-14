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
  it 'cannot delete a pet with an approved application' do
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
    application = Application.create(name: 'Gabby',
                                     address: "24 Silver Street",
                                     city: "Springfield",
                                     state: "MA",
                                     zip: "01108",
                                     phone_number: "555-8987",
                                     description: "I'm a clown who needs a sidekick.")
    ApplicationPet.create(pet: pet, application: application)

    visit "/applications/#{application.id}"

    expect(page).to have_content("Approve Application for #{pet.name}")

    click_on "Approve Application for #{pet.name}"

    visit "/pets/#{pet.id}"

    click_on "Delete Pet"

    expect(page).to have_content("Pet #{pet.name} cannot be deleted: pet is pending adoption")
  end
end
