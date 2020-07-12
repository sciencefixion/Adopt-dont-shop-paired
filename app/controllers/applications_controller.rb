class ApplicationsController < ApplicationController
  def new
    @favorites = Favorite.new(session[:favorite_pets])
    pet_ids = @favorites.contents.keys.map {|id| id.to_i }
    @pets = pet_ids.map { |id| Pet.find(id) }
  end
end
