require 'rails_helper'

RSpec.describe 'shelter pet creation', type: :feature do
  it 'can add a new adoptable pet to the given shelter' do
    shelter = Shelter.create(name: 'Old Dog Haven',
                               address: '166 Main St',
                               city: 'Denver',
                               state: 'CO',
                               zip: '80208')

    image = "https://static.independent.co.uk/s3fs-public/thumbnails/image/2019/10/23/12/panda-dog-2.jpg"
    name = "Panda Dog"
    description = "Panda Dog looks like a panda, but is totally a dog. Yay!"
    age = "4 months"
    sex = "female"

    visit "/shelters/#{shelter.id}/pets"

    click_on "Create Pet"

    expect(current_path).to eq("/shelters/#{shelter.id}/pets/new")

    fill_in "Image", with: image
    fill_in "Name", with: name
    fill_in "Description", with: description
    fill_in "Age", with: age
    fill_in "Sex", with: sex

    click_on "Create Pet"

    expect(current_path).to eq("/shelters/#{shelter.id}/pets/")
    # expect(page).to have_content(image)
    expect(page).to have_content(name)
    expect(page).to have_content(description)
    expect(page).to have_content(age)
    expect(page).to have_content(sex)
    expect(page).to have_content(shelter.name)
    expect(page).to have_content("adoptable")
  end
end
