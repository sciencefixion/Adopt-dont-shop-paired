class ApplicationPetsController < ApplicationController
  def show
    @pet = Pet.find(params[:id])
    app_pets = ApplicationPet.where(pet_id: @pet.id).pluck(:application_id)
    @applications = app_pets.map { |app_pet| Application.find(app_pet) }
  end

  def update
    pet = Pet.find(params[:id])
    pet.update(adoptable: "pending")
    redirect_to "/pets/#{pet.id}"
  end

  private
  def pet_params
    params.permit(:adoptable)
  end
end
