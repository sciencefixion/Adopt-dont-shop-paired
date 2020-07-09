class FavoritesController < ApplicationController
  def index
    @pets = Pet.all
    @favorites = Favorite.new(session[:favorites])
  end

  def update
    pet = Pet.find(params[:pet_id])
    session[:favorites] ||= 0
    session[:favorites] += 1
    flash[:notice] = "You added #{pet.name} to your favorites!"
    redirect_to '/pets'
  end
end
