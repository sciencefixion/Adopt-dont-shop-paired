require 'rails_helper'

RSpec.describe Favorite do

  describe "#total_count" do
    it "can calculate the total number of pets that it holds" do
      favorites = Favorite.new(3)
      expect(favorites.total_count).to eq(3)
    end
  end
end
