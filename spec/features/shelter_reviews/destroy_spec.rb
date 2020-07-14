require 'rails_helper'

RSpec.describe 'delete a shelter review page' do
  it 'can delete an existing review for a given shelter' do
    shelter = Shelter.create(name: "Gimme Shelter", address: "1234 What Street", city: "Springfield", state: "IN", zip: "12345")
    review_1 = ShelterReview.create(title: "Superb Owl!", rating: 5, content: "I got a great owl and it almost never tears my face off.", image: "https://i.redd.it/aztbxwx592951.jpg", shelter_id: shelter.id)
    review_2 = ShelterReview.create(title: "Pretty Good Owl!", rating: 4, content: "I got a pretty good owl and I still have most of my face.", shelter_id: shelter.id)

    visit "/shelters/#{shelter.id}"

    expect(page).to have_link("Delete #{review_1.title}")
    expect(page).to have_link("Delete #{review_2.title}")

    click_on "Delete #{review_1.title}"

    expect(current_path).to eq("/shelters/#{shelter.id}")
    expect(page).not_to have_content(review_1.title)
    expect(page).to have_content(review_2.title)
  end
end
