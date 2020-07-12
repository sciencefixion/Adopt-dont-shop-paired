class ApplicationsController < ApplicationController
  def new
    @favorites = Favorite.new(session[:favorite_pets])
    pet_ids = @favorites.contents.keys.map {|id| id.to_i }
    @pets = pet_ids.map { |id| Pet.find(id) }
  end

  def create
    application = Application.create(application_params)
  end

  private
  def application_params
    params.permit(:pets, :name, :address, :city, :state, :zip, :phone_number, :description)
  end
end
