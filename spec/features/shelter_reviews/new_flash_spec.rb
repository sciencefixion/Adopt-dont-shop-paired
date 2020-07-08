require "rails_helper"

RSpec.describe "New Shelter Review Flash Message" do
  it "requires the user enter title, rating, and content or displays a message" do
    shelter = Shelter.create!(name: "Gimme Shelter", address: "1234 What Street", city: "Springfield", state: "IN", zip: "12345")

    visit "/shelters/#{shelter.id}"
    click_on "Add New Shelter Review"

    click_on "Create New Shelter Review"

    expect(page).to have_content("Shelter Review Not Created! Required Content Missing.")
    expect(page).to have_button("Create New Shelter Review")
    
  end
end
