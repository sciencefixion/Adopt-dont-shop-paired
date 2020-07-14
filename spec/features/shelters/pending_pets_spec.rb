require "rails_helper"

RSpec.describe 'Shelters with Pets that have pending status cannot be Deleted', type: :feature do
  before(:each) do
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
    @pet_3 = Pet.create(image: 'https://i.ytimg.com/vi/2xZsXlSj-ts/maxresdefault.jpg',
      name: 'Waggie',
      description: 'Yet another thoughtful sentient being',
      age: '4 years',
      sex: 'female',
      shelter: @shelter)
    @application = Application.create(name: 'Gabby', address: "24 Silver Street", city: "Springfield", state: "MA", zip: "01108", phone_number: "555-8987", description: "I'm a clown who needs a sidekick.")
    ApplicationPet.create(pet: @pet_1, application: @application)
    @application_2 = Application.create(name: 'Hilal', address: "19 Gold Street", city: "Springfield", state: "MA", zip: "01108", phone_number: "555-8987", description: "I love all the pets.")
    ApplicationPet.create(pet: @pet_2, application: @application_2)
    ApplicationPet.create(pet: @pet_3, application: @application_2)
  end
  it 'cannot delete a shelter with pets with pending status' do

    visit "/applications/#{@application.id}"

    expect(page).to have_content("Approve Application for #{@pet_1.name}")

    click_on "Approve Application for #{@pet_1.name}"

    visit "/shelters/#{@shelter.id}"

    click_on "Delete Shelter"

    expect(page).to have_content("Shelter #{@shelter.name} cannot be deleted: contains pet(s) pending adoption")
  end
end
