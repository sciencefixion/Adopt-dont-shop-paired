require "rails_helper"
# When I visit a shelter's show page,
# I see a list of reviews for that shelter
# Each review will have:
# - title
# - rating
# - content
# - an optional picture
RSpec.describe "Shelter Reviews" do
  it "shows all of the particular shelter's reviews on its show page" do
    shelter_1 = Shelter.create!(name: "Gimme Shelter", address: "1234 What Street", city: "Springfield", state: "IN", zip: "12345")
    review_1 = ShelterReview.create!(title: "Superb Owl!", rating: 5, content: "I got a great owl and it almost never tears my face off.", image: "https://i.redd.it/aztbxwx592951.jpg", shelter_id: shelter_1.id)
    review_2 = ShelterReview.create!(title: "Pretty Good Owl!", rating: 4, content: "I got a pretty good owl and I still have most of my face.", shelter_id: shelter_1.id)
    review_3 = ShelterReview.create!(title: "Terrible Owl!", rating: 1, content: "This owl is bullshit!", image: "https://i.redd.it/co7l4ms88h851.jpg", shelter_id: shelter_1.id)

    visit "/shelters/#{shelter_1.id}"

    expect(page).to have_content(review_1.title)
    expect(page).to have_content(review_2.rating)
    expect(page).to have_content(review_3.content)
    # expect(page).to have_content(review_3.image)
    # expect(page).to_not have_content(review_2.image)
  end
end
