class FavoritesController < ApplicationController
  def index
    @favorites = session[:favorite_pets]
  end

  def update
    pet = Pet.find(params[:pet_id])
    pet_id_str = pet.id.to_s
    session[:favorite_pets] ||= Hash.new(0)
    session[:favorite_pets][pet_id_str] ||= 0
    session[:favorite_pets][pet_id_str] = session[:favorite_pets][pet_id_str] + 1
    flash[:notice] = "You added #{pet.name} to your favorites!"
    redirect_to '/pets'
  end

  def destroy
    pet = Pet.find(params[:pet_id])
    session[:favorite_pets].delete(pet.id.to_s)
    flash[:notice] = "You removed #{pet.name} to your favorites!"
    redirect_to '/favorites'
  end
end
