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
    @application = Application.create(name: 'Gabby', address: "24 Silver Street", city: "Springfield", state: "MA", zip: "01108", phone_number: "555-8987", description: "I'm a clown who needs a sidekick.")
    ApplicationPet.create(pet: @pet_1, application: @application)
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

  it "will not allow more than one approved applicant" do
    #     As a visitor
    # When a pet has more than one application made for them
    # And one application has already been approved for them
    # I can not approve any other applications for that pet but all other applications still remain on file (they can be seen on the pets application index page)
    # (This can be done by either taking away the option to approve the application, or having a flash message pop up saying that no more applications can be approved for this pet at this time)
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
end
