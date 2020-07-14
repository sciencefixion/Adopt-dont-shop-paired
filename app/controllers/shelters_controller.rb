class SheltersController < ApplicationController
  def index
    @shelters = Shelter.all
  end

  def new
  end

  def create
    shelter = Shelter.create(shelter_params)
    shelter.save
    redirect_to "/shelters"
  end

  def show
    @shelter = Shelter.find(params[:id])
    @shelter_reviews = @shelter.shelter_reviews
  end

  def edit
    @shelter = Shelter.find(params[:id])
  end

  def update
    @shelter = Shelter.find(params[:id])
    @shelter.update(shelter_params)
    redirect_to "/shelters/#{@shelter.id}"
  end

  def destroy
    @shelter = Shelter.find(params[:id])
    pets = Pet.where("shelter_id = #{@shelter.id}")
    can_destroy = true
    unless pets.empty?
      pets.each do |pet|
        can_destroy = false if pet.adoptable == "pending"
      end
    end
    unless can_destroy == false
      pets.each do |pet|
        pet.destroy
      end
    end
    if can_destroy == true
      @shelter.destroy
      redirect_to '/shelters'
    else
      flash[:notice] = "Shelter #{@shelter.name} cannot be deleted: contains pet(s) pending adoption"
      redirect_to "/shelters/#{@shelter.id}"
    end
  end

  def pets
    @shelter = Shelter.find(params[:shelter_id])
    @pets = @shelter.pets
  end

  def new_review
  end

  private
  def shelter_params
    params.permit(:name, :address, :city, :state, :zip)
  end
end
