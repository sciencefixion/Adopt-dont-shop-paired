class ApplicationPetsController < ApplicationController
  def show
    @pet = Pet.find(params[:id])
    app_pets = ApplicationPet.where(pet_id: @pet.id).pluck(:application_id)
    @applications = app_pets.map { |app_pet| Application.find(app_pet) }
  end

  def update
    @pet = Pet.find(params[:id])
    app_pet = ApplicationPet.where(pet_id: @pet.id).pluck(:application_id)
    applicant = Application.find(app_pet).pop
    if @pet.adoptable?
      @pet.update(adoptable: "pending")
      @pet.save
      redirect_to "/pets/#{@pet.id}"
    else
      @pet.update(adoptable: "adoptable")
      @pet.save
      redirect_to "/applications/#{applicant.id}"
    end
  end

  private
  def pet_params
    params.permit(:adoptable)
  end
end
