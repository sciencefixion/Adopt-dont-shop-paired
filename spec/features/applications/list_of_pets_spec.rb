require 'rails_helper'

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
  end

  it 'can apply to adopt pets from the favorites list' do
    visit '/pets'
    click_on "Maggie"
    click_on "Add Pet to Favorites"
    click_on "Shaggie"
    click_on "Add Pet to Favorites"

    visit '/favorites'

    click_on "Apply to Adopt Pet(s)"

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

    within('.adopt-pending') do
      expect(page).to have_content("Pets pending adoption:")
      expect(page).to have_content("#{@pet_1.name}")
    end

    click_on "#{@pet_1.name}"
    expect(current_path).to eq("/pets/#{@pet_1.id}")
  end
end
