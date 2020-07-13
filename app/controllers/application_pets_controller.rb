class ApplicationPetsController < ApplicationController
  def show
    @pet = Pet.find(params[:id])
    app_pets = ApplicationPet.where(pet_id: @pet.id).pluck(:application_id)
    @applications = app_pets.map { |app_pet| Application.find(app_pet) }
  end
end
