require "rails_helper"

RSpec.describe "New Applications page" do
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
    # @application = Application.create!(name: 'Gabby', address: "24 Silver Street", city: "Springfield", state: "MA", zip: "01108", phone_number: "555-8987", description: "I'm a clown who needs a sidekick.")
    # ApplicationPet.create!(pet: @pet_1, application: @application)
  end

  it 'can apply to adopt pets from the favorites list' do
    visit "/pets"
    click_on "Maggie"
    click_on "Add Pet to Favorites"
    click_on "Shaggie"
    click_on "Add Pet to Favorites"

    visit '/favorites'

    expect(page).to have_content("Apply to Adopt Pet(s)")
    click_on "Apply to Adopt Pet(s)"

    expect(current_path).to eq('/applications/new')
    expect(page).to have_content("Apply to Adopt Pet(s)")
    expect(page).to have_content("Please select the pet(s) you are applying to adopt")
    expect(page).to have_content(@pet_1.name)
    expect(page).to have_content(@pet_2.name)
    expect(page).to have_content("Name")
    expect(page).to have_content("Address")
    expect(page).to have_content("City")
    expect(page).to have_content("State")
    expect(page).to have_content("Zip")
    expect(page).to have_content("Phone number")
    expect(page).to have_button("Submit Adoption Application")

    check("pet_ids[]", match: :first)
    fill_in "Name", with: "Jeff"
    fill_in "Address", with: "Jeff"
    fill_in "City", with: "Jeff"
    fill_in "State", with: "Jeff"
    fill_in "Zip", with: "Jeff"
    fill_in "Phone number", with: "Jeff"
    fill_in "Description", with: "Jeff"

    click_button "Submit Adoption Application"

    expect(current_path).to eq("/favorites")

    within('.pet') do
      expect(page).to_not have_content(@pet_1.name)
    end

    expect(page).to have_content("Your application was received. Thank you for applying to adopt. We will be in touch shortly.")
  end
  it "will not allow an incomplete application" do
    visit '/pets'
    click_on "Maggie"
    click_on "Add Pet to Favorites"
    click_on "Shaggie"
    click_on "Add Pet to Favorites"

    visit '/favorites'

    click_on "Apply to Adopt Pet(s)"

    check("pet_ids[]", match: :first)

    click_on("Submit Adoption Application")

    expect(current_path).to eq("/applications/new")

    expect(page).to have_content("Application Incomplete! The form must be completed to submit an application.")
  end
end
