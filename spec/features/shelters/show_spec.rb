require 'rails_helper'

RSpec.describe "shelter id page", type: :feature do
  it "can see the information for a shelter by its name" do
    shelter_1 = Shelter.create(name: 'Old Dog Haven',
                               address: '166 Main St',
                               city: 'Denver',
                               state: 'CO',
                               zip: '80208')

    shelter_1_id = shelter_1[:id]

    visit "/shelters/#{shelter_1_id}"

    expect(page).to have_content("#{shelter_1.name}")
    expect(page).to have_content("#{shelter_1.address}")
    expect(page).to have_content("#{shelter_1.city}")
    expect(page).to have_content("#{shelter_1.state}")
    expect(page).to have_content("#{shelter_1.zip}")
  end
  it "displays statistics for the given shelter" do
    shelter = Shelter.create(name: 'Old Dog Haven',
                             address: '166 Main St',
                             city: 'Denver',
                             state: 'CO',
                             zip: '80208')
    pet_1 = Pet.create(image: 'https://i.ytimg.com/vi/2xZsXlSj-ts/maxresdefault.jpg',
                       name: 'Maggie',
                       description: 'A thoughtful sentient being',
                       age: '2 years',
                       sex: 'female',
                       shelter: shelter)
    pet_2 = Pet.create(image: 'https://i.ytimg.com/vi/2xZsXlSj-ts/maxresdefault.jpg',
                       name: 'Shaggie',
                       description: 'Another thoughtful sentient being',
                       age: '3 years',
                       sex: 'male',
                       shelter: shelter)
    pet_3 = Pet.create(image: 'https://i.ytimg.com/vi/2xZsXlSj-ts/maxresdefault.jpg',
                       name: 'Jim Bob Duggar',
                       description: 'A human being',
                       age: '60 something years',
                       sex: 'male',
                       shelter: shelter)
    ShelterReview.create(title: "Superb Owl!", rating: 5, content: "I got a great owl and it almost never tears my face off.", image: "https://i.redd.it/aztbxwx592951.jpg", shelter_id: shelter.id)
    ShelterReview.create(title: "Mediocre Owl.", rating: 3, content: "This owls tears off my face 50% of the time.", image: "https://i.redd.it/aztbxwx592951.jpg", shelter_id: shelter.id)
    application_1 = Application.create(name: 'Gabby', address: "24 Silver Street", city: "Springfield", state: "MA", zip: "01108", phone_number: "555-8987", description: "I'm a clown who needs a sidekick.")
    ApplicationPet.create(pet: pet_1, application: application_1)
    application_2 = Application.create(name: 'Hilal', address: "19 Gold Street", city: "Springfield", state: "MA", zip: "01108", phone_number: "555-8987", description: "I love all the pets.")
    ApplicationPet.create(pet: pet_2, application: application_2)
    ApplicationPet.create(pet: pet_3, application: application_2)
    visit "/shelters/#{shelter.id}"

    expect(page).to have_content("Total Number of Pets: 3")
    expect(page).to have_content("Average Rating: 4")
    expect(page).to have_content("Number of Applications: 2")
  end
end
