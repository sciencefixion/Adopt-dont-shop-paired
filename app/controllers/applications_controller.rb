class ApplicationsController < ApplicationController
  def new
    @favorites = Favorite.new(session[:favorite_pets])
    @pet_ids = @favorites.contents.keys.map {|id| id.to_i }
    @pets = @pet_ids.map { |id| Pet.find(id) }
  end

  def create
    application = Application.create(application_params)
    if application.valid?
      params[:pet_ids].each do |pet_id|
        ApplicationPet.create(pet: Pet.find(pet_id), application: application)
        session[:favorite_pets].delete(pet_id.to_s)
      end
      flash[:notice] = "Your application was received. Thank you for applying to adopt. We will be in touch shortly."
      redirect_to '/favorites'
    else
      flash[:notice] = "Application Incomplete! The form must be completed to submit an application."
      @pets = session[:favorite_pets]
      redirect_to '/applications/new'
    end
  end

  def show
    @application = Application.find(params[:id])
    app_pets = ApplicationPet.where(application_id: @application.id).pluck(:pet_id)
    @pets = app_pets.map { |app_pet| Pet.find(app_pet) }
  end

  private
  def application_params
    params.permit(:pet_ids, :name, :address, :city, :state, :zip, :phone_number, :description)
  end
end
