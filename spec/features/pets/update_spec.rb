require 'rails_helper'

RSpec.describe 'pet update page', type: :feature do
  before(:each) do
    @shelter = Shelter.create(name: 'Old Dog Haven',
      address: '166 Main St',
      city: 'Denver',
      state: 'CO',
      zip: '80208')

  end
  it 'can update an existing pet' do
    pet = Pet.create(image: 'pic 2',
      name: 'Maggie',
      description: 'A thoughtful sentient being',
      age: '2 years',
      sex: 'female',
      shelter: @shelter)

    name = 'Margaret'

    visit "/pets/#{pet.id}"
    click_on 'Update Pet'
    expect(current_path).to eq("/pets/#{pet.id}/edit")
    fill_in 'Name', with: name
    click_on 'Update Pet'
    expect(current_path).to eq("/pets/#{pet.id}")

    expect(page).to have_content('Margaret')
    expect(page).to_not have_content('Maggie')
  end
  it "will not allow an incomplete pet form" do

    image = "https://static.independent.co.uk/s3fs-public/thumbnails/image/2019/10/23/12/panda-dog-2.jpg"
    name = "Panda Dog"
    description = "Panda Dog looks like a panda, but is totally a dog. Yay!"
    age = "4 months"
    sex = "female"

    visit "/shelters/#{@shelter.id}/pets"

    click_on "Create Pet"

    expect(current_path).to eq("/shelters/#{@shelter.id}/pets/new")

    fill_in "Image", with: image
    fill_in "Name", with: ""
    fill_in "Description", with: description
    fill_in "Age", with: age
    fill_in "Sex", with: sex

    click_on "Create Pet"

    expect(page).to have_content("Pet Not Created! Required Content Missing.")
    expect(current_path).to eq("/shelters/#{@shelter.id}/pets/new")

    # title = ""
    # fill_in "Title", with: title
    #
    # click_on "Update Shelter Review"
    #
    # expect(page).to have_content("Shelter Review Not Updated! Required Content Missing.")
    # expect(page).to have_button("Update Shelter Review")

  end
end

# if shelter.save
#   redirect_to "/shelters"
# else
#   flash[:notice] = "Shelter could not be created: incomplete information"
#   redirect_to "/shelters/new"
# end
