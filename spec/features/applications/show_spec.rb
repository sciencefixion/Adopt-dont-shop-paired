require "rails_helper"

RSpec.describe 'Application show page', type: :feature do
  it 'shows an individual Application' do
    @shelter = Shelter.create(name: 'Old Dog Haven',
      address: '166 Main St',
      city: 'Denver',
      state: 'CO',
      zip: '80208')
    @pet_1 = Pet.create(image: 'https://i.ytimg.com/vi/2xZsXlSj-ts/maxresdefault.jpg',
      name: 'Maggie',
      description: 'A thoughtful sentient being',
      age: '2 years',
      sex: 'female',
      shelter: @shelter)
    @pet_2 = Pet.create(image: 'https://i.ytimg.com/vi/2xZsXlSj-ts/maxresdefault.jpg',
      name: 'Shaggie',
      description: 'Another thoughtful sentient being',
      age: '3 years',
      sex: 'male',
      shelter: @shelter)
    application = Application.create(name: 'Gabby', address: "24 Silver Street", city: "Springfield", state: "MA", zip: "01108", phone_number: "555-8987", description: "I'm a clown who needs a sidekick.")
    ApplicationPet.create(pet: @pet_1, application: application)

    visit "/applications/#{application.id}"

    expect(page).to have_content("#{application.name}")
    expect(page).to have_content("#{application.description}")
    expect(page).to have_content("#{application.address}")
    expect(page).to have_content("#{application.city}")
    expect(page).to have_content("#{application.state}")
    expect(page).to have_content("#{application.zip}")
    expect(page).to have_content("#{application.phone_number}")
  end
end
