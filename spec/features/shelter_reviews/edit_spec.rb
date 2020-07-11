require "rails_helper"

RSpec.describe "Edit Shelter Review" do
  describe "On the Shelter Show page" do
    it "shows a link to edit the shelter review" do
      shelter = Shelter.create!(name: "Gimme Shelter", address: "1234 What Street", city: "Springfield", state: "IN", zip: "12345")
      review_1 = ShelterReview.create!(title: "Superb Owl!", rating: 5, content: "I got a great owl and it almost never tears my face off.", image: "https://i.redd.it/aztbxwx592951.jpg", shelter_id: shelter.id)
      review_2 = ShelterReview.create!(title: "Pretty Good Owl!", rating: 4, content: "I got a pretty good owl and I still have most of my face.", shelter_id: shelter.id)

      visit "/shelters/#{shelter.id}"

      expect(page).to have_link("Edit #{review_1.title}")
      expect(page).to have_link("Edit #{review_2.title}")

      click_on "Edit #{review_1.title}"

      expect(current_path).to eq("/shelters/#{shelter.id}/shelter_reviews/#{review_1.id}/edit")

      within("form") do
        page.has_content?("Superb Owl!")
        page.has_content?(review_1.rating)
        page.has_content?(review_1.content)
        # expect(page).to have_content(review_1.image)
      end

      title = "Title"
      rating = 4
      content = "It stinks!"
      image = "mom.jpg"

      fill_in "Title", with: title
      fill_in "Rating", with: rating
      fill_in "Content", with: content
      fill_in "Image", with: image

      click_on "Update Shelter Review"

      expect(current_path).to eq("/shelters/#{shelter.id}/")

      expect(page).to have_content(title)
      expect(page).to have_content(rating)
      expect(page).to have_content(content)

    end
  end
end
