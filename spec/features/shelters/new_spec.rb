require 'rails_helper'

RSpec.describe "shelter new page", type: :feature do
  it "can create a new shelter" do

    visit '/shelters/new'

    fill_in 'Name', with: 'Blind Kitten Rescue'
    fill_in 'Address', with: '241 Silver St'
    fill_in 'City', with: 'Colorado Springs'
    fill_in 'State', with: 'CO'
    fill_in 'Zip', with: '80914'
    click_on 'Create Shelter'

    visit '/shelters'

    expect(page).to have_content("Blind Kitten Rescue")
  end
end
