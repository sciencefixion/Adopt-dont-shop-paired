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
    pet = shelter.pets.create(pet_params)
    pet.save
    if pet.save
      redirect_to "/shelters/#{shelter.id}/pets/"
    else
      flash[:notice] = "Pet Not Created! Required Content Missing."
      redirect_to "/shelters/#{shelter.id}/pets/new"
    end
  end

  def show
    @pet = Pet.find(params[:id])
    @favorites = session[:favorite_pets]
    app_pet = ApplicationPet.where(pet_id: @pet.id).pluck(:application_id)
    @applicant = Application.find(app_pet)

    if @favorites.nil? || @favorites.keys.include?(@pet.id.to_s) == false
      @link_title = "Add Pet to Favorites"
      @link_method = :patch
    else
      @link_title = "Remove Pet from Favorites"
      @link_method = :delete
    end
  end

  def update
    @pet = Pet.find(params[:id])
    @pet.update(pet_params)
    @pet.save
    redirect_to "/pets/#{@pet.id}"
  end

  def destroy
    Pet.destroy(params[:id])
    unless session[:favorite_pets].nil?
      session[:favorite_pets].delete(params[:id])
    end
    redirect_to '/pets'
  end

  private
  def pet_params
    params.permit(:image, :name, :description, :age, :sex)
  end
end
