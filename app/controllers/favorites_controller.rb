class FavoritesController < ApplicationController
  def index
  end

  def update
    pet = Pet.find(params[:pet_id])
    session[:counter] ||= 0
    session[:counter] += 1
    flash[:notice] = "You added #{pet.name} to your favorites!"
    redirect_to '/pets'
  end
end
