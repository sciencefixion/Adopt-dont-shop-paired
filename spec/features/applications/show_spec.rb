require "rails_helper"

RSpec.describe 'Application show page', type: :feature do
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
  it 'shows an individual Application' do
    visit "/applications/#{@application.id}"

    expect(page).to have_content("#{@application.name}")
    expect(page).to have_content("#{@application.description}")
    expect(page).to have_content("#{@application.address}")
    expect(page).to have_content("#{@application.city}")
    expect(page).to have_content("#{@application.state}")
    expect(page).to have_content("#{@application.zip}")
    expect(page).to have_content("#{@application.phone_number}")
  end
  it 'can approve an application for a pet' do
    visit "/applications/#{@application.id}"

    expect(page).to have_content("Approve Application for #{@pet_1.name}")

    click_on "Approve Application for #{@pet_1.name}"

    expect(current_path).to eq("/pets/#{@pet_1.id}")

    expect(page).to have_content("Adoption Status: pending")
    expect(page).to have_content("On hold for: Gabby")
  end

  it "will not allow more than one approved applicant per pet" do
    application_2 = Application.create(name: 'Crabby', address: "24 Sliver Street", city: "Springfield", state: "MA", zip: "01108", phone_number: "555-8789", description: "I'm a fish who needs a bicycle.")
    ApplicationPet.create(pet: @pet_1, application: application_2)
    visit "/pets"
    
    click_on "Maggie"
    click_on "Add Pet to Favorites"

    visit "/applicationpets/#{@pet_1.id}"

    click_on "Gabby"
    click_on "Approve Application for Maggie"

    visit "/applicationpets/#{@pet_1.id}"

    click_on "Crabby"
    expect(page).to_not have_content("Approve Application for Maggie")
    expect(page).to have_content("#{@pet_1.name} is already on hold by another applicant.")
  end

  it 'can revoke an approved application' do
    visit "/applications/#{@application_2.id}"

    expect(page).to have_content("Revoke Application for #{@pet_2.name}")
    click_on "Revoke Application for #{@pet_2.name}"

    expect(current_path).to eq("/applications/#{@application_2.id}")
    expect(page).to have_content("Approve Application for #{@pet_2.name}")

    visit "/pets/#{@pet_2.id}"
    expect(page).to have_content("Adoption Status: adoptable")
    expect(page).to_not have_content("On hold for: Hilal")
  end
end
