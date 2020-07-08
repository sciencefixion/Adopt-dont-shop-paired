require "rails_helper"

RSpec.describe "edit shelter review flash message" do
  it "requires the user enter title, rating, and content or displays a message" do
    shelter = Shelter.create!(name: "Gimme Shelter", address: "1234 What Street", city: "Springfield", state: "IN", zip: "12345")
    review_1 = ShelterReview.create!(title: "Superb Owl!", rating: 5, content: "I got a great owl and it almost never tears my face off.", image: "https://i.redd.it/aztbxwx592951.jpg", shelter_id: shelter.id)

    visit "/shelters/#{shelter.id}"

    click_on "Edit #{review_1.title}"

    expect(current_path).to eq("/shelters/#{shelter.id}/shelter_reviews/#{review_1.id}/edit")

    title = ""
    fill_in "Title", with: title

    click_on "Update Shelter Review"

    expect(page).to have_content("Shelter Review Not Updated! Required Content Missing.")
    expect(page).to have_button("Update Shelter Review")
  end
end
