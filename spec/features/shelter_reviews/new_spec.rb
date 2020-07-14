require "rails_helper"

RSpec.describe "new shelter review page" do
  it "can create a new shelter review for a given shelter" do
    shelter = Shelter.create(name: "Gimme Shelter", address: "1234 What Street", city: "Springfield", state: "IN", zip: "12345")

    title = "Superb Owl!"
    rating = 5
    content = "I got a great owl and it almost never tears my face off."
    image = "https://i.redd.it/aztbxwx592951.jpg"

    visit "/shelters/#{shelter.id}"

    click_on "Add New Shelter Review"

    expect(current_path).to eq("/shelters/#{shelter.id}/shelter_reviews/new")

    fill_in "Title", with: title
    fill_in "Rating", with: rating
    fill_in "Content", with: content
    fill_in "Image", with: image

    click_on "Create New Shelter Review"

    expect(current_path).to eq("/shelters/#{shelter.id}")

    expect(page).to have_content(title)
    expect(page).to have_content(rating)
    expect(page).to have_content(content)
    #expect(page).to have_content(image)
  end
end
