require "rails_helper"

RSpec.describe "Favorites index page" do
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
  it "adds a pet to favorites" do
    visit '/pets'

    click_on "Maggie"
    click_on "Add Pet to Favorites"
    # expect(current_path).to eq("/pets/#{@pet_1.id}")

    visit '/pets'

    click_on "Shaggie"
    click_on "Add Pet to Favorites"
    # expect(current_path).to eq("/pets/#{@pet_2.id}")

    visit '/favorites'

    expect(page).to have_content(@pet_1.name)
    expect(page).to have_link("Remove #{@pet_1.name} from Favorites")

    expect(page).to have_content(@pet_2.name)
    expect(page).to have_link("Remove #{@pet_1.name} from Favorites")


  end
  it "shows text saying No Favorites if favorties is empty" do
    visit '/favorites'

    expect(page).to have_content("You have no favorited pets.")
  end
  it "allows user to remove all favorited pets" do
    visit '/pets'

    click_on "Maggie"
    click_on "Add Pet to Favorites"

    visit '/pets'

    click_on "Shaggie"
    click_on "Add Pet to Favorites"

    visit '/favorites'

    expect(page).to have_content("Remove All Favorited Pets")
    click_on "Remove All Favorited Pets"

    expect(current_path).to eq("/favorites")
    expect(page).to have_content("You have no favorited pets.")
    expect(page).to have_content("Favorite Pets: 0")
  end
end
