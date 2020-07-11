class PetsController < ApplicationController
  def index
    @pets = Pet.all
  end

  def new
    @shelter_id = params[:shelter_id]
  end

  def edit
    @pet = Pet.find(params[:id])
  end

  def create
    shelter = Shelter.find(params[:shelter_id])
    pet = shelter.pets.create!(pet_params)
    pet.save!
    redirect_to "/shelters/#{shelter.id}/pets/"
  end

  def show
    @pet = Pet.find(params[:id])
    @favorites = session[:favorite_pets]
  end

  def update
    @pet = Pet.find(params[:id])
    @pet.update(pet_params)
    redirect_to "/pets/#{@pet.id}"
  end

  def destroy
    Pet.destroy(params[:id])
    redirect_to '/pets'
  end

  private
  def pet_params
    params.permit(:image, :name, :description, :age, :sex)
  end
end
