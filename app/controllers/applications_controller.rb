class ApplicationsController < ApplicationController
  def new
    @favorites = Favorite.new(session[:favorite_pets])
    pet_ids = @favorites.contents.keys.map {|id| id.to_i }
    @pets = pet_ids.map { |id| Pet.find(id) }
  end

  def create
    application = Application.create(application_params)
    # require "pry"; binding.pry
    flash[:notice] = "Your application was received. Thank you for applying to adopt. We will be in touch shortly."
    redirect_to "/favorites"
  end

  private
  def application_params
    params.permit(:name, :address, :city, :state, :zip, :phone_number, :description)
  end
end
