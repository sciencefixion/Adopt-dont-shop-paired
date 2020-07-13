require "rails_helper"

RSpec.describe "application pets index" do

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
  end
  it 'can show all applications for the pet' do
    application = Application.create(name: 'Gabby', address: "24 Silver Street", city: "Springfield", state: "MA", zip: "01108", phone_number: "555-8987", description: "I'm a clown who needs a sidekick.")
    app_pet = ApplicationPet.create(pet: @pet_1, application: application)

    visit "/pets/#{@pet_1.id}"

    expect(page).to have_content("View All Applications for #{@pet_1.name}")

    click_on "View All Applications for #{@pet_1.name}"
    expect(current_path).to eq("/applicationpets/#{@pet_1.id}")

    expect(page).to have_content(application.name)

    click_on "#{application.name}"
    expect(current_path).to eq("/applications/#{application.id}")
  end
  it "shows a message saying no applications for this pet when none exist" do

    visit "/applicationpets/#{@pet_1.id}"

    expect(page).to have_content("#{@pet_1.name} has no applicants yet.")
  end
end
