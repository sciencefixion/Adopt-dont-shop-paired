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

    # expect(page).to have_content("#{pet.image}")
    expect(page).to have_content("#{pet.name}")
    expect(page).to have_content("#{pet.description}")
    expect(page).to have_content("#{pet.age}")
    expect(page).to have_content("#{pet.sex}")
    expect(page).to have_content("adoptable")
  end
    it 'can show all applications for the pet' do
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
    application = Application.create(name: 'Gabby', address: "24 Silver Street", city: "Springfield", state: "MA", zip: "01108", phone_number: "555-8987", description: "I'm a clown who needs a sidekick.")
    app_pet = ApplicationPet.create(pet: pet_1, application: application)

    visit "/pets/#{pet_1.id}"

    expect(page).to have_content("View All Applications for #{pet_1.name}")

    click_on "View All Applications for #{pet_1.name}"
    expect(current_path).to eq("/applicationpets/#{pet_1.id}")

    expect(page).to have_content(application.name)

    click_on "#{application.name}"
    expect(current_path).to eq("/applications/#{application.id}")
  end
#   As a visitor
# When I visit a pets show page
# I see a link to view all applications for this pet
# When I click that link
# I can see a list of all the names of applicants for this pet
# Each applicant's name is a link to their application show page
end
