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

    @link_title = ''
    @link_method = ''
     if @favorites.nil? || @favorites.keys.include?(@pet.id.to_s) == false

       @link_title = "Add Pet to Favorites"
       @link_method = :patch
     else
       @link_title = "Remove Pet from Favorites"
       @link_method = :delete
     end

    @adoptable = ''
    require "pry"; binding.pry
    if @pet.adoptable
      @adoptable = "adoptable"
    else
      @adoptable = "pending"
    end
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
